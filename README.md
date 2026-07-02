# Control Electoral Ecuador 2026

Sistema móvil de escrutinio electoral para las elecciones seccionales Ecuador 2026 (Alcaldía y Prefectura). Permite el registro, verificación y consolidación de actas electorales desde dispositivos móviles Android, con soporte offline y sincronización en la nube vía Appwrite.

---

## 1. Descripción del Proyecto

Aplicación Flutter para tres roles jerárquicos:

| Rol | Responsabilidad |
|---|---|
| **Coordinador Provincial** | Crea recintos electorales, asigna coordinadores de recinto, consulta dashboard provincial con resultados consolidados por alcaldía y prefectura. |
| **Coordinador de Recinto** | Gestiona veedores de su recinto, asigna mesas (JRV), corrige actas y fotografías, monitorea avance de escrutinio. |
| **Veedor de Mesa** | Registra actas electorales (alcalde + prefecto), captura fotografía con validación de nitidez, registra coordenadas GPS, corrige actas propias. |

Flujo de datos offline-first: el veedor registra actas localmente (Drift/SQLite) y la sincronización con Appwrite ocurre automáticamente al recuperar conectividad.

---

## 2. Arquitectura

```
┌──────────────────────────────────────────────────────┐
│                   Presentation                        │
│  Screens + Widgets + Riverpod Providers               │
├──────────────────────────────────────────────────────┤
│                      Domain                           │
│  Entities + UseCases + Repository Interfaces          │
├──────────────────────────────────────────────────────┤
│                       Data                            │
│  Repository Impls + Models + Drift DAOs + Appwrite     │
└──────────────────────────────────────────────────────┘
```

- **Clean Architecture**: Separación estricta en 3 capas (Presentation → Domain → Data). Las pantallas nunca acceden directamente a bases de datos ni APIs.
- **Riverpod**: State management con `StateNotifier` + `AsyncValue` para estados Loading/Success/Error.
- **Drift (SQLite)**: Persistencia local con DAOs tipados y stream reactivo. Tablas: `users`, `electoral_precincts`, `electoral_tables`, `political_organizations`, `candidates`, `electoral_acts`, `votes`, `extra_votes`, `offline_queue`.
- **Appwrite**: Backend como servicio. Autenticación (email/password), base de datos (colecciones), almacenamiento (fotos de actas).
- **Transactional Outbox**: Cola `offline_queue` que persiste operaciones pendientes y las sincroniza en orden FIFO al reconectar.
- **GoRouter**: Navegación declarativa con guards de autenticación y redirección por rol.

---

## 3. Requisitos de Instalación

| Herramienta | Versión |
|---|---|
| Flutter SDK | >=3.3.0 |
| Dart SDK | >=3.3.0 |
| Android Studio | Arctic Fox o superior |
| Gradle | 8.14+ |
| Dispositivo | Android 5.0+ (API 21+) |

### Variables de entorno (Appwrite)

Editar `lib/core/constants/app_constants.dart`:

```dart
static const String appwriteEndpoint = 'https://cloud.appwrite.io/v1';
static const String appwriteProjectId = 'TU_PROJECT_ID';
static const String appwriteDatabaseId = 'electoral_db';
static const String storageActsBucketId = 'acts_photos';
```

---

## 4. Cómo Ejecutar el Proyecto

```bash
# Clonar repositorio
git clone <repo-url>
cd control_elec_ec

# Instalar dependencias
flutter pub get

# Generar código Drift (DAOs + tablas)
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar en dispositivo/emulador
flutter run
```

### Ejecutar en modo release

```bash
flutter run --release
```

---

## 5. Configuración Appwrite

### 5.1 Consola Appwrite

