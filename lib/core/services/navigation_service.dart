import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../routes/route_helper.dart';
import 'storage_service.dart';

/// Navigation Service
/// Provides centralized navigation management with GetX
/// Handles route validation, user role checking, and navigation history
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  /// Navigation history stack
  static final List<String> _navigationHistory = [];

  /// Maximum history size to prevent memory issues
  static const int _maxHistorySize = 50;

  /// Get current route
  static String get currentRoute => Get.currentRoute;

  /// Get previous route
  static String? get previousRoute {
    if (_navigationHistory.length > 1) {
      return _navigationHistory[_navigationHistory.length - 2];
    }
    return null;
  }

  /// Get navigation history
  static List<String> get navigationHistory =>
      List.unmodifiable(_navigationHistory);

  /// Add route to history
  static void _addToHistory(String route) {
    _navigationHistory.add(route);
    if (_navigationHistory.length > _maxHistorySize) {
      _navigationHistory.removeAt(0);
    }
  }

  /// Navigate to a route with optional arguments
  static Future<T?>? to<T>(String routeName, {dynamic arguments}) {
    _addToHistory(routeName);
    return Get.toNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate and replace current route
  static Future<T?>? off<T>(String routeName, {dynamic arguments}) {
    _addToHistory(routeName);
    return Get.offNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate and clear all previous routes
  static Future<T?>? offAll<T>(String routeName, {dynamic arguments}) {
    _navigationHistory.clear();
    _addToHistory(routeName);
    return Get.offAllNamed<T>(routeName, arguments: arguments);
  }

  /// Go back to previous route
  static void back<T>({T? result}) {
    if (_navigationHistory.isNotEmpty) {
      _navigationHistory.removeLast();
    }
    Get.back<T>(result: result);
  }

  /// Navigate until a specific route
  static void until(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }

  /// Check if can go back
  static bool canGoBack() {
    return Get.key.currentState?.canPop() ?? false;
  }

  /// Navigate to appropriate home based on user role
  static Future<void> toHome() async {
    final userRole = await StorageService.getUserRole();

    switch (userRole?.toLowerCase()) {
      case 'student':
        await offAll(RoutesName.studentHome);
        break;
      case 'mentor':
        await offAll(RoutesName.mentorHome);
        break;
      default:
        await offAll(RoutesName.navigation);
    }
  }

  /// Navigate to login and clear stack
  static Future<void> toLogin() async {
    await offAll(RoutesName.login);
  }

  /// Navigate to appropriate profile setup based on user role
  static Future<void> toProfileSetup() async {
    final userRole = await StorageService.getUserRole();

    if (userRole?.toLowerCase() == 'mentor') {
      await to(RoutesName.mentoringSetup);
    } else {
      await to(RoutesName.setupProfileImg);
    }
  }

  /// Navigate with role validation
  static Future<T?>? toWithRoleCheck<T>(String routeName, String requiredRole,
      {dynamic arguments}) async {
    final userRole = await StorageService.getUserRole();

    if (userRole?.toLowerCase() != requiredRole.toLowerCase()) {
      Get.snackbar(
        'Access Denied',
        'You do not have permission to access this page',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }

    return to<T>(routeName, arguments: arguments);
  }

  /// Navigate to student-specific route
  static Future<T?>? toStudentRoute<T>(String routeName,
      {dynamic arguments}) {
    return toWithRoleCheck<T>(routeName, 'student', arguments: arguments);
  }

  /// Navigate to mentor-specific route
  static Future<T?>? toMentorRoute<T>(String routeName,
      {dynamic arguments}) {
    return toWithRoleCheck<T>(routeName, 'mentor', arguments: arguments);
  }

  /// Show bottom sheet with navigation options
  static void showNavigationBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Navigation Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildNavigationOption(
              icon: Icons.home,
              title: 'Home',
              onTap: () {
                Get.back();
                toHome();
              },
            ),
            _buildNavigationOption(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                Get.back();
                to(RoutesName.profile);
              },
            ),
            _buildNavigationOption(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Get.back();
                to(RoutesName.settings);
              },
            ),
            _buildNavigationOption(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                Get.back();
                _showLogoutConfirmation();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Build navigation option widget
  static Widget _buildNavigationOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  /// Show logout confirmation dialog
  static void _showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  /// Logout user and navigate to login
  static Future<void> logout() async {
    try {
      // Clear user data
      await StorageService.clearUserData();

      // Clear navigation history
      _navigationHistory.clear();

      // Navigate to login
      await offAll(RoutesName.login);

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Navigate with animation
  static Future<T?>? toWithAnimation<T>(
      String routeName, {
        dynamic arguments,
        Transition? transition,
        Duration? duration,
      }) {
    _addToHistory(routeName);
    // NOTE: transition and duration no longer supported in Get.toNamed
    return Get.toNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate with custom page route
  static Future<T?>? toWithCustomRoute<T>(
      Widget page, {
        String? routeName,
        dynamic arguments,
        bool fullscreenDialog = false,
      }) {
    if (routeName != null) {
      _addToHistory(routeName);
    }
    return Get.to<T>(
          () => page,
      arguments: arguments,
      fullscreenDialog: fullscreenDialog,
    );
  }

  /// Show modal bottom sheet with custom content
  static Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return Get.bottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
    );
  }

  /// Show custom dialog
  static Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return Get.dialog<T>(
      child,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
  }

  /// Navigate to error page
  static Future<void> toErrorPage({String? message}) async {
    await to('/error', arguments: {'message': message ?? 'An error occurred'});
  }

  /// Navigate to not found page
  static Future<void> toNotFoundPage() async {
    await to('/404');
  }

  /// Check if route exists
  static bool routeExists(String routeName) {
    // This would need to be implemented based on your route configuration
    // For now, return true as a placeholder
    return true;
  }

  /// Get route arguments
  static dynamic getArguments() {
    return Get.arguments;
  }

  /// Get route parameters
  static Map<String, String?> getParameters() {
    return Get.parameters;
  }

  /// Navigate with parameters
  static Future<T?>? toWithParameters<T>(
      String routeName, {
        Map<String, String>? parameters,
        dynamic arguments,
      }) {
    _addToHistory(routeName);
    return Get.toNamed<T>(
      routeName,
      parameters: parameters,
      arguments: arguments,
    );
  }

  /// Clear navigation history
  static void clearHistory() {
    _navigationHistory.clear();
  }

  /// Print navigation history (for debugging)
  static void printHistory() {
    debugPrint('Navigation History: $_navigationHistory');
  }

  /// Navigate based on deep link
  static Future<void> handleDeepLink(String link) async {
    if (link.contains('/student/')) {
      final userRole = await StorageService.getUserRole();
      if (userRole?.toLowerCase() != 'student') {
        await toLogin();
        return;
      }
    } else if (link.contains('/mentor/')) {
      final userRole = await StorageService.getUserRole();
      if (userRole?.toLowerCase() != 'mentor') {
        await toLogin();
        return;
      }
    }

    await to(link);
  }
}

/// Navigation Extensions
/// Provides convenient extension methods for navigation
extension NavigationExtensions on GetInterface {
  Future<void> toHome() => NavigationService.toHome();
  Future<void> toLogin() => NavigationService.toLogin();
  Future<void> toProfileSetup() => NavigationService.toProfileSetup();
  Future<void> logout() => NavigationService.logout();
  void showNavigationBottomSheet() =>
      NavigationService.showNavigationBottomSheet();
}
