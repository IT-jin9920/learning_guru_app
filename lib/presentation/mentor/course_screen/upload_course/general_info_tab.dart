import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/widgets/base_button.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../../res/constants/constants.dart';
import '../../../../utils/ui_helper.dart';
import '../../../../utils/validation.dart';
import '../../../profile_screen/edit_profile_image/edit_profile_image.dart';
import 'learning_content_tab.dart';

class GeneralInfoTab extends StatefulWidget {
  final PageController controller;
  final String? mode;
  final dynamic courseId;

  const GeneralInfoTab({
    super.key,
    required this.controller,
    required this.mode,
    required this.courseId,
  });

  @override
  State<GeneralInfoTab> createState() => _GeneralInfoTabState();
}

class _GeneralInfoTabState extends State<GeneralInfoTab> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCategoryController =
      TextEditingController();
  final TextEditingController coursePriceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ Print mode and courseId in console
    print("GeneralInfoTab Loaded");
    print("🔹 Mode: ${widget.mode}");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _uploadThumbnailBox(),
                  const SizedBox(height: 24),
                  _buildInputField(
                    'Course Name',
                    "Courses.svg",
                    courseNameController,
                    Validator.validateCourseName,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    'Course Category',
                    "bottam-side-arrow-svg-icon.svg",
                    courseCategoryController,
                    Validator.validateCourseCategory,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    'Course Price',
                    "price-svg.svg",
                    coursePriceController,
                    Validator.validateCoursePrice,
                    keyboardType: TextInputType.number,
                  ),
                  // const Spacer(),
                  SizedBox(height: 51),
                  GradientButton(
                    text: widget.mode == "upload" ? "Proceed" : "Save Changes ",
                    onTap: () {
                      widget.controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _uploadThumbnailBox() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE6E8ED),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const UploadThumbnailBox(),
    );
  }

  Widget _buildInputField(
    String hintText,
    String svgIcon,
    TextEditingController controller,
    String? Function(String?) validator, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'BeVietnamPro',
        fontSize: 16,
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffCDDCF4),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 16,
          color: Color(0xff898da9),
        ),
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
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingMedium,
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: AppConstants.paddingMedium),
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: UIHelper.customSvg(svg: svgIcon, height: 20, width: 20),
        ),
      ),
    );
  }
}

class UploadThumbnailBox extends StatefulWidget {
  const UploadThumbnailBox({super.key});

  @override
  State<UploadThumbnailBox> createState() => _UploadThumbnailBoxState();
}

class _UploadThumbnailBoxState extends State<UploadThumbnailBox> {
  Uint8List? _thumbnailBytes;
  String? _fileName;
  String? _fileType;
  String? _filePath;
  VideoPlayerController? _videoController;
  bool _isLoading = false;

  /// Handle permission and image picking with preview and validation
  // Future<void> _pickFile(BuildContext context) async {
  //   PermissionStatus status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     final result = await Permission.storage.request();
  //     if (!result.isGranted) {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text("Storage permission denied"),
  //           action: SnackBarAction(
  //             label: 'Settings',
  //             onPressed: openAppSettings,
  //           ),
  //         ),
  //       );
  //       return;
  //     }
  //   }
  //
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       withData: true,
  //       allowMultiple: false,
  //       type: FileType.image,
  //     );
  //
  //     if (result != null && result.files.single.bytes != null) {
  //       final file = result.files.single;
  //
  //       if (file.size > 5 * 1024 * 1024) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("File exceeds 5MB limit.")),
  //         );
  //         return;
  //       }
  //
  //       setState(() {
  //         _thumbnailBytes = file.bytes;
  //         _fileName = file.name;
  //       });
  //
  //       debugPrint('Selected file: ${file.name}');
  //     }
  //   } catch (e) {
  //     debugPrint("File picking failed: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Error selecting image.")),
  //     );
  //   }
  // }

