// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:learning_guru_app/res/colors/app_color.dart';
// import 'package:learning_guru_app/utils/ui_helper.dart';
// import '../../../routes/app_routes.dart';
//
// class WalkthroughScreen extends StatefulWidget {
//   const WalkthroughScreen({super.key});
//
//   @override
//   State<WalkthroughScreen> createState() => _WalkthroughScreenState();
// }
//
// class _WalkthroughScreenState extends State<WalkthroughScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(() {
//       final page = _pageController.page?.round() ?? 0;
//       if (_currentPage != page) {
//         setState(() {
//           _currentPage = page;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // Top progress & skip area
//           Container(
//             padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
//             color: AppColors.primary1,
//             child: Row(
//               children: [
//                 // Page indicator bars
//                 Expanded(
//                   child: Row(
//                     children: List.generate(3, (index) {
//                       return Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                           child: AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             height: 4,
//                             decoration: BoxDecoration(
//                               color: index == _currentPage
//                                   ? AppColors.supportiveGlobal
//                                   : Colors.grey.shade300,
//                               borderRadius: BorderRadius.circular(2),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 // Skip or placeholder
//                 AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300),
//                   child: _currentPage < 2
//                       ? TextButton(
//                           key: const ValueKey('skip'),
//                           onPressed: () {
//                             Get.offNamed(RoutesName.userSelection);
//                            // Get.offNamed(RoutesName.navigation);
//                           },
//                           child: Container(
//                             width: 75,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: const Color(0xffCEDBF1),
//                               borderRadius: BorderRadius.circular(
//                                 30,
//                               ), // 🔁 Rounded corners
//                             ),
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   UIHelper.boldText(
//                                     text: 'Skip ',
//                                     fontSize: 12,
//                                     color: AppColors.text,
//                                   ),
//                                   UIHelper.customSvg(
//                                     svg: "right-arrow-svg.svg",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       : const SizedBox(
//                           key: ValueKey('empty'),
//                           // width: 70,
//                           height: 50,
//                         ),
//                 ),
//               ],
//             ),
//           ),
//
//           // PageView for walkthrough
//           Expanded(
//             // child: PageView(
//             //   controller: _pageController,
//             //   children: const [
//             //     WalkthroughPage(
//             //       imagePath: 'assets/images/walk1.png',
//             //       title: 'Dummy Title of the Future',
//             //       description:
//             //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
//             //     ),
//             //     WalkthroughPage(
//             //       imagePath: 'assets/images/walk2.png',
//             //       title: 'Dummy Title of the Future',
//             //       description:
//             //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
//             //       imagePadding: EdgeInsets.all(20),
//             //     ),
//             //     WalkthroughPage(
//             //       imagePath: 'assets/images/walk3.png',
//             //       title: 'Dummy Title of the Future',
//             //       description:
//             //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
//             //     ),
//             //   ],
//             // ),
//
//             child: PageView(
//               controller: _pageController,
//               children: List.generate(3, (index) {
//                 return GestureDetector(
//                   onTap: () {
//                     if (_currentPage < 2) {
//                       _pageController.nextPage(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     }
//                   },
//                   child: WalkthroughPage(
//                     imagePath: 'assets/images/walk${index + 1}.png',
//                     title: 'Dummy Title of the Future',
//                     description:
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
//                     imagePadding: index == 1 ? const EdgeInsets.all(20) : null,
//                   ),
//                 );
//               }),
//             ),
//
//           ),
//
//           // Get Started
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 300),
//               child: _currentPage == 2
//                   ? ElevatedButton(
//                       key: const ValueKey("get_started"),
//                       onPressed: () {
//                         Get.offNamed(RoutesName.navigation);
//                       //  Get.offNamed(RoutesName.userSelection);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primary1,
//                         minimumSize: const Size(double.infinity, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 3,
//                       ),
//                       child: const Text(
//                         'Get Started',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     )
//                   : const SizedBox(key: ValueKey("empty_space")),
//             ),
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }
//
// class WalkthroughPage extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String description;
//   final EdgeInsets? imagePadding; // optional
//
//   const WalkthroughPage({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.description,
//     this.imagePadding, // optional
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return ConstrainedBox(
//       constraints: BoxConstraints(minHeight: screenHeight * 0.95),
//       child: IntrinsicHeight(
//         child: Column(
//           children: [
//             // Image card section
//             SizedBox(
//               height: screenHeight * 0.60,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     height: screenHeight * 0.10,
//                     child: Container(color: AppColors.primary1),
//                   ),
//                   Positioned(
//                     top: 20,
//                     child: Container(
//                       width: screenWidth * 0.9,
//                       height: screenHeight * 0.60,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [Color(0xffCEDBF1), Colors.white],
//                         ),
//                         border: Border.all(color: Colors.white, width: 6),
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.15),
//                             blurRadius: 10,
//                             spreadRadius: 4,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Padding(
//                           padding: imagePadding ?? const EdgeInsets.all(2.0),
//                           child: Image.asset(imagePath, fit: BoxFit.contain),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 50),
//
//             // Text section
//             Column(
//               children: [
//                 UIHelper.boldTextCenter(
//                   text: title,
//                   fontSize: 18,
//                   color: AppColors.text,
//                 ),
//                 const SizedBox(height: 10),
//                 UIHelper.regularTextCenter(
//                   text: description,
//                   fontSize: 14,
//                   color: AppColors.grey,
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';
import '../bank_details_page/bank_details_page.dart';
import '../setup_your_profile/setup_profile_page.dart';
import '../verify_documents_page.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _previousPage = 0;
  bool readyToProceed = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;


    // onWillPop: () async {
    //   // If it's the first page, prevent back or exit app
    //   if (_currentPage == 0) {
    //     // Show confirmation dialog or just prevent
    //     // You can show dialog here if you want
    //     return true; // block back
    //   } else {
    //     // Go to previous walkthrough page
    //     _pageController.previousPage(
    //       duration: const Duration(milliseconds: 300),
    //       curve: Curves.easeInOut,
    //     );
    //     return false; // prevent default back
    //   }
    // },

    return WillPopScope(
      onWillPop: () async {
        if (_currentPage == 0) {
          bool shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Are you sure you want to exit the app?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Don't exit
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // Exit
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
          return shouldExit; // true = exit app, false = stay
        } else {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return false; // Don't exit, just go to previous page
        }
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarIconBrightness: !isDark ? Brightness.light : Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                ),
              child: Column(
                children: [
                  // ✅ Your top walkthrough indicator bar
                  Container(
                    padding: const EdgeInsets.only( left: 16,right: 16, top: 40),
                    color: AppColors.primary1,
                    child:SafeArea(
                      top: false,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary1,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.05),
                          //     offset: const Offset(0, -2),
                          //     blurRadius: 8,
                          //   ),
                          // ],
                        ),
                        child: SizedBox(
                          height: 40,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              /// ✅ Full-width wrapper on last page
                              // AnimatedPositioned(
                              //   duration: const Duration(milliseconds: 300),
                              //   left: _currentPage == 2 ? 0 : 10,
                              //   right: _currentPage == 2 ? 0 : null,
                              //   child: Container(
                              //     width: _currentPage == 2
                              //         ? MediaQuery.of(context).size.width
                              //         : 120,
                              //     alignment: Alignment.center,
                              //     child: SmoothPageIndicator(
                              //       controller: _pageController,
                              //       count: 3,
                              //       effect: ExpandingDotsEffect(
                              //         expansionFactor: 3.5,
                              //         dotHeight: 8,
                              //         dotWidth: 30 ,
                              //         // dotWidth: _currentPage == 2
                              //         //     ? MediaQuery.of(context).size.width / 6.5
                              //         //     : 30.0,
                              //
                              //         spacing: 6,
                              //         radius: 12,
                              //         dotColor: const Color(0xff4071C9),
                              //         activeDotColor: Colors.green,
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 120,
                                child: Container(
                                  width: _currentPage == 2
                                          ? MediaQuery.of(context).size.width
                                          : 120,
                                  alignment: Alignment.center,
                                 // width: MediaQuery.of(context).size.width,
                                  child: SmoothPageIndicator(
                                    controller: _pageController,
                                    count: 3,
                                    effect: ExpandingDotsEffect(
                                      expansionFactor: 3.5,
                                      dotHeight: 8,
                                      dotWidth: 30,
                                      spacing: 6,
                                      radius: 12,
                                      dotColor: const Color(0xff4071C9),
                                      activeDotColor: Colors.green,
                                    ),
                                  ),
                                ),
                              ),


                              /// ✅ Skip Button (only if not on last page)
                              //if (_currentPage < 2)
                                Positioned(
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                     // Get.offNamed(RoutesName.userSelection);
                                      _proceed(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffCEDBF1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          UIHelper.boldText(
                                            text: 'Skip',
                                            fontSize: 13,
                                            color: AppColors.text,
                                          ),
                                          const SizedBox(width: 4),
                                          UIHelper.customSvg(
                                            svg: "right-arrow-svg.svg",
                                            width: 14,
                                            height: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),


                  ),


                  // ✅ PageView
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Stack(
                      children: [
                        PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });

                            // ✅ Only redirect if swiped forward to last page
                            if (_previousPage < index && index == 2) {
                              print("Swiped to last page ($index)");
                              readyToProceed = true; // ✅ enable redirect on next tap

                            } else {
                              readyToProceed = false; // reset if user comes back
                            }

                            _previousPage = index.toDouble(); // update previous
                          },
                          children: List.generate(3, (index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTapUp: (details) {
                                final screenWidth = MediaQuery.of(context).size.width;
                                final tapPosition = details.localPosition.dx;

                                if (tapPosition < screenWidth / 2) {
                                  if (_currentPage > 0) {
                                    _pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                } else {
                                  if (_currentPage < 2) {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,

                                    );

                                  } else {
                                   // _proceed(context);

                                    if (readyToProceed) {
                                      print(" tap on last page");
                                      _proceed(context);
                                    } else {
                                      print("Tap detected, but waiting for swipe to finish.");
                                    }

                                  }
                                }
                              },
                              child: AbsorbPointer(
                                absorbing: false,
                                child: WalkthroughPage(
                                  imagePath: 'assets/images/walk${index + 1}.png',
                                  title: 'Dummy Title of the Future',
                                  description:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                                  imagePadding: index == 1 ? const EdgeInsets.all(20) : null,
                                ),
                              ),
                            );
                          }),
                        ),

                        // Bottom SVG Overlay Positioned
                        // Positioned(
                        //   top: 100,
                        //   bottom: 0,
                        //   left: 0,
                        //   right: 0,
                        //   child: IgnorePointer( // Overlay should not block touch
                        //     child: SvgPicture.asset(
                        //       'assets/svg/Rectangle 6325.svg',
                        //       fit: BoxFit.cover,
                        //       width: double.infinity,
                        //       // You can adjust height as needed
                        //       height: 100,
                        //       //color: Colors.yellow,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),



                  // ✅ Get Started Button - Safe Padding
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(
                  //     16,
                  //     0,
                  //     16,
                  //     MediaQuery.of(context).padding.bottom + 5,
                  //    // MediaQuery.of(context).padding.bottom + 10,
                  //   ),
                  //   child: AnimatedSwitcher(
                  //     duration: const Duration(milliseconds: 300),
                  //     child: _currentPage == 2
                  //         ? ElevatedButton(
                  //       key: const ValueKey("get_started"),
                  //       onPressed: () {
                  //       //  Get.offNamed(RoutesName.userSelection);
                  //         Get.offNamed(RoutesName.navigation);
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: AppColors.primary1,
                  //         minimumSize: const Size(double.infinity, 50),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         elevation: 3,
                  //       ),
                  //       child: const Text(
                  //         'Get Started',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     )
                  //         : const SizedBox(key: ValueKey("empty_space")),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
                ),
        ),),
    );
  }

}

