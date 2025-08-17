import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';

import '../../../../utils/ui_helper.dart';
import '../../../../widgets/Custom_Date_BottomSheet.dart';


class EarningReportScreen extends StatefulWidget {
  const EarningReportScreen({super.key});

  @override
  State<EarningReportScreen> createState() => _EarningReportScreenState();
}

class _EarningReportScreenState extends State<EarningReportScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeaf2ff),

     // backgroundColor: Colors.transparent, // Transparent so bg image shows
      extendBodyBehindAppBar: true, // Key point to show image behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              //Get.back();
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
        ),

        // 👇 Align title to right using a Row
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns to the right
            children: const [
              Text(
                'Earning Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        // centerTitle: true is removed or should be false
        centerTitle: false,
      ),

      body: Stack(
        children: [
          _buildDecorativeBackground(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                //_buildCustomAppBar(context),
                const SizedBox(height: 16),
                _buildDateSelector(),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildSegmentedControl(),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Weekly Report'),
                          const SizedBox(height: 20),
                          _buildBarChart(),
                          const SizedBox(height: 30),
                          Container(height: 1, width: double.infinity, color: Color(0xffCDDCF4)),

                          _buildEarningSummary(),
                          Container(height: 1, width: double.infinity, color: Color(0xffCDDCF4)),

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

  Widget _buildDecorativeBackground() => Stack(
    children: [
      UIHelper.customImage(
        img: "bg.png",
        fit: BoxFit.cover, // Ensures the image fills the entire background
      ),

      Positioned(
        top: -100,
        left: -100,
        child: _circle(300, Colors.blue.shade100.withOpacity(0.1)),
      ),
      Positioned(
        top: 50,
        right: -50,
        child: _circle(200, Colors.purple.shade100.withOpacity(0.1)),
      ),



    ],
  );

  Widget _circle(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _buildCustomAppBar(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
    child: Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _circularButton(context),
            const Text('Earning Report',
                style:
                TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(width: 40),
          ],
        ),
      ],
    ),
  );

  Widget _circularButton(BuildContext context) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      shape: BoxShape.circle,
    ),
    child: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
  );

  Widget _buildDateSelector() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFD6E4FF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding:  EdgeInsets.only(left: 16, right: 4),
          child: Row(
            children: [
              // const Text(
              //   '3rd Sep - 9th Sep 2023',
              //   style: TextStyle(
              //     color: Color(0xFF3F51B5),
              //     fontWeight: FontWeight.w500,
              //     fontSize: 16,
              //   ),
              // ),
              UIHelper.boldText(text: '3rd Sep - 9th Sep 2023', fontSize: 16, color: AppColors.primary1),
              const Spacer(), // 👈 pushes icon to right
              GestureDetector(
                onTap: () {
                  // showModalBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true,
                  //   backgroundColor: Colors.transparent,
                  //   builder: (context) => const CustomDateBottomSheet(),
                  // );

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6), // You can adjust blur strength here
                        child: const CustomDateBottomSheet(),
                      );
                    },
                  );

                },
                child: Container(
                  height: 52, // Adjusted for visual balance
                  width: 52,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: UIHelper.customSvg(
                      svg: "date-calander.svg.svg",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildSegmentedControl() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: const Color(0xFFD6E4FF),
      borderRadius: BorderRadius.circular(21),
    ),
    child: Row(
      children: List.generate(2, (index) {
        final isSelected = _selectedTabIndex == index;
        final labels = ['By Courses', 'By Sessions'];
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 36,
               // padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Center(
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF3F51B5)
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800)),
    ),
  );

  Widget _buildBarChart() {
    final List<double> barHeights = [0.4, 0.6, 0.8, 0.5, 0.9, 1.0, 0.7];
    final List<String> barLabels = [
      '3rd',
      '4th',
      '5th',
      '6th',
      '7th',
      '8th',
      '9th'
    ];
    const double maxChartHeight = 200;

    return Container(
     // height: maxChartHeight + 50,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(barHeights.length, (index) {
          final isHighlighted = index == 5;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isHighlighted)
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '\$40',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              if (isHighlighted) const SizedBox(height: 5),
              Container(
                width: 30,
                height: barHeights[index] * maxChartHeight,
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? const Color(0xFF3F51B5)
                      : const Color(0xFF3F51B5).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                barLabels[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                  isHighlighted ? FontWeight.bold : FontWeight.normal,
                  color: isHighlighted
                      ? const Color(0xFF3F51B5)
                      : Colors.grey.shade700,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildEarningSummary() => Container(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFF0F2F5), width: 1)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        _earningColumn('Weekly Earning', '\$120'),
        Container(height: 15, width: 1, color: AppColors.primary1),
        _earningColumn('Total Earning', '\$1460'),
      ],
    ),
  );

  Widget _earningColumn(String label, String value) => Column(
    children: [
      Text(label,
          style: const TextStyle(fontSize: 16, color: Colors.grey)),
      const SizedBox(height: 5),
      Text(value,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2962FF))),
    ],
  );

}
