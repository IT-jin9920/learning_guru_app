import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/mentor/home_screen/search_page/search_screen.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../widgets/MonthSwitcherHeader.dart';
import '../../app_navigation/bottom_navigation_page.dart';
import '../../profile_screen/profile_page.dart';
import 'earning_report/EarningReportScreen.dart';
import 'notification_page/Notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  final List<String> items = [
    'Luke Tailor',
    'Waverley Roberts',
    'John Smith',
    'Emily Johnson',
    'Michael Brown',
    'Sarah Lee',
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setSystemUI();
  }

  void _setSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    ); // black icons
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setSystemUI(); // Called when returning back from another screen
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final bottomNavController = Get.find<BottomNavController>();

    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark, // ✅ white in dark mode, black in light mode
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light, // For iOS
      ),
      child: SafeArea(
        //top: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          //backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 1,
          ),
          body: SingleChildScrollView(
           // physics: BouncingScrollPhysics(),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SizedBox(height: 25),
                      GestureDetector(
                        onTap: () => bottomNavController.changeTab(4),
                        //onTap: ()=> Get.to(ProfilePage()),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UIHelper.boldText(
                                    text: 'Hey,',
                                    fontSize: 24,
                                    color: AppColors.textblue,
                                  ),
                                  Row(
                                    children: [
                                      UIHelper.boldText(
                                        text: 'David!',
                                        fontSize: 24,
                                        color: AppColors.text,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(width: AppConstants.spacingSmall),
                                      SizedBox(
                                        height: screenHeight * 0.05,
                                        // 6% of screen height
                                        width: screenWidth * 0.10,
                                        // 13% of screen width
                                        child: UIHelper.customImage(img: "hand-png.png"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  // 🔔 Notification
                                  Material(
                                    color: const Color(0xFFCDDCF4),
                                    shape: const CircleBorder(),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        Get.to(() => const NotificationsScreen());

                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => NotificationsScreen(),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        padding: const EdgeInsets.all(18),
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: UIHelper.customSvg(
                                            svg: "noti-icon-svg.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // 🔍 Search
                                  Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: Material(
                                        color: const Color(0xff03002F),
                                        shape: const CircleBorder(),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(100),
                                          onTap: () {

                                           Get.to(  const SearchScreen(),);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         const SearchScreen(),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            padding: const EdgeInsets.all(18),
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: UIHelper.customSvg(
                                                svg: "serch-icon-svg.svg",
                                              ),
                                            ),
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
                      ),
                      UIHelper.regularText(
                        text: 'Paediatrician, Mentor',
                        fontSize: 12,
                        color: AppColors.primary1,
                      ),
                      const SizedBox(height: AppConstants.spacingExtraLarge),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                bottomNavController.changeTab(4);
                              },
                              child: Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  color: AppColors.primary1,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 🔼 Header
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff6C93D4),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: UIHelper.boldText(
                                        text: 'Total Consulted',
                                        fontSize: 12,
                                        color: AppColors.black,
                                      ),
                                    ),

                                    // 🔽 Number aligned to bottom-left
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          // 🔽 Bottom-left aligned number
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                bottom: 10,
                                              ),
                                              child: UIHelper.boldText(
                                                text: '120',
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),

                                          // 🔼 Top-right aligned arrow icon
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                right: 8,
                                              ),
                                              child: UIHelper.customSvg(
                                                // or use Icon(Icons.arrow_forward)
                                                svg: 'top-right-svg-icon.svg',
                                                height: 18,
                                                width: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: AppConstants.spacingSmall),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                bottomNavController.changeTab(4);
                              },
                              child: Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  color: AppColors.primary2,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 🔼 Header
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff89E7B2),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: UIHelper.boldText(
                                        text: 'Total Courses',
                                        fontSize: 12,
                                        color: AppColors.black,
                                      ),
                                    ),

                                    // 🔽 Number aligned to bottom-left
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          // 🔽 Bottom-left aligned number
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                bottom: 10,
                                              ),
                                              child: UIHelper.boldText(
                                                text: '45',
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),

                                          // 🔼 Top-right aligned arrow icon
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                right: 8,
                                              ),
                                              child: UIHelper.customSvg(
                                                // or use Icon(Icons.arrow_forward)
                                                svg: 'top-right-svg-icon.svg',
                                                height: 18,
                                                width: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spacingExtraLarge),
                      GestureDetector(
                        onTap: () {
                          Get.to(EarningReportScreen(),);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EarningReportScreen(),
                          //   ),
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UIHelper.boldText(
                              text: 'Earning Report',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: UIHelper.customSvg(svg: "right-arrow-svg-icon.svg"),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppConstants.spacingLarge),

                      EarningReportSwitcher(),

                      const SizedBox(height: AppConstants.spacingMedium),
                      Container(
                        width: double.infinity, // Full screen width
                        height: 1, // Thin line
                        color: Color(0xFFCDDCF4), // Light blue divider
                      ),
                      const SizedBox(height: AppConstants.spacingMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              UIHelper.mediumText(
                                text: 'October Earning',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.text,
                              ),

                              SizedBox(height: AppConstants.spacingSmall / 2),

                              UIHelper.boldText(
                                text: '\$360',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textblue,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                            child: VerticalDivider(width: 0, color: AppColors.primary1),
                          ),
                          Column(
                            children: [
                              UIHelper.mediumText(
                                text: 'Total Earning',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.text,
                              ),

                              SizedBox(height: AppConstants.spacingSmall / 2),

                              UIHelper.boldText(
                                text: '\$1460',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textblue,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spacingMedium),
                      Container(
                        width: double.infinity, // Full screen width
                        height: 1, // Thin line
                        color: Color(0xFFCDDCF4), // Light blue divider
                      ),

                      //const SizedBox(height: AppConstants.spacingSmall),
                      Column(
                        children: [
                          Container(
                            height: 205,
                            alignment: Alignment.center,
                            child: _buildBarChart(context),
                          ),
                          SizedBox(height: AppConstants.spacingLarge),
                          Container(
                            width: double.infinity, // Full screen width
                            height: 1, // Thin line
                            color: Color(0xFFCDDCF4), // Light blue divider
                          ),
                        ],
                      ),
                      // const SizedBox(height: AppConstants.spacingExtraLarge),
                      SizedBox(height: 30),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            bottomNavController.changeTab(2);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UIHelper.boldText(
                                  text: 'Upcoming Session',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.text,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: UIHelper.customSvg(
                                    svg: "right-arrow-svg-icon.svg",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),

                // const SizedBox(height: AppConstants.spacingMedium),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 1),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       _buildUserCard(
                //         name: 'Luke Tailor',
                //         date: '11th Nov, 10:00 AM',
                //         imagePath: 'user-1.png', // You'll need to add this image
                //       ),
                //       const SizedBox(width: 8), // Spacer between cards
                //       _buildUserCard(
                //         name: 'Waverley Roberts',
                //         date: '12th Nov, 12:00 PM',
                //         imagePath: 'user-2.png', // You'll need to add this image
                //       ),
                //       const SizedBox(height: AppConstants.spacingExtraLarge * 2),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: AppConstants.spacingMedium),
                // // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       _buildUserCard(
                //         name: 'Luke Tailor',
                //         date: '11th Nov, 10:00 AM',
                //         imagePath: 'user-1.png', // You'll need to add this image
                //       ),
                //       const SizedBox(width: 8), // Spacer between cards
                //       _buildUserCard(
                //         name: 'Waverley Roberts',
                //         date: '12th Nov, 12:00 PM',
                //         imagePath: 'user-2.png', // You'll need to add this image
                //       ),
                //       const SizedBox(height: AppConstants.spacingExtraLarge * 2),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: AppConstants.spacingMedium),

                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: (items.length / 2).ceil(), // 2 per row
                  itemBuilder: (context, index) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final cardWidth = (screenWidth - 7 * 2 - 11) / 2;
                    // (screenWidth - horizontalPadding*2 - spacingBetweenCards) / 2

                    final firstIndex = index * 2;
                    final secondIndex = firstIndex + 1;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildUserCard(
                            name: items[firstIndex],
                            date: '11th Nov, 10:00 AM',
                            imagePath: 'user-1.png',
                            cardWidth: cardWidth,
                          ),
                          const SizedBox(width: 11),
                          if (secondIndex < items.length)
                            _buildUserCard(
                              name: items[secondIndex],
                              date: '12th Nov, 12:00 PM',
                              imagePath: 'user-2.png',
                              cardWidth: cardWidth,
                            )
                          else
                            SizedBox(width: cardWidth), // keep alignment
                        ],
                      ),
                    );
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard({
    required String name,
    required String date,
    required String imagePath,
    required double cardWidth,
  }) {
    return GestureDetector(
      onTap: () {
        final bottomNavController = Get.find<BottomNavController>();
        bottomNavController.changeTab(4);
        Get.back();
      },
      child: Container(
        height: 145,
        width: cardWidth,
        decoration: BoxDecoration(
          color: const Color(0xFFe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar + Chat button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: cardWidth * 0.36,
                  height: cardWidth * 0.36,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: imagePath),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final bottomNavController = Get.find<BottomNavController>();
                    bottomNavController.changeTab(1);
                    Get.back();
                  },
                  child: Container(
                    height: cardWidth * 0.25,
                    width: cardWidth * 0.36,
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
                  UIHelper.boldText(
                    text: name,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      UIHelper.mediumText(
                        text: date.split(',')[0] + ',',
                        fontSize: 12,
                        color: AppColors.textblue,
                      ),
                      const SizedBox(width: 4),
                      UIHelper.mediumText(
                        text: date.split(',')[1].trim(),
                        fontSize: 12,
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

  // Widget _buildUserCard({
  //   required String name,
  //   required String date,
  //   required String imagePath,
  // }) {
  //   return GestureDetector(
  //     onTap: () {
  //      // bottomNavController.changeTab(5); // Redirect to tab index 2
  //       bottomNavController.changeTab(4);
  //     },
  //     child: Container(
  //      // height: 131,
  //       width: 160,
  //       decoration: BoxDecoration(
  //         color: const Color(0xFFe6e8ed),
  //         borderRadius: BorderRadius.circular(32),
  //       ),
  //       padding: const EdgeInsets.all(5),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           /// Avatar and Price
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               // Avatar
  //               SizedBox(
  //                 width: 60,
  //                 height: 60,
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(32),
  //                   child: UIHelper.customImage(img: "$imagePath"),
  //                 ),
  //               ),
  //
  //               // Chat Tag
  //               GestureDetector(
  //                 onTap: () {
  //                   bottomNavController.changeTab(1); // Redirect to tab index 2
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(right: 6),
  //                   child: Container(
  //                     height: 40,
  //                     width: 60,
  //                     decoration: BoxDecoration(
  //                       color: AppColors.text,
  //                       borderRadius: BorderRadius.circular(21),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: UIHelper.customSvg(
  //                         svg: "chat-svg-icon.svg",
  //                         color: AppColors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //
  //           const SizedBox(height: 16),
  //
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 /// Name
  //                 UIHelper.boldText(
  //                   text: name,
  //                   fontSize: 14,
  //                   color: AppColors.text,
  //                 ),
  //
  //                 const SizedBox(height: 2),
  //
  //                 /// Rating
  //                 Row(
  //                   children: [
  //                     UIHelper.mediumText(
  //                       text: "11th Nov,",
  //                       fontSize: 12,
  //                       color: AppColors.textblue,
  //                     ),
  //                     const SizedBox(width: 2),
  //                     UIHelper.mediumText(
  //                       text: "10:00 AM",
  //                       fontSize: 12,
  //                       color: AppColors.textblue,
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildBarChart(BuildContext context) {
    final List<Map<String, dynamic>> chartData = [
      {'label': 'Week 1', 'value': 20.0, 'amount': '\$80'},
      {'label': 'Week 2', 'value': 50.0, 'amount': '\$120'},
      {'label': 'Week 3', 'value': 70.0, 'amount': '\$120'}, // Highlighted
      {'label': 'Week 4', 'value': 40.0, 'amount': '\$90'},
      {'label': 'Week 4', 'value': 40.0, 'amount': '\$90'},
    ];

    final double maxValue = chartData
        .map((e) => e['value'] as double)
        .reduce((a, b) => a > b ? a : b);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: chartData.map((data) {
              final isWeek3 = data['label'] == 'Week 3';
              final barHeight = (data['value'] / maxValue) * 120;

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Top green label with pointer (only Week 3)
                  if (isWeek3)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF3FDA8F),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data['amount'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary1,
                              width: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),

                  // Bar
                  Container(
                    width: 30,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: AppColors.primary1,
                      borderRadius: BorderRadius.circular(8),
                      // No image property at all
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Label
                  // Text(
                  //   data['label'],
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: isWeek3 ? FontWeight.bold : FontWeight.normal,
                  //     color: isWeek3 ? Colors.black : Colors.grey,
                  //   ),
                  // ),
                  UIHelper.mediumText(
                    text: data['label'],
                    fontSize: 12,
                    fontWeight: isWeek3 ? FontWeight.bold : FontWeight.normal,
                    color: isWeek3 ? AppColors.text : AppColors.grey,
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget buildNotificationIcon() {
    return Material(
      color: const Color(0xFFCDDCF4),
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {},
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(15),
          child: UIHelper.customSvg(svg: "noti-icon-svg.svg"),
        ),
      ),
    );
  }

  Widget buildSearchIcon() {
    return Material(
      color: const Color(0xff03002F),
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {},
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(15),
          child: UIHelper.customSvg(svg: "serch-icon-svg.svg"),
        ),
      ),
    );
  }
}
