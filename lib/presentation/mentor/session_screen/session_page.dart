import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';

import '../../../utils/ui_helper.dart';

import '../../app_navigation/bottom_navigation_page.dart';
import 'session_details_page.dart';


class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;


    // return Scaffold(
    //   backgroundColor: const Color(0xFFeaf2ff),
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     toolbarHeight: 145,
    //     centerTitle: false,
    //   ),
    //   body: Stack(
    //     children: [
    //
    //
    //       _buildDecorativeBackground(),
    //
    //       Positioned(
    //         top: MediaQuery.of(context).padding.top + 5,
    //         left: 20,
    //         right: 20,
    //         child: Column(
    //           children: [
    //             /// Title Section
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Row(
    //                   children: [
    //                     /// Profile Image
    //                     UIHelper.customImage(
    //                         img: "session-top-img.png",
    //                       height: 40,
    //                     ),
    //
    //                     /// Overlapping Text
    //                     Transform.translate(
    //                       offset: const Offset(-8, 0),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(top: 5),
    //                         child: UIHelper.boldText(
    //                           text: 'My Class Sessions',
    //                           fontSize: 24,
    //                           color: AppColors.text,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //
    //               ],
    //             ),
    //
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: UIHelper.boldText(
    //                 text: "Manage your Meets",
    //                 fontSize: 16,
    //                 color: Color(0xff96b4e5),
    //                 fontWeight: FontWeight.w900,
    //               ),
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //
    //
    //
    //
    //
    //       // Decorative circles
    //       // Positioned(
    //       //   top: -100,
    //       //   left: -100,
    //       //   child: Opacity(
    //       //     opacity: 0.08,
    //       //     child: _circle(300, Colors.blue.shade100),
    //       //   ),
    //       // ),
    //       // Positioned(
    //       //   top: 80,
    //       //   right: -50,
    //       //   child: Opacity(
    //       //     opacity: 0.08,
    //       //     child: _circle(200, Colors.purple.shade100),
    //       //   ),
    //       // ),
    //
    //       TabbedContent(),
    //
    //       Positioned(
    //         top: MediaQuery.of(context).padding.top + 80,
    //         left: 20,
    //         right: 20,
    //         child: Container(
    //           height: 48,
    //           padding: const EdgeInsets.symmetric(horizontal: 16),
    //           decoration: BoxDecoration(
    //             color: const Color(0xFFCDDCF4),
    //             borderRadius: BorderRadius.circular(46),
    //           ),
    //           child: Row(
    //             children: [
    //               SizedBox(
    //                 height: 20,
    //                 width: 20,
    //                 child: Center(
    //                   child: SizedBox(
    //                     height: 16,
    //                     width: 16,
    //                     child: UIHelper.customSvg(
    //                       svg: "serch-icon-svg.svg",
    //                       color: AppColors.primary1,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(width: 10),
    //               // Set a manual width or use Flexible width
    //               SizedBox(
    //                 width: 220, // Adjust this value based on your layout
    //                 child: TextField(
    //                   // controller: _searchController,
    //                   style: const TextStyle(
    //                     fontFamily: 'BeVietnamPro',
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 14,
    //                   ),
    //                   decoration: const InputDecoration(
    //                     isCollapsed: true,
    //                     contentPadding: EdgeInsets.symmetric(vertical: 14),
    //                     hintText: "Search for Session",
    //                     border: InputBorder.none,
    //                     hintStyle: TextStyle(
    //                       fontFamily: 'BeVietnamPro',
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 12,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //
    //     ],
    //   ),
    // );
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xffEAF2FF),
        body: Stack(
          children: [
            /// 🎨 Background Layer
            Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

            /// 📦 Foreground Content
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔲 Padded Section (Top content)
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                UIHelper.customImage(
                                  img: "session-top-img.png",
                                  height: 40,
                                ),
                                Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: UIHelper.boldText(
                                      text: 'My Class Sessions',
                                      fontSize: 24,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        /// Subtitle
                        UIHelper.boldText(
                          text: "Manage your Meets",
                          fontSize: 16,
                          color: const Color(0xff96b4e5),
                          fontWeight: FontWeight.w900,
                        ),

                        const SizedBox(height: 24),

                        /// Search Field
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCDDCF4),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  // decoration: const BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  //   color: Color(0xFF03002F),
                                  // ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: UIHelper.customSvg(
                                        svg: "serch-icon-svg.svg",
                                        color: AppColors.textblue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    hintText: "Search for Session",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xff7c84a5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 🔳 Non-Padded Area
                  Expanded(child: TabbedContent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: Color(0xffEAF2FF),
    //     body: Stack(
    //       children: [
    //         /// 🎨 Background Layer
    //         Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),
    //
    //         /// 📦 Foreground Content
    //         SafeArea(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               /// 🔲 Padded Section (Top content)
    //               Padding(
    //                 padding: EdgeInsets.only(left: 16, right: 16, top: 20),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     /// Title Section
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             UIHelper.customImage(
    //                               img: "session-top-img.png",
    //                               height: 40,
    //                             ),
    //                             Transform.translate(
    //                               offset: const Offset(-8, 0),
    //                               child: Padding(
    //                                 padding: const EdgeInsets.only(top: 5),
    //                                 child: UIHelper.boldText(
    //                                   text: 'My Class Sessions',
    //                                   fontSize: 24,
    //                                   color: AppColors.text,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //
    //                     const SizedBox(height: 4),
    //
    //                     /// Subtitle
    //                     UIHelper.boldText(
    //                       text: "Manage your Meets",
    //                       fontSize: 16,
    //                       color: const Color(0xff96b4e5),
    //                       fontWeight: FontWeight.w900,
    //                     ),
    //
    //                     const SizedBox(height: 24),
    //
    //                     /// Search Field
    //                     Container(
    //                       height: 50,
    //                       decoration: BoxDecoration(
    //                         color: const Color(0xFFCDDCF4),
    //                         borderRadius: BorderRadius.circular(30),
    //                       ),
    //                       child: Row(
    //                         children: [
    //                           Padding(
    //                             padding: const EdgeInsets.all(3.0),
    //                             child: Container(
    //                               height: 40,
    //                               width: 40,
    //                               // decoration: const BoxDecoration(
    //                               //   shape: BoxShape.circle,
    //                               //   color: Color(0xFF03002F),
    //                               // ),
    //                               child: Center(
    //                                 child: SizedBox(
    //                                   height: 16,
    //                                   width: 16,
    //                                   child: UIHelper.customSvg(
    //                                     svg: "serch-icon-svg.svg",
    //                                     color: AppColors.textblue,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(width: 6),
    //                           const Expanded(
    //                             child: TextField(
    //                               style: TextStyle(
    //                                 fontFamily: 'BeVietnamPro',
    //                                 fontWeight: FontWeight.w500,
    //                                 fontSize: 12,
    //                               ),
    //                               decoration: InputDecoration(
    //                                 contentPadding: EdgeInsets.symmetric(
    //                                   vertical: 12,
    //                                 ),
    //                                 hintText: "Search for Session",
    //                                 border: InputBorder.none,
    //                                 hintStyle: TextStyle(
    //                                   fontFamily: 'BeVietnamPro',
    //                                   fontWeight: FontWeight.w500,
    //                                   fontSize: 12,
    //                                   color: Color(0xff7c84a5),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //
    //               const SizedBox(height: 24),
    //
    //               /// 🔳 Non-Padded Area
    //               Expanded(child: TabbedContent()),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buildDecorativeBackground() => Stack(
    children: [
      // UIHelper.customSvg(svg: "bg.svg"),
      UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover),
    ],
  );
}

class TabbedContent extends StatefulWidget {
  @override
  _TabbedContentState createState() => _TabbedContentState();
}

class _TabbedContentState extends State<TabbedContent> {
  final List<String> tabs = ['Ongoing', 'Upcoming', 'Past'];
  final List<GlobalKey> tabKeys = [];
  final GlobalKey _tabsRowKey = GlobalKey();

  final BottomNavController bottomNavController =
  Get.find<BottomNavController>();

  int selectedTabIndex = 0;
  double underlineLeft = 0;
  double underlineWidth = 0;

  @override
  void initState() {
    super.initState();
    tabKeys.addAll(List.generate(tabs.length, (_) => GlobalKey()));
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateUnderline());
  }

  void _updateUnderline() {
    final RenderBox? tabsRowBox =
        _tabsRowKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? tabBox =
        tabKeys[selectedTabIndex].currentContext?.findRenderObject()
            as RenderBox?;
    if (tabsRowBox != null && tabBox != null) {
      final tabsRowPos = tabsRowBox.localToGlobal(Offset.zero);
      final tabPos = tabBox.localToGlobal(Offset.zero);
      final left = tabPos.dx - tabsRowPos.dx;
      setState(() {
        underlineLeft = left;
        underlineWidth = tabBox.size.width;
      });
    }
  }

  Widget _buildTabContentWrapper(BuildContext context) {
    // Placeholder for tab content
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.grey.shade50,
      //   borderRadius: BorderRadius.circular(12),
      // ),
      child: SizedBox(
        // Give a sensible height to prevent overflow
        height: MediaQuery.of(context).size.height * 0.65,
        child: _buildTabContent(), // Your original switch-tab content
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                   color: Colors.white,
                   // color: Colors.red,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    10,
                    16,
                    10,
                    MediaQuery.of(context).padding.bottom + 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tabs Row + Animated Underline
                      Column(
                        children: [
                          // Stack for Tabs + Underline
                          SizedBox(
                            height: 40, // Adjust height based on design
                            child: Stack(
                              key: _tabsRowKey,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(tabs.length * 2 - 1, (
                                    i,
                                  ) {
                                    if (i % 2 == 0) {
                                      int tabIndex = i ~/ 2;
                                      bool isSelected =
                                          selectedTabIndex == tabIndex;

                                      return Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            setState(() {
                                              selectedTabIndex = tabIndex;
                                            });
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                  (_) => _updateUnderline(),
                                                );
                                          },
                                          child: Container(
                                            key: tabKeys[tabIndex],
                                            padding: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            alignment: Alignment.center,

                                            // child: Text(
                                            //   tabs[tabIndex],
                                            //   style: TextStyle(
                                            //     fontWeight: isSelected
                                            //         ? FontWeight.bold
                                            //         : FontWeight.w500,
                                            //     fontSize: 12,
                                            //     color: isSelected
                                            //         ? AppColors.text
                                            //         : AppColors.grey,
                                            //     fontFamily: 'BeVietnamPro',
                                            //   ),
                                            // ),
                                            child: UIHelper.mediumText(
                                              text: tabs[tabIndex],
                                              fontSize: 12,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              color: isSelected
                                                  ? AppColors.text
                                                  : AppColors.grey,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 2,
                                        height: 10,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary1,
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                ),

                                // ✅ Animated underline at bottom
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  bottom: 0,
                                  left: underlineLeft,
                                  child: Container(
                                    height: 3,
                                    width: underlineWidth,
                                    //color: Color(0xff3AD77E),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff3AD77E),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ✅ Divider below tabs
                          const Divider(height: 1, color: Color(0xffCDDCF4)),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Expanded(child: _buildTabContentWrapper(context)),
                      // Will expand inside IntrinsicHeight
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabContent() {
    if (selectedTabIndex == 0) {
      return ListView(
        padding: const EdgeInsets.symmetric( vertical: 20),
        physics: const BouncingScrollPhysics(),
        children: List.generate(5, (_) => _EndSessionCard()),
      );
    } else if (selectedTabIndex == 1) {
      return ListView(
        padding: const EdgeInsets.symmetric( vertical: 20),
        physics: const BouncingScrollPhysics(),
        children: List.generate(5, (_) => _StartSessionCard()),
      );
    } else {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                const SizedBox(width: 11), // Spacer between cards
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                const SizedBox(width: 11), // Spacer between cards
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                const SizedBox(width: 11), // Spacer between cards
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                const SizedBox(width: 11), // Spacer between cards
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                const SizedBox(width: 11), // Spacer between cards
                _buildUserCard(
                  name: 'Luke Tailor',
                  subject: 'Maths',
                  imagePath: 'user-1.png',
                  price: '10',
                  rating: 4.8,
                ),

                // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildUserCard({
    required String name,
    required String subject,
    required String imagePath,
    required String price,
    required double rating,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SessionDetailsPage());
      },
      child: Container(
        height: 131,
        width: 158,
        decoration: BoxDecoration(
          color: const Color(0xFFe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: "$imagePath"),
                  ),
                ),

                // Chat Tag
                InkWell(
                  onTap: (){
                    bottomNavController.changeTab(1);
                  },
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.text,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UIHelper.customSvg(
                        svg: "chat-svg-icon.svg",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  UIHelper.boldText(
                    text: name,
                    fontSize: 14,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                  ),

                  const SizedBox(height: 2),

                  /// Rating
                  Row(
                    children: [
                      UIHelper.boldText(
                        text: "11th Nov,",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textblue,
                      ),
                      const SizedBox(width: 4),
                      UIHelper.boldText(
                        text: "10:00 AM",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textblue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseCard({
    required String image,
    required String category,
    required String title,
    required String author,
    required double rating,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // spacing between cards
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.asset(
              image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Category + Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.blue, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                /// Author
                Text(
                  'by: $author',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _EndSessionCard() {
    return GestureDetector(
      onTap: () {
        Get.to(() => SessionDetailsPage());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row with Avatar & Chat Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: UIHelper.customImage(img: "user-1.png"),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.boldText(
                          text: "Luke Tailor",
                          fontSize: 14,
                          color: AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            UIHelper.customSvg(svg: "calander-svg-icon.svg"),
                            SizedBox(width: 2),
                            UIHelper.boldText(
                              text: "29th Jan, 10:00 AM",
                              fontSize: 10,
                              color: AppColors.textblue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){
                    bottomNavController.changeTab(1);
                  },
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.text,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UIHelper.customSvg(
                        svg: "chat-svg-icon.svg",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            GestureDetector(
              onTap: () {
                // handle end session
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary1,
                  borderRadius: BorderRadius.circular(48),
                ),
                alignment: Alignment.center,
                child: UIHelper.boldText(
                  text: 'End Session',
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _StartSessionCard() {
    return GestureDetector(
      onTap: () {
        Get.to(() => SessionDetailsPage());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row with Avatar & Chat Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: UIHelper.customImage(img: "user-1.png"),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.boldText(
                          text: "Luke Tailor",
                          fontSize: 14,
                          color: AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            UIHelper.customSvg(svg: "calander-svg-icon.svg"),
                            SizedBox(width: 2),
                            UIHelper.boldText(
                              text: "29th Jan, 10:00 AM",
                              fontSize: 10,
                              color: AppColors.textblue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    bottomNavController.changeTab(1);
                  },
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.text,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UIHelper.customSvg(
                        svg: "chat-svg-icon.svg",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            GestureDetector(
              onTap: () {
                // handle end session
               // bottomNavController.changeTab(1);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary1,
                  borderRadius: BorderRadius.circular(48),
                ),
                alignment: Alignment.center,
                // child: const Text(
                //   'Start Session',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                child: UIHelper.boldText(
                  text: 'Start Session',
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
