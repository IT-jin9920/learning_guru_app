import 'dart:io';
import 'dart:typed_data';
import 'package:mime/mime.dart'; // Needed for lookupMimeType

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_guru_app/widgets/base_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/common/doumnts_uplode.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/constants/constants.dart';
import '../../../../utils/ui_helper.dart';
import '../../../../utils/validation.dart';
import 'video_player_privew_widgets.dart';


class UploadFunlernScreen extends StatefulWidget {
  const UploadFunlernScreen({super.key});

  @override
  State<UploadFunlernScreen> createState() => _UploadFunlernScreenState();
}

class _UploadFunlernScreenState extends State<UploadFunlernScreen> {

  @override
  Widget build(BuildContext context) {

    final TextEditingController videoTitleController = TextEditingController();
    final TextEditingController videoCategoryController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFeaf2ff),
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildDecorativeBackground(),
          Container(
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -3))],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 24,
                        bottom: 24,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _uploadThumbnailBox(),
                              const SizedBox(height: 24),
                              _buildInputField('Video Title', "Courses.svg",  videoTitleController,  Validator.validateCourseName,),
                              const SizedBox(height: 16),
                              _buildInputField('Video Category', "bottam-side-arrow-svg-icon.svg",  videoCategoryController,Validator.validateCourseCategory,),

                             // Spacer(),
                              SizedBox(height: 51,),

                              /// Publish Button
                              GradientButton(
                                text: "Publish",
                                onTap: () {
                                  Get.back();
                                },
                              ),
                              // To ensure spacing for notch
                              SizedBox(height: MediaQuery.of(context).padding.bottom + AppConstants.spacingExtraLarge),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(color: Color(0xFFCEDBF1), shape: BoxShape.circle),
            padding: const EdgeInsets.all(8),
            child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:  [
          UIHelper.boldText(text: 'Upload Fun Learning',fontSize: 18, color: AppColors.text),
        ],
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return UIHelper.customImage(
      img: "bg.png",
      fit: BoxFit.cover,
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
          color: Color(0xff888ca8),
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
          child: UIHelper.customSvg(
            svg: svgIcon,
            height: 20,
            width: 20,
          ),
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

  @override
  void initState() {
    super.initState();
   // _checkStoragePermission(); // Ask permission on first load if needed
  }

  Future<void> _checkStoragePermission() async {
    Permission permission =
    Platform.isAndroid ? Permission.storage : Permission.photos;
    if (!await permission.isGranted) {
      await permission.request();
    }
  }


  void _onTapPickFile() async {
   // final file = await FilePickerUtil.pickAnyFile();
    final file = await FilePickerUtil.pickAnyFile(); // or FilePicker.platform.pickFiles()

    // if (file != null) {
    //   final mimeType = lookupMimeType(file.name, headerBytes: file.bytes);
    //   setState(() {
    //     _fileName = file.name;
    //     _fileType = mimeType;
    //     _thumbnailBytes = file.bytes;
    //   });
    //
    //   Get.snackbar(
    //     "File Selected",
    //     file.name,
    //     backgroundColor: Colors.green.shade100,
    //   );
    // } else {
    //   Get.snackbar(
    //     "No file selected",
    //     "Please select a file",
    //     backgroundColor: Colors.orange.shade100,
    //   );
    // }

    if (file != null) {
      // Check if file size is under 50MB (50 * 1024 * 1024 bytes)
      final fileSizeInBytes = file.bytes?.lengthInBytes ?? 0;
      if (fileSizeInBytes > 50 * 1024 * 1024) {
        Get.snackbar(
          "File Too Large",
          "Please select a file smaller than 50 MB.",
          backgroundColor: Colors.red.shade100,
        );
        return;
      }

      final mimeType = lookupMimeType(file.name, headerBytes: file.bytes);
      setState(() {
        _fileName = file.name;
        _fileType = mimeType;
        _thumbnailBytes = file.bytes;
      });

      Get.snackbar(
        "File Selected",
        file.name,
        backgroundColor: Colors.green.shade100,
      );
    } else {
      // Get.snackbar(
      //   "No File Selected",
      //   "Please select a file.",
      //   backgroundColor: Colors.orange.shade100,
      // );
    }

    if (file != null) {
      final mimeType = lookupMimeType(file.name, headerBytes: file.bytes);
      setState(() {
        _fileName = file.name;
        _fileType = mimeType;
        _thumbnailBytes = file.bytes;
      });

      Get.snackbar(
        "File Selected",
        file.name,
        backgroundColor: Colors.green.shade100,
      );
    } else {
      // Get.snackbar(
      //   "No file selected",
      //   "Please select a file",
      //   backgroundColor: Colors.orange.shade100,
      // );
    }
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTapPickFile,
      //onTap: _pickMediaFile,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomPaint(
          painter: DashedRectPainter(
            strokeWidth: 1.5,
            dashWidth: 8,
            dashSpace: 5,
            color: AppColors.text,
            radius: 24,
          ),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffE6E8ED),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: _thumbnailBytes != null
                  ? _fileType != null && _fileType!.startsWith('image/')
                  ? Image.memory(_thumbnailBytes!, fit: BoxFit.cover)
                  : _fileType!.startsWith('video/')
                  ? FilePickerPreview()
                  : _fileType!.contains('pdf')
                  ? const Center(child: Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),)
                  : _fileType!.contains('audio')
                  ? const Center(
                child: Icon(Icons.audiotrack, size: 40, color: Colors.deepPurple),
              )
                  : const Center(
                child: Icon(Icons.insert_drive_file, size: 40, color: Colors.grey),
              )
                  :  Column(
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
                  text: "Upload Video Here",
                  fontSize: 12,
                  color: AppColors.text,
                ),
                SizedBox(height: 5),
                UIHelper.regularText(
                  text: 'Max size: 50 MB ',
                  fontSize: 10,
                  color: AppColors.grey,
                ),
              ],
            ),

            ),
          ),
        ),
      ),
    );
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
      ..addRRect(RRect.fromRectAndRadius(
        Offset.zero & size,
        Radius.circular(radius),
      ));

    drawDashedPath(canvas, path, paint);
  }

  void drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final segment = metric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



