import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/widgets/base_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../utils/ui_helper.dart';
import 'general_info_tab.dart';
import 'learning_content_tab.dart';
import 'description_tab.dart';

class UploadCourseScreen extends StatefulWidget {

  const UploadCourseScreen({super.key});

  @override
  State<UploadCourseScreen> createState() => _UploadCourseScreenState();
}

class _UploadCourseScreenState extends State<UploadCourseScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String? mode;
  dynamic courseId;

  final List<String> _titles = [
    '1. General Information',
    '2. Learning Content',
    '3. Course Description',
  ];

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  @override
  void initState() {
    super.initState();

    // Receive and print arguments from Get.to()
    final args = Get.arguments;

    mode = args['mode']; // "upload" or "edit"
    courseId = args['courseId']; // optional in upload mode

    // ✅ Console print
    print("UploadCourseScreen Mode: $mode");
    if (mode == 'edit') {
      print("Editing Course ID: $courseId");
    }
    if (mode == 'upload') {
      print("upload Course : $courseId");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeaf2ff),
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildDecorativeBackground(),
          SafeArea(
            child: Column(
              children: [
                mode == 'edit' ? _buildTopIndicatorEdit(context) : _buildTopIndicatorUplode(context),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -3))],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        children:  [
                          GeneralInfoTab(controller: _pageController, mode: mode, courseId: courseId),
                          LearningContentTab(controller: _pageController, mode: mode, courseId: courseId),
                          DescriptionTab(controller: _pageController, mode: mode, courseId: courseId),
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
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 60,
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
      title: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children:  [
            UIHelper.boldText(
              text: mode == 'edit' ? 'Edit Course' : 'Upload Course',
              fontSize: 18,
              color: AppColors.text,
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTopIndicatorEdit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
     // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xffCDDCF4),
          borderRadius: BorderRadius.circular(46),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 8,),
            // SizedBox(
            //   width: 140,
            //   child: Expanded(
            //     child: UIHelper.boldText(
            //       text: _titles[_currentPage],
            //       fontSize: 12,
            //       color: AppColors.text,
            //     ),
            //   ),
            // ),
            Expanded(
              child: Text(
                _titles[_currentPage],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.text, // match your UIHelper color
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),

            // Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// ⬅️ Previous
                GestureDetector(
                  // onTap: _previouslist,
                  onTap: _currentPage > 0 ? _previouslist : null,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: SizedBox(
                          width: 18,
                          height: 18,
                          child: UIHelper.customSvg(svg: "left-svg.svg",
                          color: _currentPage > 0 ? AppColors.primary1 : AppColors.grey,
                          ),),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                /// ➡️ Next
                GestureDetector(
                  // onTap: _nextList,
                  onTap: _currentPage < _titles.length - 1 ? _nextList : null,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      height: 18,
                      width: 18,
                      child: Center(
                        child: UIHelper.customSvg(svg: "right-svg.svg",
                        color:  _currentPage < _titles.length - 1
                          ? AppColors.primary1
                          : AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildTopIndicatorUplode(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xffCDDCF4),
          borderRadius: BorderRadius.circular(46),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: UIHelper.boldText(
                text: _titles[_currentPage],
                fontSize: 12,
                color: AppColors.text,
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                expansionFactor: 3,
                dotHeight: 8,
                dotWidth: 24,
                spacing: 6,
                radius: 8,
                dotColor: AppColors.grey,
                activeDotColor: AppColors.textblue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return UIHelper.customImage(
      img: "bg.png",
      fit: BoxFit.cover,
    );
  }

  void _previouslist() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextList() {
    if (_currentPage < _titles.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


}
