/// Application-wide constants used for configuration, keys, and endpoints.
class AppConstants {
  /// Enables debug mode; set to false for production releases.
  static const bool isDebugMode = true;

  // -------- API Endpoints --------

  /// Authentication login endpoint.
  static const String loginEndpoint = '/auth/login';

  /// Authentication logout endpoint.
  static const String logoutEndpoint = '/auth/logout';

  /// Endpoint to refresh authentication token.
  static const String refreshTokenEndpoint = '/auth/refresh';

  // -------- Storage Keys --------

  /// Key to store authentication token locally.
  static const String tokenKey = 'auth_token';

  /// Key to store refresh token locally.
  static const String refreshTokenKey = 'refresh_token';

  /// Key to store user information locally.
  static const String userDataKey = 'user_data';
}
