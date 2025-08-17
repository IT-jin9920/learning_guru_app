import 'package:flutter/material.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import 'package:flutter/material.dart';

class ReviewRatingsPage extends StatelessWidget {
  const ReviewRatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🎨 Decorative background
          Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

          /// 🔙 Back + Title Bar
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
                      'Review & Ratings',
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

          /// ⭐ Ratings Summary
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Overall Rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIHelper.boldText(
                        text: "4.8",
                        fontSize: 32,
                        color: AppColors.text,
                      ),

                      Row(
                        children: List.generate(
                          5,
                          (index) => UIHelper.customSvg(
                            svg: "start-svg-icon.svg",
                            height: 16,
                            width: 16,
                            color: index < 4
                                ? AppColors.primary1
                                : Colors.blue.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),

                  // Rating Bars
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xffCDDCF4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: List.generate(5, (index) {
                          int star = 5 - index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (5 - index) / 5,
                                    backgroundColor: Colors.grey.shade200,
                                    color: AppColors.primary1,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                UIHelper.boldText(
                                  text: "$star",
                                  fontSize: 12,
                                  color: AppColors.text,
                                ),
                                SizedBox(width: 2),
                                UIHelper.customSvg(
                                  svg: "start-svg-icon.svg",
                                  height: 12,
                                  width: 12,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 💬 Reviews List
          Positioned(
            top: MediaQuery.of(context).padding.top + 270,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
                    child: Row(
                      children: [
                        UIHelper.boldText(
                          text: "All Reviews",
                          fontSize: 16,
                          color: AppColors.text,
                        ),
                        SizedBox(width: 6,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.textblue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: UIHelper.boldText(
                            text: "122",
                            fontSize: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable List
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      children: const [
                        ReviewTile(
                          name: "Emily Wills",
                          time: "09:05 AM",
                          imageUrl: "https://randomuser.me/api/portraits/women/68.jpg",
                        ),
                        ReviewTile(
                          name: "Luke Tailor",
                          time: "09:05 AM",
                          imageUrl: "https://randomuser.me/api/portraits/men/75.jpg",
                        ),

                        ReviewTile(
                          name: "Json Jackson",
                          time: "09:05 AM",
                          imageUrl: "https://randomuser.me/api/portraits/men/30.jpg",
                        ),

                      ],
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

  /// 🔷 Decorative Placeholder
  Widget _buildDecorativeBackground() => Stack(
    children: [
      // UIHelper.customSvg(svg: "bg.svg"),
      UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover),
    ],
  );
}

/// 🧩 Custom Review Tile
class ReviewTile extends StatelessWidget {
  final String name;
  final String time;
  final String imageUrl;

  const ReviewTile({
    super.key,
    required this.name,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 12),

          // Name & Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UIHelper.boldText(
                      text: name,
                      fontSize: 14,
                      color: AppColors.text,
                    ),
                    UIHelper.mediumText(
                      text: time,
                      fontSize: 12,
                      color:AppColors.grey,
                    ),
                  ],
                ),


                const SizedBox(height: 6),

                UIHelper.mediumText(text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                    fontSize: 12, color: AppColors.grey),
                const SizedBox(height: 12),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 1,
                ),
              ],
            ),
          ),



        ],
      ),
    );
  }
}

// class ReviewTile extends StatelessWidget {
//   final String name;
//   final String time;
//   final String imageUrl;
//
//   const ReviewTile({
//     super.key,
//     required this.name,
//     required this.time,
//     required this.imageUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 18),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(name,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
//                         Text(time,
//                             style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     const Text(
//                       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
//                           "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//           const Divider(thickness: 0.5, height: 30),
//         ],
//       ),
//     );
//   }
// }
