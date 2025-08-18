
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import '../../../widgets/base_button.dart';
import 'package:path/path.dart' as p;

import '../profile_page.dart';

// class DocumentUploadController extends GetxController {
//   final RxList<String> qualificationFiles = <String>[].obs;
//   final RxList<String> certificateFiles = <String>[].obs;
//
//   // Future<void> pickFile({required bool isQualification}) async {
//   //   try {
//   //     // Detect Android version
//   //     int sdkInt = 0;
//   //     if (Platform.isAndroid) {
//   //       final androidInfo = await DeviceInfoPlugin().androidInfo;
//   //       sdkInt = androidInfo.version.sdkInt;
//   //       print("📱 Android SDK Version: $sdkInt");
//   //     }
//   //
//   //     // Request proper permission based on version
//   //     PermissionStatus permission;
//   //     if (Platform.isAndroid && sdkInt >= 33) {
//   //       permission = await Permission.photos.request(); // Android 13+ (Scoped)
//   //     } else {
//   //       permission = await Permission.storage.request(); // Android < 13
//   //     }
//   //
//   //     if (!permission.isGranted) {
//   //       if (permission.isPermanentlyDenied) {
//   //         openAppSettings();
//   //         showError("Permission permanently denied. Enable from settings.");
//   //       } else {
//   //         showError("Permission denied.");
//   //       }
//   //       return;
//   //     }
//   //
//   //     // Open file picker
//   //     final result = await FilePicker.platform.pickFiles(
//   //       type: FileType.custom,
//   //       allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
//   //     );
//   //
//   //     if (result == null || result.files.single.path == null) {
//   //       showError("No file selected.");
//   //       return;
//   //     }
//   //
//   //     final file = File(result.files.single.path!);
//   //     final extension = p.extension(file.path).toLowerCase();
//   //     final fileSizeInMB = await file.length() / (1024 * 1024);
//   //
//   //     // Validate extension
//   //     if (!['.pdf', '.jpg', '.jpeg', '.png'].contains(extension)) {
//   //       showError("Only PDF, PNG, JPG files are allowed.");
//   //       return;
//   //     }
//   //
//   //     // Validate file size
//   //     if (fileSizeInMB > 5) {
//   //       showError("File must be less than 5MB.");
//   //       return;
//   //     }
//   //
//   //     // Add file to the correct list
//   //     final fileName = p.basename(file.path);
//   //     if (isQualification) {
//   //       qualificationFiles.add(fileName);
//   //     } else {
//   //       certificateFiles.add(fileName);
//   //     }
//   //
//   //     showSuccess("File uploaded successfully.");
//   //     print("✅ File uploaded: $fileName (${fileSizeInMB.toStringAsFixed(2)} MB)");
//   //
//   //   } on PlatformException catch (e) {
//   //     showError("Platform Error: ${e.message ?? 'Unknown error'}");
//   //     print("⚠️ PlatformException: ${e.message}");
//   //   } on FileSystemException catch (e) {
//   //     showError("File System Error: ${e.message}");
//   //     print("⚠️ FileSystemException: ${e.message}");
//   //   } catch (e) {
//   //     showError("Something went wrong: ${e.toString()}");
//   //     print("⚠️ Exception: $e");
//   //   }
//   // }
//
//   Future<void> pickFile({required bool isQualification}) async {
//     try {
//       // Detect Android version
//       int sdkInt = 0;
//       if (Platform.isAndroid) {
//         final androidInfo = await DeviceInfoPlugin().androidInfo;
//         sdkInt = androidInfo.version.sdkInt;
//         print("📱 Android SDK Version: $sdkInt");
//       }
//
//       // Request proper permission based on version
//       PermissionStatus permission;
//       if (Platform.isAndroid && sdkInt >= 33) {
//         permission = await Permission.photos.request();
//       } else {
//         permission = await Permission.storage.request();
//       }
//
//       if (!permission.isGranted) {
//         if (permission.isPermanentlyDenied) {
//           openAppSettings();
//           showError("Permission permanently denied. Enable from settings.");
//         } else {
//           showError("Permission denied.");
//         }
//         return;
//       }
//
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
//       );
//
//       if (result == null || result.files.single.path == null) {
//         showError("No file selected.");
//         return;
//       }
//
//       final file = File(result.files.single.path!);
//       final extension = p.extension(file.path).toLowerCase();
//       final fileSizeInMB = await file.length() / (1024 * 1024);
//
//       if (!['.pdf', '.jpg', '.jpeg', '.png'].contains(extension)) {
//         showError("Only PDF, PNG, JPG files are allowed.");
//         return;
//       }
//
//       if (fileSizeInMB > 5) {
//         showError("File must be less than 5MB.");
//         return;
//       }
//
//       // Assign default name like Document 1, Document 2, ...
//       String documentName;
//       if (isQualification) {
//         documentName = "qualificationFiles ${qualificationFiles.length + 1}";
//         qualificationFiles.add(documentName);
//       } else {
//         documentName = "certificateFiles ${certificateFiles.length + 1}";
//         certificateFiles.add(documentName);
//       }
//
//       showSuccess("File uploaded successfully.");
//       print(
//         "✅ File uploaded: $documentName (${fileSizeInMB.toStringAsFixed(2)} MB)",
//       );
//     } on PlatformException catch (e) {
//       showError("Platform Error: ${e.message ?? 'Unknown error'}");
//       print("⚠️ PlatformException: ${e.message}");
//     } on FileSystemException catch (e) {
//       showError("File System Error: ${e.message}");
//       print("⚠️ FileSystemException: ${e.message}");
//     } catch (e) {
//       showError("Something went wrong: ${e.toString()}");
//       print("⚠️ Exception: $e");
//     }
//   }
//
//   void removeFile({required bool isQualification, required int index}) {
//     if (isQualification) {
//       qualificationFiles.removeAt(index);
//     } else {
//       certificateFiles.removeAt(index);
//     }
//   }
//
//   void showError(String message) {
//     Get.snackbar(
//       "Error",
//       message,
//       backgroundColor: Colors.red.shade100,
//       colorText: Colors.red.shade800,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   void showSuccess(String message) {
//     Get.snackbar(
//       "Success",
//       message,
//       backgroundColor: Colors.green.shade100,
//       colorText: Colors.green.shade800,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }


