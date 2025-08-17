import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';
import '../../../../../widgets/base_button.dart';

class PollCreate extends StatefulWidget {
  const PollCreate({Key? key}) : super(key: key);

  @override
  State<PollCreate> createState() => _PollCreateState();
}

class _PollCreateState extends State<PollCreate> with WidgetsBindingObserver {
  final TextEditingController courseDescriptionController =
      TextEditingController();
  List<TextEditingController> learnDescriptionControllers = [
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffEAF2FF),
        resizeToAvoidBottomInset: true, // ✅ prevents overflow with keyboard
        body: Stack(
          children: [
            Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBarRow(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: SingleChildScrollView(
                        // ✅ Wrap everything in scroll view
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        // Optional for spacing
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Course Description Field
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffe1eaf8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 18,
                              ),
                              child: TextField(
                                controller: courseDescriptionController,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                decoration: const InputDecoration(
                                  hintText: 'Describe poll question...',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UIHelper.boldText(
                                  text: "Define Options",
                                  fontSize: 16,
                                  color: AppColors.text,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    color: AppColors.textblue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: UIHelper.customSvgOnTap(
                                    svg: "add-icon.svg",
                                    onTap: () {
                                      setState(() {
                                        learnDescriptionControllers.add(
                                          TextEditingController(),
                                        );
                                      });
                                    },
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Lesson Input Fields
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                learnDescriptionControllers.length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(82),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  learnDescriptionControllers[index],
                                              decoration:  InputDecoration(
                                                hintText: 'Option ${index + 1}',
                                                hintStyle: const TextStyle(
                                                  fontFamily: 'Be Vietnam Pro',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                          UIHelper.customSvgOnTap(
                                            svg: "cancalled-icon-svg.svg",
                                            onTap: () {
                                              setState(() {
                                                learnDescriptionControllers
                                                    .removeAt(index);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 24),

                            // ✅ Replace Spacer with fixed space

                            // Submit Button
                            // GradientButton(
                            //   text: "Create Poll",
                            //   onTap: () {
                            //     Get.back();
                            //   },
                            // ),
                            const SizedBox(height: 20),
                            // ✅ Bottom padding for safe scroll
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
            child: GradientButton(
              text: "Create Poll",
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return Stack(
      children: [UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover)],
    );
  }
}

class CustomAppBarRow extends StatelessWidget {
  const CustomAppBarRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFCEDBF1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
            ),
          ),

          // Title
          Center(
            child: Text(
              'Create Poll',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Right space filler to align center properly
          // const SizedBox(width: 40),
        ],
      ),
    );
  }
}
