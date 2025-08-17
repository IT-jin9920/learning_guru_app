
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors/app_color.dart';
import '../../../utils/ui_helper.dart';

class SessionDetailsPage extends StatefulWidget {
  const SessionDetailsPage({super.key});

  @override
  State<SessionDetailsPage> createState() => _SessionDetailsPageState();
}

class _SessionDetailsPageState extends State<SessionDetailsPage> {

  File? _imageFile;
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAF2FF),

      appBar: AppBar(

        surfaceTintColor: Color(0xffEAF2FF),
        //backgroundColor: Colors.transparent,
        backgroundColor: Color(0xffEAF2FF),
        elevation: 0,
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              // Get.back();
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

        // Align title to right using a Row
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns to the right
            children:  [
              UIHelper.boldText(
                text: 'Student Detail',
                fontSize: 18,
                color: AppColors.text,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),

        // centerTitle: true is removed or should be false
        centerTitle: false,
      ),
      // /// AppBar
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   elevation: 0,
      //   title: Align(
      //     alignment: Alignment.centerRight,
      //     child: UIHelper.boldText(
      //       text: 'Student Detail',
      //       fontSize: 18,
      //       color: AppColors.text,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: Container(
      //       height: 40,
      //       width: 40,
      //       decoration: const BoxDecoration(
      //         color: Color(0xFFCEDBF1),
      //         shape: BoxShape.circle,
      //       ),
      //       padding: const EdgeInsets.all(8),
      //       child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      //   toolbarHeight: 70,
      // ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    // Container(
                    //   padding: const EdgeInsets.only(top: 30, bottom: 10), // for safe area + spacing
                    //   color: AppColors.white,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       /// Back Button
                    //       GestureDetector(
                    //         onTap: () => Get.back(),
                    //         child: Container(
                    //           height: 40,
                    //           width: 40,
                    //           decoration: const BoxDecoration(
                    //             color: Color(0xFFCEDBF1),
                    //             shape: BoxShape.circle,
                    //           ),
                    //           padding: const EdgeInsets.all(8),
                    //           child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                    //         ),
                    //       ),
                    //
                    //       /// Title
                    //       UIHelper.boldText(
                    //         text: 'Student Detail',
                    //         fontSize: 18,
                    //         color: AppColors.text,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //
                    //       /// Right spacer or icon (optional)
                    //       //const SizedBox(width: 40), // keeps symmetry
                    //     ],
                    //   ),
                    // ),

                    /// Profile Picture with SVG border
                    // Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     SizedBox(
                    //       width: 150,
                    //       height: 150,
                    //       child: Stack(
                    //         alignment: Alignment.center,
                    //         children: [
                    //           UIHelper.customSvg(
                    //             svg: "clip-profile-round-svg-icon.svg",
                    //             width: 150,
                    //             height: 150,
                    //           ),
                    //
                    //           /// Profile Image
                    //           CircleAvatar(
                    //             radius: 60,
                    //             backgroundImage: _imageFile != null
                    //                 ? FileImage(_imageFile!)
                    //                 : const AssetImage("assets/images/user-1.png")
                    //             as ImageProvider,
                    //             backgroundColor: Colors.white,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Positioned(
                    //       right: 5,
                    //       bottom: 10,
                    //       child: Container(
                    //         padding: const EdgeInsets.all(6),
                    //         decoration: const BoxDecoration(
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: SizedBox(
                    //           height: 16,
                    //           width: 16,
                    //           child: UIHelper.customSvgOnTap(
                    //             svg: "edit-icon-svg.svg",
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    /// Profile Picture with Decorative Background and Action Icon
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background and Decorations
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background circular image
                              Positioned.fill(
                                child: FractionallySizedBox(
                                  widthFactor: 0.90, // 90% of the parent's width
                                  heightFactor: 0.90, // 90% of the parent's height
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: SizedBox(
                                      child: UIHelper.customSvg(
                                        svg: "img-bg.svg",
                                        fit: BoxFit.cover,
                                        color: const Color(0xffd2e0f6),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              // SVG circular border
                              UIHelper.customSvg(
                                svg: "clip-profile-round-svg-icon.svg",
                                width: 150,
                                height: 150,
                              ),

                              // Red top-left circle
                               Positioned(
                                top: 145,
                                left: 45,
                                child: CircleAvatar(
                                  child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: UIHelper.customImage(img: "icon-1.png")),
                                  radius: 35,
                                  backgroundColor: const Color(0xff9db8e7),
                                ),
                              ),





                              // White outer circle with inner profile image
                              CircleAvatar(
                                radius: 61,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: _imageFile != null
                                      ? FileImage(_imageFile!)
                                      : const AssetImage("assets/images/user-3.png") as ImageProvider,
                                ),
                              ),

                              // Yellow bottom-left circle
                              Positioned(
                                bottom: 110,
                                left: 58,
                                child: CircleAvatar(
                                  radius: 42, // Adjust radius to fit your layout
                                  backgroundColor: const Color(0xffcddcf4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10), // 👈 Inner padding for image spacing
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: UIHelper.customImage(img: "icon-2.png"),
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),


                      ],
                    ),

                    //const SizedBox(height: 60),


                    /// Name & Charges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIHelper.boldText(
                              text: "Alexandra \nSmith",
                              fontSize: 18,
                              color: AppColors.text,
                              fontWeight: FontWeight.bold,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF000042),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 16,
                                width: 16,
                                child: UIHelper.customSvgOnTap(
                                  svg: "bag-svg-icon.svg",
                                  onTap: () {},
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(color: AppColors.primary2,height: 10, width: 2,),
                              const SizedBox(width: 6),
                              UIHelper.boldText(
                                text: "5B, Roll No. 23",
                                fontSize: 12,
                                color: AppColors.white,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40,),
              /// Tabs
              Container(
                child: Row(
                  children: [
                    /// About Info Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = 0;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "About Info",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selectedTabIndex == 0
                                    ? AppColors.textblue
                                    : AppColors.grey,
                              ),
                              const SizedBox(height: 4),
                              Divider(
                                thickness: 2,
                                color: selectedTabIndex == 0
                                    ? Colors.blue
                                    : Colors.transparent,
                                indent: 32,
                                endIndent: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Academics Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = 1;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.mediumText(
                                text: "Academics",
                                fontSize: 14,
                                fontWeight:  selectedTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                                color: selectedTabIndex == 1
                                    ? AppColors.textblue
                                    : AppColors.grey,
                              ),
                              const SizedBox(height: 4),
                              Divider(
                                thickness: 2,
                                color: selectedTabIndex == 1
                                    ? Colors.blue
                                    : Colors.transparent,
                                indent: 32,
                                endIndent: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = 2;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "Rewards",

                                fontSize: 14,
                                fontWeight:  selectedTabIndex == 2 ? FontWeight.bold : FontWeight.normal,
                                color: selectedTabIndex == 2
                                    ? AppColors.textblue
                                    : AppColors.grey,
                              ),
                              const SizedBox(height: 4),
                              Divider(
                                thickness: 2,
                                color: selectedTabIndex == 2
                                    ? Colors.blue
                                    : Colors.transparent,
                                indent: 32,
                                endIndent: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Info Section Box
              // selectedTabIndex == 0
              //     ? Container(
              //   width: double.infinity,
              //   color: Colors.white,
              //   // decoration: BoxDecoration(
              //   //   color: Colors.white,
              //   //   borderRadius: BorderRadius.circular(24),
              //   // ),
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16,
              //     vertical: 20,
              //   ),
              //   child: Column(
              //     children: [
              //
              //       const SizedBox(height: 30),
              //
              //       _editSection(
              //         onEditTap: () {
              //         },
              //         title: "Personal Info",
              //         children: const [
              //           Padding(
              //             padding: EdgeInsets.only(top: 20, left: 15),
              //             child: _infoTile(
              //               svgPath: "phonenumber-icon-svg.svg",
              //               label: "+1 556 656 1343",
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(top: 20, left: 15),
              //             child: _infoTile(
              //               svgPath: "email-icon-svg.svg",
              //               label: "alexandrasmith@school.edu.com",
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(
              //               top: 20,
              //               left: 15,
              //               bottom: 20,
              //             ),
              //             child: _infoTile(
              //               svgPath: "rating-svg-icon.svg",
              //               label: "4.5 Rating",
              //             ),
              //           ),
              //         ],
              //       ),
              //
              //       const SizedBox(height: 30),
              //
              //
              //     ],
              //   ),
              // )
              //     :Container(),

              _buildTabContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _editSection({
    required String title,
    VoidCallback? onEditTap,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UIHelper.boldText(
              text: title,
              fontSize: 16,
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            // SizedBox(
            //   height: 16,
            //   width: 16,
            //   child: UIHelper.customSvgOnTap(
            //     svg: "edit-icon-svg.svg",
            //     onTap: onEditTap ?? () {},
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E8ED),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              _editSection(
                onEditTap: () {},
                title: "Personal Info",
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: _infoTile(
                      svgPath: "phonenumber-icon-svg.svg",
                      label: "+1 556 656 1343",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: _infoTile(
                      svgPath: "email-icon-svg.svg",
                      label: "alexandrasmith@school.edu.com",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: _infoTile(
                      svgPath: "schol-icon.svg",
                      label: "School Name",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UIHelper.boldText(
                        text: "Behavioural Track",
                        fontSize: 16,
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      // SizedBox(
                      //   height: 16,
                      //   width: 16,
                      //   child: UIHelper.customSvgOnTap(
                      //     svg: "edit-icon-svg.svg",
                      //     onTap: onEditTap ?? () {},
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 120,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFe5effd),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// Participation
                            Container(
                              height: 40,
                              //width: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xff9db8e7),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,

                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                                child: UIHelper.mediumText(
                                  text:  "Participation",
                                  fontSize: 12,
                                  color: AppColors.text,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12), // spacing between boxes

                            /// Leadership
                            Container(
                              height: 40,
                              //width: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xff9db8e7),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                                child: UIHelper.mediumText(
                                  text: "Leadership",
                                  fontSize: 12,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// Excessive Talking
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: const Color(0xffb5bbd0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                            child: UIHelper.mediumText(
                              text:  "Excessive Talking",
                              fontSize: 12,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),

            ],
          ),
        );

      case 1:
        return Container(
          height: 500,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: const Center(
            child: Text(
              "Education Info Tab",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        );

      case 2:
        return Container(
          height: 500,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: const Center(
            child: Text(
              "Certificates & Awards",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }



}

class _infoTile extends StatelessWidget {
  final String svgPath; // SVG icon asset path
  final String label;
  final VoidCallback? onTap;

  const _infoTile({required this.svgPath, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: UIHelper.customSvg(svg: svgPath),
            ),
            const SizedBox(width: 10),
            Container(height: 15, width: 2, color: AppColors.primary1),
            const SizedBox(width: 10),
            Expanded(
              child: UIHelper.mediumText(
                text: label,
                fontSize: 14,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

