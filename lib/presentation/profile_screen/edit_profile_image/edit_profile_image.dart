import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../widgets/base_button.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import '../profile_page.dart';


class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
       backgroundColor: Colors.transparent,
        // backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerRight,
            child: UIHelper.boldText(
              text: 'Edit Profile Images',
              fontSize: 18,
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFCEDBF1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
            ),
            onPressed: () => Get.back(),
          ),
          toolbarHeight: 80,
        ),

        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      /// Centered Profile Widget
                      Expanded(
                        child: Center(
                          child: const UploadProfilePhotoWidget(),
                        ),
                      ),

                      // /// Save Button at Bottom
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: AppConstants.paddingLarge,
                      //   ),
                      //   child: GradientButton(
                      //     text: "Save Changes",
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => const ProfilePage(),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom +
                            AppConstantsSpacing.spacingLarge,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge, vertical: 18),
          child: GradientButton(
            text: "Save Changes",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
        ),

      ),
    );
  }
}

// class UploadProfilePhotoWidget extends StatefulWidget {
//   const UploadProfilePhotoWidget({super.key});
//
//   @override
//   State<UploadProfilePhotoWidget> createState() =>
//       _UploadProfilePhotoWidgetState();
// }
//
// class _UploadProfilePhotoWidgetState extends State<UploadProfilePhotoWidget> {
//   File? _imageFile;
//   bool _isPermissionRequestInProgress = false;
//
//   Future<void> pickImageWithGetX(Function(File) onImagePicked) async {
//     if (_isPermissionRequestInProgress) return;
//     _isPermissionRequestInProgress = true;
//
//     try {
//       bool permissionGranted = false;
//       int sdkVersion = int.tryParse(Platform.version.split(' ')[0].split('.')[0]) ?? 0;
//
//       if (Platform.isAndroid) {
//         if (sdkVersion >= 33) {
//           // Android 13+ uses PhotoPicker - no permissions needed
//           permissionGranted = true;
//         } else if (sdkVersion >= 29) {
//           // Android 10–12 - use system picker without permission
//           permissionGranted = true;
//         } else {
//           // Android 9 and below - request multiple legacy permissions
//           Map<Permission, PermissionStatus> statuses = await [
//             Permission.storage,
//             Permission.photos,
//           ].request();
//
//           permissionGranted = statuses[Permission.storage]?.isGranted ?? false;
//         }
//       } else {
//         // iOS needs photo permission
//         final status = await Permission.photos.request();
//         permissionGranted = status.isGranted;
//       }
//
//       if (permissionGranted) {
//         final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//
//         if (pickedFile != null) {
//           onImagePicked(File(pickedFile.path));
//         } else {
//           Get.snackbar(
//             "Cancelled",
//             "Image selection cancelled.",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.black87,
//             colorText: Colors.white,
//           );
//         }
//       } else {
//         Get.snackbar(
//           "Permission Denied",
//           "Access to photos was denied.",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           mainButton: TextButton(
//             onPressed: () => openAppSettings(),
//             child: const Text("Open Settings", style: TextStyle(color: Colors.white)),
//           ),
//           duration: const Duration(seconds: 6),
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Unexpected error: ${e.toString()}",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       _isPermissionRequestInProgress = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 200,
//         height: 320,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFc0f2d6),
//               Color(0xFFddf8e9),
//               Color(0xffddf8e9),
//               Color(0xffFFFFFF),
//             ],
//           ),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(100),
//             topRight: Radius.circular(100),
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 pickImageWithGetX((File imageFile) {
//                   setState(() {
//                     _imageFile = imageFile;
//                   });
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 25),
//                 child: CustomPaint(
//                   painter: DashedCirclePainter(
//                     borderWidth: 2,
//                     dashLength: 6,
//                     spaceLength: 4,
//                   ),
//                   child: Container(
//                     width: 150,
//                     height: 150,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: ClipOval(
//                       child: _imageFile != null
//                           ? Image.file(
//                         _imageFile!,
//                         fit: BoxFit.cover,
//                         width: 150,
//                         height: 150,
//                       )
//                           : Center(
//                         child: UIHelper.customImage(
//                           img: "uplode-img-png.png",
//                           height: 32,
//                           width: 32,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             UIHelper.boldTextCenter(
//               text: 'Upload Profile Photo',
//               fontSize: 12,
//               color: AppColors.primary1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class UploadProfilePhotoWidget extends StatefulWidget {
  const UploadProfilePhotoWidget({super.key});

  @override
  State<UploadProfilePhotoWidget> createState() =>
      _UploadProfilePhotoWidgetState();
}

