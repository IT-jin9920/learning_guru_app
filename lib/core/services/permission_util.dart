// // lib/utils/permission_util.dart
//
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class PermissionUtil {
//   /// Requests a list of permissions and handles denied cases with a snackbar
//   static Future<bool> checkAndRequestPermissions({
//     required List<Permission> permissions,
//     required BuildContext context,
//   }) async {
//     try {
//       // Request each permission
//       Map<Permission, PermissionStatus> statuses = await permissions.request();
//
//       // Check if all permissions granted
//       bool allGranted = statuses.values.every((status) => status.isGranted);
//
//       if (!allGranted) {
//         // Show snackbar if any permission is denied
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('Permission required! Tap SETTINGS to enable.'),
//             action: SnackBarAction(
//               label: 'SETTINGS',
//               onPressed: () {
//                 openAppSettings();
//               },
//             ),
//           ),
//         );
//       }
//
//       return allGranted;
//     } catch (e) {
//       debugPrint('Permission Error: $e');
//       return false;
//     }
//   }
//
//   /// Call this in didChangeAppLifecycleState when app resumes
//   static Future<void> handleResumePermission({
//     required List<Permission> permissions,
//     required BuildContext context,
//     required VoidCallback onGranted,
//   }) async {
//     final statusMap = await permissions.status;
//     bool allGranted = statusMap.values.every((status) => status.isGranted);
//
//     if (allGranted) {
//       onGranted();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Still waiting for permissions'),
//           action: SnackBarAction(
//             label: 'SETTINGS',
//             onPressed: () => openAppSettings(),
//           ),
//         ),
//       );
//     }
//   }
// }
