/// Strings centralizados de la aplicación. Facilita futura localización (l10n).
library;

class AppStrings {
  AppStrings._();

  // ── App ────────────────────────────────────────────────────────────────
  static const String appName = 'Control Electoral Ecuador 2026';
  static const String appSubtitle = 'Sistema de Escrutinio Electoral';

  // ── Auth ───────────────────────────────────────────────────────────────
  static const String login = 'Iniciar Sesión';
  static const String logout = 'Cerrar Sesión';
  static const String cedula = 'Cédula de Identidad';
  static const String password = 'Contraseña';
  static const String newPassword = 'Nueva Contraseña';
  static const String confirmPassword = 'Confirmar Contraseña';
  static const String changePassword = 'Cambiar Contraseña';
  static const String forgotPassword = '¿Olvidaste tu contraseña?';
  static const String recoverPassword = 'Recuperar Contraseña';
  static const String email = 'Correo Electrónico';
  static const String emailVerificationSent =
      'Se envió un correo de verificación a tu email.';
  static const String passwordChangedSuccess =
      'Contraseña cambiada exitosamente.';
  static const String mustChangePassword =
      'Debes cambiar tu contraseña antes de continuar.';
  static const String loginSuccess = 'Bienvenido al sistema.';
  static const String invalidCredentials =
      'Cédula o contraseña incorrectos. Intenta nuevamente.';

  // ── Roles ──────────────────────────────────────────────────────────────
  static const String roleProvincial = 'Coordinador Provincial';
  static const String roleRecinto = 'Coordinador de Recinto';
  static const String roleVeedor = 'Veedor de Mesa';

  // ── Dashboard ──────────────────────────────────────────────────────────
  static const String dashboard = 'Dashboard';
  static const String totalMesas = 'Total Mesas';
  static const String mesasCompletas = 'Mesas Completadas';
  static const String mesasPendientes = 'Mesas Pendientes';
  static const String totalSufragantes = 'Total Sufragantes';
  static const String votosAlcalde = 'Votos Alcalde';
  static const String votosPrefecto = 'Votos Prefecto';

  // ── Recintos ───────────────────────────────────────────────────────────
  static const String recintos = 'Recintos Electorales';
  static const String crearRecinto = 'Crear Recinto';
  static const String provincia = 'Provincia';
  static const String canton = 'Cantón';
  static const String parroquia = 'Parroquia';
  static const String nombreRecinto = 'Nombre del Recinto';
  static const String numeroJrv = 'Número JRV';

  // ── Actas ──────────────────────────────────────────────────────────────
  static const String actas = 'Actas Electorales';
  static const String registrarActa = 'Registrar Acta';
  static const String actaAlcalde = 'Acta Alcalde';
  static const String actaPrefecto = 'Acta Prefecto';
  static const String votosOrg = 'Votos Organización';
  static const String votosBlancos = 'Votos en Blanco';
  static const String votosNulos = 'Votos Nulos';
  static const String totalSufragantesField = 'Total Sufragantes';
  static const String actaGuardada = 'Acta guardada exitosamente.';
  static const String actaActualizada = 'Acta actualizada exitosamente.';

  // ── Validaciones ───────────────────────────────────────────────────────
  static const String cedulaInvalida =
      'Cédula ecuatoriana inválida. Verifica el número.';
  static const String campoRequerido = 'Este campo es requerido.';
  static const String emailInvalido = 'Correo electrónico inválido.';
  static const String telefonoInvalido = 'Teléfono inválido (10 dígitos).';
  static const String passwordMinLength =
      'La contraseña debe tener al menos 8 caracteres.';
  static const String passwordsMustMatch = 'Las contraseñas no coinciden.';
  static const String sumatoriaMismatch =
      'La suma de votos no coincide con el total de sufragantes.';
  static const String totalSufragantesRequired =
      'Ingrese el total de sufragantes.';

  // ── Cámara y GPS ───────────────────────────────────────────────────────
  static const String tomarFoto = 'Tomar Fotografía';
  static const String imagenBorrosa =
      'Imagen borrosa. Por favor vuelva a tomar la fotografía con mejor iluminación.';
  static const String gpsPermisoDenegado =
      'Debe conceder permiso de ubicación para continuar.';
  static const String gpsPermisoDenegadoPermanente =
      'Permiso de ubicación denegado permanentemente. Habilítalo en Configuración.';
  static const String obteniendoGps = 'Obteniendo ubicación GPS...';
  static const String gpsObtenido = 'Ubicación GPS registrada.';
  static const String procesandoImagen = 'Procesando imagen...';

  // ── Offline / Sync ─────────────────────────────────────────────────────
  static const String modoOffline = 'Modo sin conexión';
  static const String sincronizando = 'Sincronizando datos...';
  static const String sincronizacionCompleta = 'Datos sincronizados.';
  static const String pendienteSync = 'cambios pendientes de sincronizar';

  // ── Errores Generales ──────────────────────────────────────────────────
  static const String errorGenerico =
      'Ocurrió un error inesperado. Intenta nuevamente.';
  static const String errorSinConexion =
      'Sin conexión a internet. Los datos se guardarán localmente.';
  static const String errorServidor = 'Error de comunicación con el servidor.';
  static const String errorPermisos =
      'No tienes permisos para realizar esta acción.';
  static const String reintentar = 'Reintentar';
  static const String cancelar = 'Cancelar';
  static const String confirmar = 'Confirmar';
  static const String guardar = 'Guardar';
  static const String editar = 'Editar';
  static const String eliminar = 'Eliminar';

  // ── Estados vacíos ────────────────────────────────────────────────────
  static const String sinRecintos = 'No hay recintos registrados.';
  static const String sinMesas = 'No hay mesas asignadas.';
  static const String sinActas = 'No hay actas registradas.';
  static const String sinUsuarios = 'No hay usuarios registrados.';
}
