import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../utils/ui_helper.dart';
import '../../../../widgets/base_button.dart';

class LearningContentTab extends StatefulWidget {
  final PageController controller;
  final String? mode;
  final dynamic courseId;

  const LearningContentTab({
    super.key,
    required this.controller,
    required this.mode,
    required this.courseId,
  });

  @override
  State<LearningContentTab> createState() => _LearningContentTabState();
}

class _LearningContentTabState extends State<LearningContentTab> {
  //bool isCollapsed = false;
  List<ChapterData> _chapters = [];

  List<TextEditingController> _lessonList = [TextEditingController()];

  @override
  void dispose() {
    for (var controller in _lessonList) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addLesson() {
    setState(() {
      _lessonList.add(TextEditingController());
    });
  }

  void _addNewChapter() {
    setState(() {
      _chapters.add(
        ChapterData(
          chapterNumber: _chapters.length + 1,
          isCollapsed: false,
          lessonControllers: [TextEditingController()],
        ),
      );
    });
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
                  _AddNewChapter(),
                  const SizedBox(height: 20),
                  ..._chapters.asMap().entries.map((entry) {
                    final index = entry.key;
                    final chapter = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildChapterBlock(index, chapter),
                    );
                  }).toList(),

                  const Spacer(),

                  // SizedBox(height: 51,),
                  GradientButton(
                    text: widget.mode == "upload" ? "Proceed" : "Save Changes ",
                    onTap: () {
                      widget.controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   borderRadius: BorderRadius.circular(40),
                  //   child: Container(
                  //     height: 60,
                  //     decoration: BoxDecoration(
                  //       color: _chapters.length > 0
                  //           ? const Color(0xFF04002C)
                  //           : const Color(0xFF686682),
                  //       borderRadius: BorderRadius.circular(40),
                  //       border: Border.all(
                  //         color: _chapters.length > 0
                  //             ? const Color(0xFF04002C)
                  //             : const Color(0xFF686682),
                  //         width: 2,
                  //       ),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         const SizedBox(width: 24),
                  //         Text(
                  //           widget.mode == "upload"
                  //               ? "Proceed"
                  //               : "Save Changes ",
                  //           style: TextStyle(
                  //             color: AppColors.white,
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 16,
                  //
                  //           ),
                  //         ),
                  //         const Spacer(),
                  //         Container(
                  //           height: 60,
                  //           width: 80,
                  //           decoration: const BoxDecoration(
                  //             gradient: LinearGradient(
                  //               colors: [
                  //                 Color(0x00000000), // Transparent
                  //                 Color(0xFF6C6A86), // Gradient color
                  //               ],
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight,
                  //             ),
                  //             borderRadius: BorderRadius.only(
                  //               topRight: Radius.circular(26),
                  //               bottomRight: Radius.circular(26),
                  //             ),
                  //           ),
                  //           alignment: Alignment.centerRight,
                  //           // child: Icon(
                  //           //   icon,
                  //           //   color: Colors.white,
                  //           //   size: 20,
                  //           // ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(right: 16),
                  //             child: UIHelper.customSvgOnTap(
                  //               svg: "bak-btn-botam.svg",
                  //               width: 20,
                  //               height: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: MediaQuery.of(context).padding.bottom + 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _AddNewChapter() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE6E8ED),
        borderRadius: BorderRadius.circular(32),
      ),
      child: UploadNewChapterBox(onTap: _addNewChapter),
    );
  }