void _proceed(BuildContext context) async {
  await StorageService.init();

  final role = await StorageService.getUserRole();
  final isRegistered = StorageService.isRegistered();
  final isLoggedIn = StorageService.isLoggedIn();
  final profileDone = StorageService.isProfileCompleted();
  final bankDone = StorageService.isBankDetailsUpdated();
  final docDone = StorageService.isDocumentsUploaded();

  if (role == null) {
    Get.offNamed(RoutesName.userSelection);
    return;
  }

  if (!isRegistered) {
    Get.offNamed(RoutesName.register);
    return;
  }

  if (!isLoggedIn) {
    Get.offNamed(RoutesName.login);
    return;
  }

  if (!profileDone) {
    Get.offNamed(RoutesName.setupProfileImg);
    return;
  }

  if (!bankDone) {
    Get.offNamed(RoutesName.bankDetails);
    return;
  }

  if (!docDone) {
    Get.offNamed(RoutesName.verifyDocuments);
    return;
  }

  // ✅ All Done
  Get.offNamed(RoutesName.navigation);
}

class WalkthroughPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final EdgeInsets? imagePadding; // optional

  const WalkthroughPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.imagePadding, // optional
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: screenHeight * 0.95),
      child: IntrinsicHeight(
        child: Column(
          children: [
            // Image card section
            Container(
              child: SizedBox(
                //height: screenHeight * 0.60,
                height: 500,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: screenHeight * 0.10,
                      child: Container(color: AppColors.primary1),
                    ),
                    Positioned(
                      top: 20,
                      child: Container(
                        width: screenWidth * 0.9,
                        //height: screenHeight * 0.60,
                         height: 480,
                        // width: 327,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffCEDBF1), Colors.white],
                          //  colors: [Colors.red,Colors.red]
                          ),
                          border: Border.all(color: Colors.white, width: 6),
                          borderRadius: BorderRadius.circular(30),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.15),
                          //     blurRadius: 10,
                          //     spreadRadius: 4,
                          //     offset: const Offset(0, 4),
                          //   ),
                          // ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: imagePadding ?? const EdgeInsets.all(2.0),
                            child: Image.asset(imagePath, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Text section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  UIHelper.boldTextCenter(
                    text: title,
                    fontSize: 18,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 10),
                  UIHelper.regularTextCenter(
                    text: description,
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// void _proceed(BuildContext context) {
//
//   Get.offNamed(RoutesName.login);
//
//   // final isLoggedIn = StorageService.isLoggedIn();
//   // if (isLoggedIn) {
//   //   Get.offNamed(RoutesName.navigation);
//   // } else {
//   //   Get.offNamed(RoutesName.login);
//   // }
// }