  Future<void> _onTapPickFile() async {
    // Prevent picking new file if one is already loading or initialized
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await FilePicker.platform.pickFiles(withData: true);

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        final mimeType = lookupMimeType(file.name, headerBytes: file.bytes);

        // Dispose old controller if any
        if (_videoController != null) {
          await _videoController!.pause();
          await _videoController!.dispose();
          _videoController = null;
        }

        if (mimeType != null && mimeType.startsWith('video/')) {
          final pickedFile = File(file.path!);

          _videoController = VideoPlayerController.file(pickedFile);
          await _videoController!.initialize();
          await _videoController!.setLooping(true);
        }

        setState(() {
          _fileName = file.name;
          _fileType = mimeType;
          _thumbnailBytes = file.bytes;
          _filePath = file.path;
        });

        Get.snackbar(
          "✅ File Selected",
          file.name,
          backgroundColor: Colors.green.shade100,
        );
      } else {
        Get.snackbar(
          "⚠️ No file selected",
          "Please select a file",
          backgroundColor: Colors.orange.shade100,
        );
      }
    } catch (e) {
      debugPrint("❌ File pick/init error: $e");
      Get.snackbar(
        "❌ Error",
        "Something went wrong while picking the file.",
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTapPickFile,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomPaint(
          painter: DashedRectPainter(
            strokeWidth: 1,
            dashWidth: 8  ,
            dashSpace: 6,
            color: AppColors.text,
            radius: 24,
          ),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffE6E8ED),
              borderRadius: BorderRadius.circular(32),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),

              // child: _thumbnailBytes != null
              //     ? Stack(
              //   fit: StackFit.expand,
              //   children: [
              //     Image.memory(
              //       _thumbnailBytes!,
              //       fit: BoxFit.cover,
              //     ),
              //     // Positioned(
              //     //   bottom: 10,
              //     //   left: 10,
              //     //   right: 10,
              //     //   child: Container(
              //     //     color: Colors.black54,
              //     //     padding: const EdgeInsets.symmetric(
              //     //       horizontal: 8,
              //     //       vertical: 4,
              //     //     ),
              //     //     child: Text(
              //     //       _fileName ?? '',
              //     //       style: const TextStyle(
              //     //         color: Colors.white,
              //     //         fontSize: 12,
              //     //         fontWeight: FontWeight.w500,
              //     //       ),
              //     //       overflow: TextOverflow.ellipsis,
              //     //       maxLines: 1,
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // )
              //     : Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.all(16),
              //       decoration: BoxDecoration(
              //         color: Colors.blue.shade50,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Icon(
              //         Icons.cloud_upload_outlined,
              //         size: 40,
              //         color: Colors.blue.shade700,
              //       ),
              //     ),
              //     const SizedBox(height: 12),
              //     const Text(
              //       'Upload Course Thumbnail',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     const SizedBox(height: 6),
              //     const Text(
              //       'Max size: 5 MB • Image only',
              //       style: TextStyle(
              //         fontSize: 12,
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ],
              // ),
              child: _isLoading
                  ? Center(child: Text("LODING..."))
                  : _fileType == null
                  ? GestureDetector(
                      onTap: _onTapPickFile,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: UIHelper.customSvg(
                                svg: "img-uplode-icon-svg.svg",
                              ),
                            ),
                          ),

                          //  UIHelper.customSvg(svg: "img-uplode-icon-svg.svg"),
                          // Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          UIHelper.boldText(
                            text: "Upload Course Media",
                            fontSize: 12,
                            color: AppColors.text,
                          ),
                          SizedBox(height: 5),
                          UIHelper.regularText(
                            text: 'Max size: 5 MB ',
                            fontSize: 10,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                    )
                  : _buildFilePreview(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview() {
    if (_fileType == null) {
      return const SizedBox.shrink();
    }

    if (_fileType!.startsWith('image/')) {
      return Image.memory(_thumbnailBytes!, fit: BoxFit.cover);
    } else if (_fileType!.startsWith('video/') && _videoController != null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          IconButton(
            icon: Icon(
              _videoController!.value.isPlaying
                  ? Icons.pause_circle_outline
                  : Icons.play_circle_outline,
              size: 50,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _videoController!.value.isPlaying
                    ? _videoController!.pause()
                    : _videoController!.play();
              });
            },
          ),
        ],
      );
    } else if (_fileType!.contains('pdf')) {
      return const Icon(Icons.picture_as_pdf, size: 60, color: Colors.red);
    } else if (_fileType!.contains('audio')) {
      return const Icon(Icons.audiotrack, size: 60, color: Colors.deepPurple);
    } else {
      return const Icon(Icons.insert_drive_file, size: 60, color: Colors.grey);
    }
  }
}

class DashedRectPainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final double radius;

  DashedRectPainter({
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
    this.radius = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    drawDashedPath(canvas, path, paint);
  }

  void drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
