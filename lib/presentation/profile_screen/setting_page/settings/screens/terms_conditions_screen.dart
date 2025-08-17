import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeaf2ff),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              Get.back();
              // Navigator.pop(context);
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

        // Align title to right using a Row
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns to the right
            children: const [
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:AppColors.text,
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

          // Decorative circles
          Positioned(
            top: -100,
            left: -100,
            child: Opacity(
              opacity: 0.08,
              child: _circle(300, Colors.blue.shade100),
            ),
          ),
          Positioned(
            top: 80,
            right: -50,
            child: Opacity(
              opacity: 0.08,
              child: _circle(200, Colors.purple.shade100),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      24,
                      32,
                      24,
                      MediaQuery.of(context).padding.bottom + 24,
                    ),
                    child: UIHelper.mediumText(
                      text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                          "when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
                          "It has survived not only five centuries, but also the leap into electronic typesetting, "
                          "It has survived not only five centuries, but also the leap into electronic typesetting, "
                          "It has survived not only five centuries, but also the leap into electronic typesetting, "
                          "It has survived not only five centuries, but also the leap into electronic typesetting, "
                          "It has survived not only five centuries, but also the leap into electronic typesetting, "
                          "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets "
                          "containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker "
                          "including versions of Lorem Ipsum.\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. "
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. "
                          "It has survived not only five centuries, but also the leap into electronic typesetting.",
                      fontSize: 16,
                      color:Color(0xff686783),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeBackground() => Stack(
    children: [
      UIHelper.customImage(img: "bg.png", fit: BoxFit.cover),
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

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

}
