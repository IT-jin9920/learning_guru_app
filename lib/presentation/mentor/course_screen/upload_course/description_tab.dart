import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import '../../../../widgets/base_button.dart';

class DescriptionTab extends StatefulWidget {
  final PageController controller;
  final String? mode;
  final dynamic courseId;

  const DescriptionTab({
    super.key,
    required this.controller,
    required this.mode,
    required this.courseId,
  });

  @override
  State<DescriptionTab> createState() => _DescriptionTabState();
}

class _DescriptionTabState extends State<DescriptionTab> {
  final TextEditingController courseDescriptionController =
      TextEditingController();
  List<TextEditingController> learnDescriptionControllers = [
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
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
                        hintText: 'Write Course Description...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Header Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIHelper.boldText(
                        text: "What will Student Learn",
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
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller:
                                        learnDescriptionControllers[index],
                                    decoration: const InputDecoration(
                                      hintText: 'Describe',
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
                                      learnDescriptionControllers.removeAt(
                                        index,
                                      );
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

                  const Spacer(),

                  // SizedBox(height: 51,),

                  // Submit Button
                  GradientButton(
                    text: widget.mode == "upload" ? "Publish Course " : "Save Changes ",

                    onTap: () {
                      // Submit logic here
                      Get.back(); // or navigate somewhere
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).padding.bottom + 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