  Widget _buildChapterBlock(int chapterNumber, ChapterData chapter) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: const Color(0xffe1eaf8),
        borderRadius: BorderRadius.circular(31),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Chapter Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UIHelper.boldText(
                        text: 'Ch${chapter.chapterNumber}. ',
                        fontSize: 12,
                        color: AppColors.textblue,
                      ),
                      UIHelper.boldText(
                        text: 'Define Chapter Name',
                        fontSize: 12,
                        color: AppColors.text,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // UIHelper.boldText(
                  //   text: '${chapter.chapterNumber} Lesson', //chapter.lessonControllers
                  //   fontSize: 12,
                  //   color: AppColors.textblue,
                  // ),

                  UIHelper.boldText(
                    text: '${chapter.lessonControllers.length} Lesson',
                    fontSize: 12,
                    color: Color(0xff888ca8),
                  ),



                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    chapter.isCollapsed = !chapter.isCollapsed;
                  });
                },
                child: Container(
                  // width: 48,
                   height: 32,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),

                  /// Toggle Icon
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        chapter.isCollapsed = !chapter.isCollapsed;
                      });
                    },

                    child: UIHelper.customSvgOnTap(
                      svg: chapter.isCollapsed
                          ? "expand-icon-off.svg"
                          : "expand-icon-on.svg",
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Only show the following widgets if not collapsed
          if (!chapter.isCollapsed) ...[
            const SizedBox(height: 16),

            /// Lesson Input
            // SafeArea(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Column(
            //           children: List.generate(chapter.lessonControllers.length, (index) {
            //             return Padding(
            //               padding: const EdgeInsets.symmetric(vertical: 6.0),
            //               child: Row(
            //                 children: [
            //                   Container(
            //                     width: 45,
            //                     height: 40,
            //                     alignment: Alignment.center,
            //                     decoration: BoxDecoration(
            //                       color: Colors.blue.shade100,
            //                       borderRadius: BorderRadius.circular(82),
            //                     ),
            //                     child: Text(
            //                       '${index + 1}.',
            //                       style: TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.blue.shade800,
            //                       ),
            //                     ),
            //                   ),
            //                   const SizedBox(width: 8),
            //                   Expanded(
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                         color: Colors.blue.shade50,
            //                         borderRadius: BorderRadius.circular(82),
            //                       ),
            //                       padding: const EdgeInsets.only(left: 16, right: 5, top: 5, bottom: 5),
            //                       child: Row(
            //                         children: [
            //                           Expanded(
            //                             child: TextField(
            //                               controller: chapter.lessonControllers[index],
            //                               decoration: const InputDecoration(
            //                                 hintText: 'Lesson Name',
            //                                 border: InputBorder.none,
            //                                 isDense: true,
            //                                 contentPadding: EdgeInsets.zero,
            //                               ),
            //                             ),
            //                           ),
            //                           if (index == chapter.lessonControllers.length - 1)
            //                             Container(
            //                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            //                               decoration: BoxDecoration(
            //                                 color: Colors.white,
            //                                 borderRadius: BorderRadius.circular(82),
            //                               ),
            //                               child: UIHelper.customSvgOnTap(
            //                                 svg: "round-add-icon-svg.svg",
            //                                 onTap: () {
            //                                   setState(() {
            //                                     chapter.lessonControllers.add(TextEditingController());
            //                                   });
            //                                 },
            //                               ),
            //                             ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           }),
            //       ),
            //     ],
            //   ),
            // ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: List.generate(chapter.lessonControllers.length, (
                      index,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            // Number Circle
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Lesson TextField + Action Button
                            // Expanded(
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       color: Colors.blue.shade50,
                            //       borderRadius: BorderRadius.circular(32),
                            //     ),
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 12,
                            //       vertical: 6,
                            //     ),
                            //     child: Row(
                            //       children: [
                            //         Expanded(
                            //           child: TextField(
                            //             controller:
                            //                 chapter.lessonControllers[index],
                            //             decoration: const InputDecoration(
                            //               hintText: 'Lesson Name',
                            //               border: InputBorder.none,
                            //               isDense: true,
                            //             ),
                            //           ),
                            //         ),
                            //
                            //         const SizedBox(width: 6),
                            //
                            //         // Remove Button
                            //         if (chapter.lessonControllers.length > 1)
                            //           GestureDetector(
                            //             onTap: () {
                            //               setState(() {
                            //                 chapter.lessonControllers.removeAt(
                            //                   index,
                            //                 );
                            //               });
                            //             },
                            //             child: Container(
                            //               decoration: BoxDecoration(
                            //                 color: Colors.red.shade100,
                            //                 shape: BoxShape.circle,
                            //               ),
                            //               padding: const EdgeInsets.all(6),
                            //               child: const Icon(
                            //                 Icons.remove,
                            //                 color: Colors.red,
                            //                 size: 18,
                            //               ),
                            //             ),
                            //           ),
                            //
                            //         // Add Button (only on last item)
                            //         if (index == chapter.lessonControllers.length - 1)
                            //           const SizedBox(width: 6),
                            //         if (index ==
                            //             chapter.lessonControllers.length - 1)
                            //           Container(
                            //             padding: const EdgeInsets.symmetric(
                            //               horizontal: 12,
                            //               vertical: 6,
                            //             ),
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius: BorderRadius.circular(
                            //                 82,
                            //               ),
                            //             ),
                            //             child: UIHelper.customSvgOnTap(
                            //               svg: "round-add-icon-svg.svg",
                            //               onTap: () {
                            //                 setState(() {
                            //                   chapter.lessonControllers.add(
                            //                     TextEditingController(),
                            //                   );
                            //                 });
                            //               },
                            //             ),
                            //           ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                 color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                // padding: const EdgeInsets.symmetric(
                                //   horizontal: 4,
                                //   vertical: 6,
                                // ),
                                padding: EdgeInsets.only(left: 12, right: 5, top: 3,  bottom: 3),
                                child: Row(
                                  children: [
                                    // 🔤 TextField
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            chapter.lessonControllers[index],
                                        decoration: const InputDecoration(
                                          hintText: 'Lesson Name',
                                          border: InputBorder.none,
                                          isDense: true,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 6),

                                    // ❌ Remove Button (show always if more than 1)
                                    if (index !=
                                        chapter.lessonControllers.length - 1)
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     setState(() {
                                      //       chapter.lessonControllers.removeAt(index);
                                      //     });
                                      //   },
                                      //   child: Container(
                                      //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       borderRadius: BorderRadius.circular(82),
                                      //     ),
                                      //     child: UIHelper.customSvgOnTap(
                                      //       svg: "round-add-icon-svg.svg",
                                      //       onTap: () {
                                      //         setState(() {
                                      //           chapter.lessonControllers.add(TextEditingController());
                                      //         });
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        width: 40,
                                        height: 32,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            82,
                                          ),
                                        ),
                                        child: UIHelper.customSvgOnTap(
                                          svg: "2-remove-svg.svg",
                                          width: 16,
                                          height: 16,
                                          onTap: () {
                                            setState(() {
                                              chapter.lessonControllers
                                                  .removeAt(index);
                                            });
                                          },
                                        ),
                                      ),

                                    // ➕ Add Button (only on last item)
                                    if (index ==
                                        chapter.lessonControllers.length -
                                            1) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        width: 40,
                                        height: 32,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            82,
                                          ),
                                        ),
                                        child: UIHelper.customSvgOnTap(
                                          svg: "round-add-icon-svg.svg",
                                          width: 16,
                                          height: 16,
                                          onTap: () {
                                            setState(() {
                                              chapter.lessonControllers.add(
                                                TextEditingController(),
                                              );
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Upload Buttons
            // Row(
            //   children: [
            //     // Video Button
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: () {
            //           // Upload video
            //         },
            //         child: Container(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 12,
            //             horizontal: 8,
            //           ),
            //           decoration: BoxDecoration(
            //             color: Colors.grey[100],
            //             borderRadius: BorderRadius.circular(82),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               UIHelper.customSvg(svg: "play-icon-svg.svg"),
            //               const SizedBox(width: 6),
            //               const Text(
            //                 'Upload Video',
            //                 style: TextStyle(fontSize: 14, color: Colors.black),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //     const SizedBox(width: 10),
            //
            //     // Article Button
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: () {
            //           // Upload article
            //         },
            //         child: Container(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 12,
            //             horizontal: 8,
            //           ),
            //           decoration: BoxDecoration(
            //             color: Colors.grey[100],
            //             borderRadius: BorderRadius.circular(82),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               UIHelper.customSvg(svg: "atrical-svg-icon.svg"),
            //               const SizedBox(width: 6),
            //               const Text(
            //                 'Upload Article',
            //                 style: TextStyle(fontSize: 14, color: Colors.black),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            UploadButtonsRow(),
          ],
        ],
      ),
    );
  }
}

class UploadNewChapterBox extends StatelessWidget {
  final VoidCallback onTap;

  const UploadNewChapterBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <--- Trigger add
      child: CustomPaint(
        painter: DashedRectPainter(
          strokeWidth: 1.5,
          dashWidth: 8,
          dashSpace: 5,
          color: AppColors.black,
          radius: 46,
        ),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffE6E8ED),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UIHelper.customSvg(svg: 'add-icon.svg', height: 20, width: 20),
              const SizedBox(width: 8),
              UIHelper.boldText(
                text: 'Add New Chapter',
                fontSize: 12,
                color: AppColors.textblue,
              ),
            ],
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
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    drawDashedPath(canvas, path, paint);
  }

  void drawDashedPath(Canvas canvas, Path path, Paint paint) {
    double dashOn = dashWidth;
    double dashOff = dashSpace;
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final nextDashLength = dashOn;
        final segment = metric.extractPath(distance, distance + nextDashLength);
        canvas.drawPath(segment, paint);
        distance += dashOn + dashOff;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Model for each chapter
class ChapterData {
  final int chapterNumber;
  bool isCollapsed;
  List<TextEditingController> lessonControllers;

  ChapterData({
    required this.chapterNumber,
    this.isCollapsed = false,
    required this.lessonControllers,
  });
}

class UploadButtonsRow extends StatefulWidget {
  const UploadButtonsRow({super.key});

  @override
  State<UploadButtonsRow> createState() => _UploadButtonsRowState();
}

class _UploadButtonsRowState extends State<UploadButtonsRow> {
  Uint8List? _thumbnailBytes;
  String? _fileName;
  String? _fileType;
  String? _filePath;
  VideoPlayerController? _videoController;
  bool _isLoading = false;

  /// Helper to pick video file
  // Future<void> _pickVideoFile(BuildContext context) async {
  //   final status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     final result = await Permission.storage.request();
  //     if (!result.isGranted) {
  //       _showPermissionSnackbar(context);
  //       return;
  //     }
  //   }
  //
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.video,
  //       allowMultiple: false,
  //     );
  //
  //     if (result != null) {
  //       final file = result.files.single;
  //       debugPrint("Video file picked: ${file.name}, Size: ${file.size}");
  //       // Handle video file here
  //     }
  //   } catch (e) {
  //     debugPrint("Error picking video file: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Failed to pick video.")),
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
          //_filePath = file.path;
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

  // /// Helper to pick article file (pdf/doc/docx)
  void _showPermissionSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Permission required. Please allow access."),
        action: SnackBarAction(
          label: "Settings",
          onPressed: () {
            openAppSettings();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Upload Video Button
        Expanded(
          child: GestureDetector(
            onTap: () => _onTapPickFile(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(82),
              ),
              child: FittedBox( // ✅ prevents overflow
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UIHelper.customSvg(svg: "play-icon-svg.svg"),
                    const SizedBox(width: 6),
                    UIHelper.boldText(
                      text: "Upload Video",
                      fontSize: 12,
                      color: AppColors.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Upload Article Button
        Expanded(
          child: GestureDetector(
            onTap: () => _onTapPickFile(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(82),
              ),
              child: FittedBox( // ✅ prevents overflow
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UIHelper.customSvg(svg: "atrical-svg-icon.svg"),
                    const SizedBox(width: 6),
                    UIHelper.boldText(
                      text: "Upload Article",
                      fontSize: 12,
                      color: AppColors.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }
}
