import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import '../../../../utils/ui_helper.dart';
import '../../../../widgets/custom_noti_app.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  List<Map<String, String>> notifications = [
    {
      'svg': 'notification-svg-icons.svg',
      'title': 'Matthew Inglis',
      'description': 'has made an announcement',
      'time': 'Today, 10:23 AM',
    },
    {
      'svg': 'book-notification-svg-icon.svg',
      'title': 'New Homework',
      'description': 'added for 16th Oct',
      'time': 'Today, 10:23 AM',
    },
    {
      'svg': 'chat-notifictaion-svg-icon.svg',
      'title': 'Theresia Lawson',
      'description': 'posted an answer in Forum One',
      'time': 'Today, 10:23 AM',
    },
    {
      'svg': 'not-notifctaion-svg--icon.svg',
      'title': 'New Exam Schedule',
      'description': 'has been added',
      'time': 'Today, 10:23 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFeaf2ff),
         // extendBodyBehindAppBar: true,
         //  appBar: AppBar(
         //   //backgroundColor: Colors.transparent,
         //    elevation: 0,
         //    toolbarHeight: 70,
         //    leading: Padding(
         //      padding: const EdgeInsets.only(left: 16),
         //      child: GestureDetector(
         //        onTap: () {
         //          // Get.back();
         //          Navigator.pop(context);
         //        },
         //        child: Container(
         //          height: 40,
         //          width: 40,
         //          decoration: const BoxDecoration(
         //            color: Color(0xFFCEDBF1),
         //            shape: BoxShape.circle,
         //          ),
         //          padding: const EdgeInsets.all(8),
         //          child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
         //        ),
         //      ),
         //    ),
         //
         //    // 👇 Align title to right using a Row
         //    title: Padding(
         //      padding: const EdgeInsets.only(right: 16),
         //      child: Row(
         //        mainAxisAlignment: MainAxisAlignment.end, // Aligns to the right
         //        children: const [
         //          Text(
         //            'Notifications',
         //            style: TextStyle(
         //              fontSize: 20,
         //              fontWeight: FontWeight.bold,
         //              color: Colors.black,
         //            ),
         //          ),
         //        ],
         //      ),
         //    ),
         //
         //    // centerTitle: true is removed or should be false
         //    centerTitle: false,
         //  ),

          body: Stack(
            children: [
              // _buildDecorativeBackground(),
              // Positioned(
              //   top: -100,
              //   left: -100,
              //   child: Opacity(
              //     opacity: 0.08,
              //     child: _circle(300, Colors.blue.shade100),
              //   ),
              // ),
              // Positioned(
              //   top: 80,
              //   right: -50,
              //   child: Opacity(
              //     opacity: 0.08,
              //     child: _circle(200, Colors.purple.shade100),
              //   ),
              // ),
              // SafeArea(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: const BorderRadius.only(
              //         topLeft: Radius.circular(40),
              //         topRight: Radius.circular(40),
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         Expanded(
              //           child: ListView(
              //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              //             children: notifications.map((notif) {
              //               return Column(
              //                 children: [
              //                   NotificationCard(
              //                     svg: notif['svg']!,
              //                     title: notif['title']!,
              //                     description: notif['description']!,
              //                     time: notif['time']!,
              //                   ),
              //                   const SizedBox(height: 12),
              //                 ],
              //               );
              //             }).toList(),
              //           ),
              //         ),
              //
              //         if (notifications.isNotEmpty)
              //           Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 16),
              //             child: _buildClearAllButton(),
              //           ),
              //        // Padding(
              //        //    padding: const EdgeInsets.symmetric(vertical: 16),
              //        //    child: _buildClearAllButton(),
              //        //  ),
              //       ],
              //     ),
              //   ),
              // ),

              /// 🎨 Background Layer
              Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          'Notifications',
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
                ),
              ),

              /// 📃 Content Area
              Positioned(
                top: MediaQuery.of(context).padding.top + 70,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notif = notifications[index];
                            return Column(
                              children: [
                                NotificationCard(
                                  svg: notif['svg']!,
                                  title: notif['title']!,
                                  description: notif['description']!,
                                  time: notif['time']!,
                                ),
                                const SizedBox(height: 12),
                              ],
                            );
                          },
                        ),
                      ),

                      if (notifications.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: _buildClearAllButton(),
                        ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }



  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildClearAllButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          notifications.clear();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: UIHelper.customSvg(svg: "clen-icon-svg.svg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 12),
              child: UIHelper.boldText(
                text: 'Clear All',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeBackground() => Stack(
    children: [
      // UIHelper.customSvg(svg: "bg.svg"),
      UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover),
    ],
  );
}

class NotificationCard extends StatelessWidget {
  final String svg;
  final String title;
  final String description;
  final String time;

  const NotificationCard({
    super.key,
    required this.svg,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFCDDCF4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: UIHelper.customSvg(svg: svg),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only( right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Prevent unnecessary height
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff54587e)
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5a86d0),
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
}