class _UploadProfilePhotoWidgetState extends State<UploadProfilePhotoWidget> {
  File? _imageFile;
  bool _isPermissionRequestInProgress = false;

  /// Main entry to choose source (camera or gallery)
  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                pickImage(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                pickImage(source: ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImage({required ImageSource source}) async {
    if (_isPermissionRequestInProgress) return;

    _isPermissionRequestInProgress = true;

    try {
      bool permissionGranted = false;
      int sdkInt = 0;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        sdkInt = androidInfo.version.sdkInt;

        if (source == ImageSource.gallery) {
          if (sdkInt >= 33) {
            permissionGranted = true; // Android 13+ doesn't require permission
          } else if (sdkInt >= 29) {
            permissionGranted = true;
          } else {
            final status = await Permission.storage.request();
            permissionGranted = status.isGranted;
          }
        } else {
          final status = await Permission.camera.request();
          permissionGranted = status.isGranted;
        }
      } else if (Platform.isIOS) {
        if (source == ImageSource.gallery) {
          final status = await Permission.photos.request();
          permissionGranted = status.isGranted;
        } else {
          final status = await Permission.camera.request();
          permissionGranted = status.isGranted;
        }
      }

      if (permissionGranted) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _imageFile = File(pickedFile.path);
          });
        } else {
          Get.snackbar(
            "Cancelled",
            "Image selection cancelled.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black87,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Permission Denied",
          "Please allow access to ${source == ImageSource.camera ? "camera" : "photos"}.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: openAppSettings,
            child: const Text("Open Settings", style: TextStyle(color: Colors.white)),
          ),
          duration: const Duration(seconds: 6),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Unexpected error: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isPermissionRequestInProgress = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 320,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFc0f2d6),
              Color(0xFFddf8e9),
              Color(0xFFddf8e9),
              // Color(0xffddf8e9),
              Color(0xffeafbf2),
              Color(0xffeafbf2),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _showImageSourceActionSheet,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CustomPaint(
                  painter: DashedCirclePainter(
                    borderWidth: 2,
                    dashLength: 6,
                    spaceLength: 4,
                  ),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: _imageFile != null
                          ? Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      )
                          : Center(
                        child: UIHelper.customImage(
                          img: "uplode-img-png.png",
                          height: 32,
                          width: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            UIHelper.boldTextCenter(
              text: 'Upload Profile Photo',
              fontSize: 12,
              color: AppColors.primary1,
            ),
          ],
        ),
      ),
    );
  }
}