class FilePickerPreview extends StatefulWidget {
  const FilePickerPreview({super.key});

  @override
  State<FilePickerPreview> createState() => _FilePickerPreviewState();
}

class _FilePickerPreviewState extends State<FilePickerPreview> {
  Uint8List? _thumbnailBytes;
  String? _fileName;
  String? _fileType;
  String? _filePath;
  VideoPlayerController? _videoController;
  bool _isLoading = false;


  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }


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

        // 50 MB
        final fileSizeInMB = file.size / (1024 * 1024); // Convert bytes to MB
        if (fileSizeInMB > 50) {
          Get.snackbar(
            "❌ File too large",
            "Please select a file smaller than 50MB.",
            backgroundColor: Colors.red.shade100,
          );
          return; // Do not proceed
        }

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
        // Get.snackbar(
        //   "⚠️ No file selected",
        //   "Please select a file",
        //   backgroundColor: Colors.orange.shade100,
        // );
      }
    } catch (e) {
      debugPrint("❌ File pick/init error: $e");
      // Get.snackbar(
      //   "❌ Error",
      //   "Something went wrong while picking the file.",
      //   backgroundColor: Colors.red.shade100,
      // );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: _onTapPickFile,
            borderRadius: BorderRadius.circular(24),
          child: Stack(
          children: [
             Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffE6E8ED),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black26),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: _isLoading
                    ? Center(child: Text("LODING..."))
                    : _fileType == null
                    ? GestureDetector(
                  onTap: _onTapPickFile,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text("Upload Course Media"),
                      Text(
                        'Max size: 5 MB • jpg, pdf, video, doc',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                )
                    : _buildFilePreview(),
              ),
            ),
            
        ],
      ),

    ),
          //const SizedBox(height: 12),
          // if (_fileName != null)
          //   Text(
          //     _fileName!,
          //     style: const TextStyle(fontWeight: FontWeight.w600),
          //   ),
        ],
      ),
    );
  }
}