1. Crear proyecto en [Appwrite Cloud](https://cloud.appwrite.io).
2. Configurar `appwriteProjectId` en `app_constants.dart`.
3. Crear base de datos `electoral_db`.
4. Crear las siguientes colecciones:

| Colección | Descripción |
|---|---|
| `users` | Usuarios del sistema (cédula, nombres, rol, email). |
| `electoral_precincts` | Recintos electorales (provincia, cantón, parroquia, nombre, JRV). |
| `electoral_tables` | Mesas JRV asignadas a cada recinto y veedor. |
| `political_organizations` | Organizaciones políticas participantes. |
| `candidates` | Candidatos por organización y dignidad. |
| `electoral_acts` | Actas registradas por mesa y dignidad. |
| `votes` | Votos por candidato dentro de cada acta. |
| `extra_votes` | Votos blancos, nulos y total sufragantes por acta. |

5. Crear bucket de almacenamiento `acts_photos` para fotografías de actas.
6. Configurar permisos de colección:
   - `coordinador_provincial`: lectura/escritura global.
   - Cada documento asigna automáticamente `read + update` al usuario propietario (ver Sección 9).

### 5.2 Crear usuario inicial (Coordinador Provincial)

El primer usuario debe crearse desde la consola de Appwrite:

1. **Auth > Users > Create User** con email real y contraseña `Ecuador2026`.
2. **Databases > electoral_db > users > Create Document** con el mismo `$id` del usuario creado y los campos: `cedula`, `nombres`, `apellidos`, `telefono`, `correo`, `rol: coordinador_provincial`, `password_changed: false`, `email_verified: false`.
3. El usuario deberá cambiar su contraseña en el primer inicio de sesión.

Los usuarios subordinados (coordinadores de recinto y veedores) se crean desde la app siguiendo la jerarquía.

---

## 6. Credenciales de Prueba

> **Nota**: Las contraseñas iniciales siempre son `Ecuador2026`. El sistema obliga a cambiarla en el primer login.

### Coordinador Provincial

| Campo | Valor |
|---|---|
| Usuario (cédula) | `1712345678` |
| Contraseña inicial | `Ecuador2026` |

### Coordinador de Recinto (ejemplo)

> Creado por el Provincial desde la app.

| Campo | Valor |
|---|---|
| Usuario (cédula) | `1709876543` |
| Contraseña inicial | `Ecuador2026` |

### Veedor de Mesa (ejemplo)

> Creado por el Coordinador de Recinto desde la app.

| Campo | Valor |
|---|---|
| Usuario (cédula) | `0912345678` |
| Contraseña inicial | `Ecuador2026` |

---

## 7. Modelo de Backend (Appwrite Collections)

### `users`
```
$id              → string (PK, mismo ID de Appwrite Auth)
cedula           → string (unique)
nombres          → string
apellidos        → string
telefono         → string
correo           → string (unique)
rol              → enum: coordinador_provincial | coordinador_recinto | veedor_mesa
password_changed → boolean
email_verified   → boolean
precinct_id      → string? (FK → electoral_precincts)
```

### `electoral_precincts`
```
$id                   → string (PK)
provincia             → string
canton                → string
parroquia             → string
nombre_recinto        → string
numero_jrv            → integer
coordinador_recinto_id → string? (FK → users)
```

### `electoral_tables`
```
$id           → string (PK)
jrv_number    → integer
precinct_id   → string (FK → electoral_precincts)
veedor_id     → string? (FK → users)
estado_acta   → enum: pendiente | en_progreso | completado
```

### `political_organizations`
```
$id            → string (PK)
nombre         → string
tipo_dignidad  → enum: alcalde | prefecto
numero_lista   → integer (1–5)
color          → string (hex)
```

### `candidates`
```
$id               → string (PK)
nombre            → string
organization_id   → string (FK → political_organizations)
tipo_dignidad     → enum: alcalde | prefecto
```

### `electoral_acts`
```
$id               → string (PK)
table_id          → string (FK → electoral_tables)
tipo_dignidad     → enum: alcalde | prefecto
photo_url         → string? (URL en Appwrite Storage)
local_photo_path   → string?
gps_latitude      → double?
gps_longitude     → double?
estado            → enum: borrador | guardado | sincronizado
```

### `votes`
```
$id              → string (PK)
act_id           → string (FK → electoral_acts)
candidate_id     → string (FK → candidates)
cantidad_votos   → integer
```

### `extra_votes`
```
$id                → string (PK)
act_id             → string (unique FK → electoral_acts)
votos_blancos      → integer
votos_nulos        → integer
total_sufragantes  → integer
```

---

## 8. Sincronización Offline

El sistema implementa el patrón **Transactional Outbox**:

```
[Veedor] → registerActa()
              ├─ Guarda en Drift (local)
              ├─ Encola operación en offline_queue
              └─ Intenta subir foto a Appwrite Storage
                    ├─ Online  → foto subida + documento creado en Appwrite
                    └─ Offline → foto guardada local + pendiente de upload

[SyncService]
   ├─ Escucha cambios de conectividad (connectivity_plus)
   ├─ Timer cada 30 segundos
   └─ Procesa cola FIFO:
        ├─ create  → databases.createDocument()
        ├─ update  → databases.updateDocument()
        ├─ delete  → databases.deleteDocument()
        └─ file_upload → storage.createFile()
              └─ Actualiza photoUrl en Drift
```

### Resolución de conflictos

**Last-Write-Wins** basado en `updated_at`. Si el servidor tiene una versión más reciente, el cambio local se descarta.

### Reintentos

Máximo 5 reintentos con backoff. Errores `401/403` (sin permisos) se marcan como fallo permanente.

---

## 9. RBAC — Permisos Appwrite por Documento

Cada documento creado recibe permisos granulares automáticamente:

| Rol creador | Colección | Permisos |
|---|---|---|
| Veedor | `electoral_acts` | `read("user:veedorId")`, `update("user:veedorId")` |
| Coordinador Recinto | `electoral_tables` | `read("user:coordId")`, `update("user:coordId")` |
| Provincial | `users` | `read("user:nuevoUserId")`, `update("user:nuevoUserId")` |

El Coordinador Provincial requiere acceso de lectura global, configurado a nivel de colección en la consola de Appwrite.

---

## 10. Estructura de Carpetas

```
lib/
├── main.dart                          # Entry point
├── app.dart                           # MaterialApp.router
├── app_router.dart                    # GoRouter (rutas + guards)
├── core/
│   ├── constants/
│   │   ├── app_constants.dart         # Appwrite IDs, roles, thresholds
│   │   └── app_strings.dart           # Strings centralizados
│   ├── database/
│   │   ├── app_database.dart          # Drift Database + seeds
│   │   ├── tables/                    # Drift Table definitions
│   │   │   ├── users_table.dart
│   │   │   ├── precincts_table.dart
│   │   │   ├── acts_table.dart
│   │   │   └── offline_queue_table.dart
│   │   └── daos/                      # Drift DAOs
│   │       ├── users_dao.dart
│   │       ├── precincts_dao.dart
│   │       ├── acts_dao.dart
│   │       └── offline_queue_dao.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   └── network_info.dart          # connectivity_plus wrapper
│   ├── services/
│   │   ├── appwrite_service.dart      # Singleton Appwrite
│   │   ├── blur_detection_service.dart # Variance of Laplacian
│   │   ├── gps_service.dart           # Geolocator wrapper
│   │   ├── sync_service.dart          # Offline → Appwrite sync
│   │   └── injection_container.dart   # GetIt DI
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── cedula_validator.dart      # Algoritmo Módulo 10 Ecuador
│   │   └── either_extensions.dart
│   └── validators/
│       └── form_validators.dart
├── features/
│   ├── authentication/
│   │   ├── data/models/user_model.dart
│   │   ├── data/repositories/auth_repository_impl.dart
│   │   ├── domain/entities/user_entity.dart
│   │   ├── domain/repositories/auth_repository.dart
│   │   ├── domain/usecases/auth_usecases.dart
│   │   └── presentation/
│   │       ├── providers/auth_provider.dart
│   │       ├── screens/
│   │       │   ├── login_screen.dart
│   │       │   ├── change_password_screen.dart
│   │       │   └── forgot_password_screen.dart
│   │       └── widgets/
│   ├── provincial/
│   │   ├── data/repositories/provincial_repository_impl.dart
│   │   ├── domain/entities/provincial_entities.dart
│   │   ├── domain/repositories/provincial_repository.dart
│   │   ├── domain/usecases/provincial_usecases.dart
│   │   └── presentation/
│   │       ├── providers/provincial_providers.dart
│   │       └── screens/
│   │           ├── provincial_dashboard_screen.dart
│   │           ├── provincial_act_detail_screen.dart
│   │           ├── precinct_list_screen.dart
│   │           ├── create_precinct_screen.dart
│   │           ├── create_coordinator_screen.dart
│   │           └── assign_coordinator_screen.dart
│   ├── recinto/
│   │   ├── data/repositories/recinto_repository_impl.dart
│   │   ├── domain/entities/recinto_entities.dart
│   │   ├── domain/repositories/recinto_repository.dart
│   │   ├── domain/usecases/recinto_usecases.dart
│   │   └── presentation/
│   │       ├── providers/recinto_providers.dart
│   │       └── screens/
│   │           ├── recinto_dashboard_screen.dart
│   │           ├── table_list_screen.dart
│   │           ├── create_veedor_screen.dart
│   │           ├── assign_veedor_screen.dart
│   │           ├── act_correction_screen.dart
│   │           └── veedor_management_screen.dart
│   └── veedor/
│       ├── data/repositories/veedor_repository_impl.dart
│       ├── domain/entities/acta_entity.dart
│       ├── domain/repositories/veedor_repository.dart
│       ├── domain/usecases/veedor_usecases.dart
│       └── presentation/
│           ├── providers/veedor_providers.dart
│           ├── screens/
│           │   ├── veedor_dashboard_screen.dart
│           │   ├── act_registration_screen.dart
│           │   ├── act_detail_screen.dart
│           │   ├── photo_capture_screen.dart
│           │   └── gps_permission_screen.dart
│           └── widgets/
│               ├── vote_entry_form.dart
│               └── validation_summary.dart
└── shared/
    ├── providers/app_providers.dart
    └── widgets/
        ├── app_scaffold.dart
        ├── empty_state_view.dart
        ├── error_view.dart
        ├── loading_overlay.dart
        ├── offline_banner.dart
        └── sync_status_indicator.dart
```

---

## 11. Build APK Release

```bash
flutter build apk --release
```

El APK se genera en:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Permisos requeridos (Android)

- `INTERNET`, `ACCESS_NETWORK_STATE`
- `CAMERA`
- `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`
- `READ_EXTERNAL_STORAGE`, `READ_MEDIA_IMAGES`

---

## 12. Dependencias Principales

| Paquete | Versión | Uso |
|---|---|---|
| `flutter_riverpod` | ^2.6.1 | State management |
| `go_router` | ^14.6.1 | Navegación |
| `drift` | ^2.20.3 | Base de datos local SQLite |
| `appwrite` | ^13.0.0 | Backend (auth, DB, storage) |
| `image_picker` | ^1.1.2 | Captura de fotos |
| `image` | ^4.3.0 | Procesamiento de imágenes (Laplacian) |
| `geolocator` | ^13.0.2 | Captura coordenadas GPS |
| `fl_chart` | ^0.70.2 | Gráficos de barras (dashboard) |
| `connectivity_plus` | ^6.1.4 | Monitoreo de red |
| `dartz` | ^0.10.1 | Programación funcional (Either) |
| `flutter_secure_storage` | ^9.2.2 | Almacenamiento seguro de tokens |