// With Parmitaion
// class UploadProfilePhotoWidget extends StatefulWidget {
//   const UploadProfilePhotoWidget({super.key});
//
//   @override
//   State<UploadProfilePhotoWidget> createState() =>
//       _UploadProfilePhotoWidgetState();
// }
//
// class _UploadProfilePhotoWidgetState extends State<UploadProfilePhotoWidget> {
//   File? _imageFile;
//   bool _isPermissionRequestInProgress = false;
//
//   /// Picks an image after checking permission based on platform & SDK version
//   Future<void> pickImageWithGetX(Function(File) onImagePicked) async {
//     if (_isPermissionRequestInProgress) return;
//
//     _isPermissionRequestInProgress = true;
//
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     print('Running on ${androidInfo.toString()}');
//
//     try {
//       bool permissionGranted = false;
//       int sdkInt = 0;
//
//       if (Platform.isAndroid) {
//         final androidInfo = await DeviceInfoPlugin().androidInfo;
//         sdkInt = androidInfo.version.sdkInt;
//
//         // Print the SDK version and OS name
//         String androidOS = getAndroidVersionName(sdkInt);
//         print("Running on Android SDK $sdkInt ($androidOS)");
//       }
//
//       // ✅ Get Android SDK version
//       if (Platform.isAndroid) {
//         final androidInfo = await DeviceInfoPlugin().androidInfo;
//         sdkInt = androidInfo.version.sdkInt;
//       }
//
//
//       if (Platform.isAndroid) {
//         if (sdkInt >= 33) {
//           // ✅ Android 13+ uses Photo Picker, permission not needed
//           permissionGranted = true;
//         } else if (sdkInt >= 29) {
//           // ✅ Android 10 to 12 — No explicit permission needed for gallery
//           permissionGranted = true;
//         } else {
//           // 🔒 Android 9 and below — Requires storage permission
//           final status = await Permission.storage.request();
//           permissionGranted = status.isGranted;
//         }
//       } else if (Platform.isIOS) {
//         // ✅ iOS requires permission to access photos
//         final status = await Permission.photos.request();
//         permissionGranted = status.isGranted;
//       }
//
//       if (permissionGranted) {
//         final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//
//         if (pickedFile != null) {
//           onImagePicked(File(pickedFile.path));
//         } else {
//           // User cancelled image selection
//           Get.snackbar(
//             "Cancelled",
//             "Image selection cancelled.",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.black87,
//             colorText: Colors.white,
//           );
//         }
//       } else {
//         // Permissions denied
//         Get.snackbar(
//           "Permission Denied",
//           "Please allow access to photos.",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           mainButton: TextButton(
//             onPressed: openAppSettings,
//             child: const Text("Open Settings", style: TextStyle(color: Colors.white)),
//           ),
//           duration: const Duration(seconds: 6),
//         );
//       }
//     } catch (e) {
//       // Any unexpected exception
//       Get.snackbar(
//         "Error",
//         "Unexpected error: ${e.toString()}",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       _isPermissionRequestInProgress = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 200,
//         height: 320,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFc0f2d6),
//               Color(0xFFddf8e9),
//               Color(0xffddf8e9),
//               Color(0xffFFFFFF),
//             ],
//           ),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(100),
//             topRight: Radius.circular(100),
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 pickImageWithGetX((File imageFile) {
//                   setState(() {
//                     _imageFile = imageFile;
//                   });
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 25),
//                 child: CustomPaint(
//                   painter: DashedCirclePainter(
//                     borderWidth: 2,
//                     dashLength: 6,
//                     spaceLength: 4,
//                   ),
//                   child: Container(
//                     width: 150,
//                     height: 150,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: ClipOval(
//                       child: _imageFile != null
//                           ? Image.file(
//                         _imageFile!,
//                         fit: BoxFit.cover,
//                         width: 150,
//                         height: 150,
//                       )
//                           : Center(
//                         child: UIHelper.customImage(
//                           img: "uplode-img-png.png",
//                           height: 32,
//                           width: 32,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             UIHelper.boldTextCenter(
//               text: 'Upload Profile Photo',
//               fontSize: 12,
//               color: AppColors.primary1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String getAndroidVersionName(int sdkInt) {
//     switch (sdkInt) {
//       case 36:
//         return "Android 16";
//       case 35:
//         return "Android 15";
//       case 34:
//         return "Android 14";
//       case 33:
//         return "Android 13";
//       case 32:
//         return "Android 12L";
//       case 31:
//         return "Android 12";
//       case 30:
//         return "Android 11";
//       case 29:
//         return "Android 10";
//       case 28:
//         return "Android 9 (Pie)";
//       case 27:
//         return "Android 8.1 (Oreo)";
//       case 26:
//         return "Android 8.0 (Oreo)";
//       case 25:
//         return "Android 7.1 (Nougat)";
//       case 24:
//         return "Android 7.0 (Nougat)";
//       case 23:
//         return "Android 6.0 (Marshmallow)";
//       default:
//         if (sdkInt > 36) return "Android ${sdkInt - 20}+ (Future)";
//         return "Unknown Android Version";
//     }
//   }
//
// }

class DashedCirclePainter extends CustomPainter {
  final double borderWidth;
  final double dashLength;
  final double spaceLength;

  DashedCirclePainter({
    this.borderWidth = 2.0,
    this.dashLength = 4.0,
    this.spaceLength = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final totalAngle = 2 * pi;
    final circumference = 2 * pi * radius;
    final dashCount = (circumference / (dashLength + spaceLength)).floor();
    final angleBetweenDashes = totalAngle / dashCount;

    final shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0D47A1),
        Color(0xFF42A5F5),
      ],
    ).createShader(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
    );

    final paint = Paint()
      ..shader = shader
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * angleBetweenDashes;
      final sweepAngle = (dashLength / circumference) * totalAngle;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
