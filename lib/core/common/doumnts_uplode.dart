// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:device_info_plus/device_info_plus.dart';
//
// class FilePickerUtil {
//   static bool _isRequestRunning = false;
//
//   /// 🌐 Universal File Picker: Supports all file types (image, video, audio, PDF, DOC, etc.)
//   /// 📥 Usage: FilePickerUtil.pickAnyFile(onFilePicked: (file) { ... });
//   static Future<void> pickAnyFile({
//     required Function(File file) onFilePicked,
//   }) async {
//     if (_isRequestRunning) return;
//
//     _isRequestRunning = true;
//     int sdkInt = 0;
//
//     try {
//       final deviceInfo = DeviceInfoPlugin();
//       if (Platform.isAndroid) {
//         final androidInfo = await deviceInfo.androidInfo;
//         sdkInt = androidInfo.version.sdkInt;
//         print("📱 Android Version Detected: $sdkInt");
//       }
//
//       bool permissionGranted = false;
//
//       // 🔐 Handle Permissions Based on SDK
//       if (Platform.isAndroid) {
//         if (sdkInt >= 33) {
//           // ✅ Android 13+ (Scoped storage - no permission needed)
//           permissionGranted = true;
//         } else if (sdkInt >= 29) {
//           // ✅ Android 10–12 (Scoped storage - no permission needed)
//           permissionGranted = true;
//         } else {
//           // ⛔ Android 9 and below - needs legacy storage permission
//           var result = await Permission.storage.request();
//           permissionGranted = result.isGranted;
//         }
//       } else if (Platform.isIOS) {
//         var result = await Permission.photos.request();
//         permissionGranted = result.isGranted;
//       }
//
//       // 🚀 Continue if permission allowed or not needed
//       if (permissionGranted) {
//         FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.any,
//           allowMultiple: false,
//         );
//
//         if (result != null && result.files.single.path != null) {
//           File file = File(result.files.single.path!);
//           onFilePicked(file); // ✅ File ready to use
//         } else {
//           // ❌ User cancelled file selection
//           Get.snackbar(
//             "Cancelled",
//             "No file was selected.",
//             backgroundColor: Colors.grey.shade800,
//             colorText: Colors.white,
//             snackPosition: SnackPosition.BOTTOM,
//           );
//         }
//       } else {
//         // ❗ Permission denied - guide user to app settings
//         Get.snackbar(
//           "Permission Denied",
//           "Please allow file access permission to proceed.",
//           backgroundColor: Colors.red.shade600,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//           mainButton: TextButton(
//             onPressed: openAppSettings,
//             child: const Text("Open Settings", style: TextStyle(color: Colors.white)),
//           ),
//         );
//       }
//     } catch (e) {
//       // 🛑 Unexpected exception
//       Get.snackbar(
//         "Error",
//         "An error occurred: ${e.toString()}",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       _isRequestRunning = false;
//     }
//   }
// }

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path/path.dart' as p;

class FilePickerUtil {
  static Future<PlatformFile?> pickAnyFile({
    int maxSizeInMB = 5,
    List<String>? allowedExtensions,
  }) async {
    try {
      // Detect Android SDK version
      int sdkInt = 0;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        sdkInt = androidInfo.version.sdkInt;
        debugPrint("📱 Android SDK Version: $sdkInt");
      }

      // Permission handling based on Android version
      PermissionStatus permission;
      if (Platform.isAndroid && sdkInt >= 33) {
        // Scoped storage in Android 13+ (API 33+)
        permission = await Permission.photos.request();
      } else if (Platform.isIOS) {
        permission = await Permission.photos.request();
      } else {
        permission = await Permission.storage.request();
      }

      // Permission denied handling
      if (!permission.isGranted) {
        if (permission.isPermanentlyDenied) {
          await openAppSettings();
          _showError("Permission permanently denied. Enable from settings.");
        } else {
          _showError("Permission denied.");
        }
        return null;
      }

      // Pick file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ??
            ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov', 'mp3', 'wav', 'aac', 'pdf', 'doc', 'docx'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        _showError("No file selected.");
        return null;
      }

      final file = result.files.first;
      final extension = p.extension(file.name).toLowerCase();
      final fileSizeInMB = (file.size / (1024 * 1024));

      // File size validation
      if (fileSizeInMB > maxSizeInMB) {
        _showError("File must be less than $maxSizeInMB MB.");
        return null;
      }

      debugPrint("✅ Picked: ${file.name} (${fileSizeInMB.toStringAsFixed(2)} MB)");
      return file;
    } catch (e) {
      _showError("File pick error: ${e.toString()}");
      debugPrint("⚠️ Exception: $e");
      return null;
    }
  }

  static void _showError(String message) {
    Get.snackbar("Error", message, backgroundColor: Colors.red.shade100);
  }
}