class EditCertifications extends StatefulWidget {
  const EditCertifications({super.key});

  @override
  State<EditCertifications> createState() => _EditCertificationsState();
}

class _EditCertificationsState extends State<EditCertifications> {

  final DocumentUploadController docCtrl = Get.put(DocumentUploadController());
  final TextEditingController qualificationDesc = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerRight,
          child: UIHelper.boldText(
            text: 'Edit Certifications',
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
            padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: AppConstantsSpacing.spacingExtraLarge),

                    // _buildDocumentSection('Qualification', Icons.description_outlined, true, docCtrl.qualificationFiles),
                    // const SizedBox(height: AppConstants.spacingMedium),
                    // _buildDocumentSection('Certificates', Icons.description_outlined, false, docCtrl.certificateFiles),
                    // const SizedBox(height: AppConstants.spacingMedium),

                    _buildDocumentSection(
                      'Qualification',
                      docCtrl.qualificationFiles.isEmpty
                          ? "doc-svg.svg" // Before upload
                          : "documents-icon.svg", // After upload
                      true,
                      docCtrl.qualificationFiles,
                    ),
                    const SizedBox(height: AppConstantsSpacing.spacingMedium),
                    _buildDocumentSection(
                      'Certificates',
                      docCtrl.qualificationFiles.isEmpty
                          ? "doc-svg.svg" // Before upload
                          : "documents-icon.svg", // After upload
                      false,
                      docCtrl.certificateFiles,
                    ),

                    const Spacer(),

                    GradientButton(
                      text: "Save Changes",
                      onTap: () {
                        debugPrint('Submit');
                        _showDetailsSubmittedBottomSheet(context);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + AppConstantsSpacing.spacingLarge),
                  ],
                ),
              ),
            ),
          );
        },
      ),

    );
  }


  Widget _buildDocumentSection(String category, String icon, bool isQualification, RxList<String> files) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingMedium, vertical: AppConstantsSpacing.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.roundbg,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              //   child: Icon(icon, color: AppColors.white, size: AppConstants.iconSizeMedium),
              // ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                // child: Icon(icon, color: AppColors.white, size: AppConstants.iconSizeMedium),
                child: UIHelper.customSvg(
                  svg: icon,
                  width: 16,
                  height: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: AppConstantsSpacing.spacingMedium),
              Expanded(
                child: Text(category,
                    style: const TextStyle(
                        fontFamily: 'BeVietnamPro', fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text)),
              ),
              InkWell(
                onTap: () => docCtrl.pickFile(isQualification: isQualification),
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingMedium, vertical: AppConstantsSpacing.paddingSmall),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary1.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle_outline, size: AppConstantsSpacing.iconSizeSmall, color: AppColors.primary1),
                      SizedBox(width: 6),
                      Text('Upload',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: 0.2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (files.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppConstantsSpacing.paddingSmall),
              child: Column(
                children: files.asMap().entries.map((entry) {
                  final index = entry.key;
                  final fileName = entry.value;
                  return _buildUploadedDocumentItem(fileName, () => docCtrl.removeFile(isQualification: isQualification, index: index));
                }).toList(),
              ),
            ),
        ],
      ),
    ));
  }

  Widget _buildUploadedDocumentItem(String fileName, VoidCallback onRemove) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstantsSpacing.paddingMedium,
        vertical: AppConstantsSpacing.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffccdaf2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          // const Icon(Icons.description_outlined, color: AppColors.grey, size: AppConstants.iconSizeSmall),
          UIHelper.customSvg(svg: "documnts-icon.svg", height: 16, width: 16),
          const SizedBox(width: AppConstantsSpacing.spacingSmall),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                fontFamily: 'BeVietnamPro',
                fontSize: 16,
                color: AppColors.text,
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: onRemove,
          //   child: const Icon(Icons.delete_outline_rounded, color: AppColors.grey, size: AppConstants.iconSizeMedium),
          // ),
          UIHelper.customSvgOnTap(
            svg: "documnats-dlt-icon.svg",
            width: 16,
            height: 16,
            onTap: onRemove,
          ),
        ],
      ),
    );
  }

  Widget _buildMultiLineInputField(String hint, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16, color: AppColors.text),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.roundbg,
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16, color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstantsSpacing.paddingMedium,
          vertical: AppConstantsSpacing.paddingMedium,
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: AppConstantsSpacing.paddingMedium),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: AppColors.grey, size: AppConstantsSpacing.iconSizeMedium),
        ),
      ),
    );
  }

  void _showDetailsSubmittedBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppConstantsSpacing.spacingExtraLarge * 2),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Color(0xffe2eafb),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.verified_outlined,
                                  color: Color(0xff0842a0),
                                  size: 38,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppConstantsSpacing.paddingLarge),
                        child: Column(
                          children: [
                            const Text(
                              'Details Submitted',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0842a0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppConstantsSpacing.spacingSmall),
                            const Text(
                              'Your details are submitted to the Admin for verification, once your details are been verified, we will update you.',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 14,
                                color: Color(0xff828282),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppConstantsSpacing.spacingExtraLarge),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => const ProfilePage()),
                                // );

                              },
                              child: Container(
                                width: double.infinity,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Color(0xff0a0a3c),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Okay',
                                  style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
