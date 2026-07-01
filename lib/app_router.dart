/// Configuración de enrutamiento con GoRouter.
///
/// Maneja redirecciones basadas en el estado de autenticación (auth guards)
/// y define rutas separadas por rol.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/authentication/domain/entities/user_entity.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';
import 'features/authentication/presentation/screens/change_password_screen.dart';
import 'features/authentication/presentation/screens/forgot_password_screen.dart';
import 'features/authentication/presentation/screens/login_screen.dart';

import 'features/veedor/presentation/screens/veedor_dashboard_screen.dart';
import 'features/veedor/presentation/screens/act_registration_screen.dart';

import 'features/recinto/presentation/screens/recinto_dashboard_screen.dart';
import 'features/recinto/presentation/screens/veedor_management_screen.dart';

import 'features/provincial/presentation/screens/provincial_dashboard_screen.dart';
import 'features/provincial/presentation/screens/precinct_list_screen.dart';
import 'features/provincial/presentation/screens/create_precinct_screen.dart';
import 'features/provincial/presentation/screens/create_coordinator_screen.dart';
import 'features/provincial/presentation/screens/assign_coordinator_screen.dart';

import 'features/veedor/presentation/screens/act_detail_screen.dart';

import 'features/recinto/presentation/screens/create_veedor_screen.dart';
import 'features/recinto/presentation/screens/assign_veedor_screen.dart';
import 'features/recinto/presentation/screens/act_correction_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = authState.isLoggedIn;
      final user = authState.user;
      final isLoggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/forgot-password';

      // 1. No logueado intenta ir a ruta protegida -> login
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      // 2. Logueado intenta ir a login -> redirigir a su dashboard
      if (isLoggedIn && isLoggingIn) {
        if (user != null && user.requiresPasswordChange) {
          return '/change-password';
        }
        if (user != null) {
          switch (user.rol) {
            case UserRole.coordinadorProvincial:
              return '/provincial/dashboard';
            case UserRole.coordinadorRecinto:
              return '/recinto/dashboard';
            case UserRole.veedorMesa:
              return '/veedor/dashboard';
          }
        }
      }

      // 3. Protección de cambio de contraseña
      if (isLoggedIn &&
          user != null &&
          user.requiresPasswordChange &&
          state.matchedLocation != '/change-password') {
        return '/change-password';
      }

      return null;
    },
    routes: [
      // ── Auth ─────────────────────────────────────────────────────────────
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),

      // ── Veedor ───────────────────────────────────────────────────────────
      GoRoute(
        path: '/veedor/dashboard',
        builder: (context, state) => const VeedorDashboardScreen(),
        routes: [
          GoRoute(
            path: 'acta/:id',
            builder: (context, state) {
              final tableId = state.pathParameters['id']!;
              return ActRegistrationScreen(tableId: tableId);
            },
          ),
          GoRoute(
            path: 'detalle/:actId',
            builder: (context, state) {
              final actId = state.pathParameters['actId']!;
              final tableId = state.uri.queryParameters['tableId'] ?? '';
              return ActDetailScreen(actId: actId, tableId: tableId);
            },
          ),
        ],
      ),

      // ── Coordinador Recinto ──────────────────────────────────────────────
      GoRoute(
        path: '/recinto/dashboard',
        builder: (context, state) => const RecintoDashboardScreen(),
        routes: [
          GoRoute(
            path: 'veedores',
            builder: (context, state) => const VeedorManagementScreen(),
          ),
          GoRoute(
            path: 'crear-veedor',
            builder: (context, state) => const CreateVeedorScreen(),
          ),
          GoRoute(
            path: 'asignar/:tableId',
            builder: (context, state) {
              final tableId = state.pathParameters['tableId']!;
              final tableNumber = int.tryParse(state.uri.queryParameters['num'] ?? '0') ?? 0;
              return AssignVeedorScreen(tableId: tableId, tableNumber: tableNumber);
            },
          ),
          GoRoute(
            path: 'corregir/:actId',
            builder: (context, state) {
              final actId = state.pathParameters['actId']!;
              return ActCorrectionScreen(actId: actId);
            },
          ),
        ],
      ),

      // ── Coordinador Provincial ───────────────────────────────────────────
      GoRoute(
        path: '/provincial/dashboard',
        builder: (context, state) => const ProvincialDashboardScreen(),
        routes: [
          GoRoute(
            path: 'recintos',
            builder: (context, state) => const PrecinctListScreen(),
          ),
          GoRoute(
            path: 'crear-recinto',
            builder: (context, state) => const CreatePrecinctScreen(),
          ),
          GoRoute(
            path: 'crear-coordinador',
            builder: (context, state) => const CreateCoordinatorScreen(),
          ),
          GoRoute(
            path: 'asignar-coordinador',
            builder: (context, state) => const AssignCoordinatorScreen(),
          ),
        ],
      ),
    ],
  );
});


