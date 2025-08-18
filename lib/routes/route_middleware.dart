import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/services/storage_service.dart';
import 'app_routes.dart';

/// Authentication Middleware
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = StorageService.isLoggedIn();

    final publicRoutes = [
      RoutesName.splash,
      RoutesName.walk,
      RoutesName.userSelection,
      RoutesName.login,
      RoutesName.register,
      RoutesName.forgotPassword,
      RoutesName.resetPassword,
      RoutesName.otpVerification,
    ];

    if (!isLoggedIn && !publicRoutes.contains(route)) {
      return const RouteSettings(name: RoutesName.login);
    }

    if (isLoggedIn && publicRoutes.contains(route) && route != RoutesName.splash) {
      return const RouteSettings(name: RoutesName.navigation);
    }

    return null;
  }
}

/// Role-based Middleware
class RoleMiddleware extends GetMiddleware {
  final String requiredRole;

  RoleMiddleware({required this.requiredRole});

  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    final userRole = StorageService.getUserRoleSync();

    if (userRole != null && userRole.toLowerCase() != requiredRole.toLowerCase()) {
      switch (userRole.toLowerCase()) {
        case 'student':
          return const RouteSettings(name: RoutesName.studentHome);
        case 'mentor':
          return const RouteSettings(name: RoutesName.mentorHome);
        default:
          return const RouteSettings(name: RoutesName.userSelection);
      }
    }
    return null;
  }
}

/// Profile Setup Middleware
class ProfileSetupMiddleware extends GetMiddleware {
  @override
  int? get priority => 3;

  @override
  RouteSettings? redirect(String? route) {
    final isProfileComplete = StorageService.isProfileCompleted();
    final userRole = StorageService.getUserRoleSync();

    final exemptRoutes = [
      RoutesName.splash,
      RoutesName.walk,
      RoutesName.userSelection,
      RoutesName.login,
      RoutesName.register,
      RoutesName.forgotPassword,
      RoutesName.resetPassword,
      RoutesName.otpVerification,
      RoutesName.setupProfileImg,
      RoutesName.profileSetupInfo,
      RoutesName.mentoringSetup,
      RoutesName.bankDetails,
      RoutesName.verifyDocuments,
    ];

    if (!isProfileComplete && !exemptRoutes.contains(route)) {
      if (userRole?.toLowerCase() == 'mentor') {
        return const RouteSettings(name: RoutesName.mentoringSetup);
      } else {
        return const RouteSettings(name: RoutesName.setupProfileImg);
      }
    }

    return null;
  }
}

/// Connectivity Middleware (placeholder)
class ConnectivityMiddleware extends GetMiddleware {
  @override
  int? get priority => 4;

  @override
  RouteSettings? redirect(String? route) {
    // TODO: Implement real connectivity check
    return null;
  }
}

/// Analytics Middleware
class AnalyticsMiddleware extends GetMiddleware {
  @override
  int? get priority => 5;

  @override
  GetPage? onPageCalled(GetPage? page) {
    debugPrint('📍 Navigating to: ${page?.name}');
    return super.onPageCalled(page);
  }

  @override
  Widget onPageBuilt(Widget page) {
    debugPrint('🏗️ Page built: ${Get.currentRoute}');
    return super.onPageBuilt(page);
  }

  @override
  void onPageDispose() {
    debugPrint('🗑️ Page disposed: ${Get.previousRoute}');
    super.onPageDispose();
  }
}

/// Error Handling Middleware
class ErrorHandlingMiddleware extends GetMiddleware {
  @override
  int? get priority => 6;

  @override
  RouteSettings? redirect(String? route) {
    final validRoutes = [
      RoutesName.splash,
      RoutesName.walk,
      RoutesName.userSelection,
      RoutesName.login,
      RoutesName.register,
      RoutesName.navigation,
      RoutesName.studentHome,
      RoutesName.mentorHome,
    ];

    if (!validRoutes.contains(route)) {
      debugPrint('⚠️ Invalid route: $route');
      final isLoggedIn = StorageService.isLoggedIn();
      if (isLoggedIn) {
        return const RouteSettings(name: RoutesName.navigation);
      } else {
        return const RouteSettings(name: RoutesName.login);
      }
    }

    return null;
  }
}

/// Middleware Helper
class MiddlewareHelper {
  static AuthMiddleware auth() => AuthMiddleware();
  static RoleMiddleware role(String requiredRole) => RoleMiddleware(requiredRole: requiredRole);
  static ProfileSetupMiddleware profileSetup() => ProfileSetupMiddleware();
  static ConnectivityMiddleware connectivity() => ConnectivityMiddleware();
  static AnalyticsMiddleware analytics() => AnalyticsMiddleware();
  static ErrorHandlingMiddleware errorHandling() => ErrorHandlingMiddleware();

  static List<GetMiddleware> protectedRoute({String? requiredRole}) {
    final middleware = <GetMiddleware>[
      auth(),
      profileSetup(),
      connectivity(),
      analytics(),
      errorHandling(),
    ];

    if (requiredRole != null) {
      middleware.insert(1, role(requiredRole));
    }

    return middleware;
  }

  static List<GetMiddleware> publicRoute() => [analytics(), errorHandling()];
  static List<GetMiddleware> studentRoute() => protectedRoute(requiredRole: 'student');
  static List<GetMiddleware> mentorRoute() => protectedRoute(requiredRole: 'mentor');
}
