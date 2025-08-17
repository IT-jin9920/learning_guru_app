import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../utils/ui_helper.dart';
import '../../home_screen/search_page/search_screen.dart';
import '../upload_course/upload_course_screen.dart';
import 'upload_funLern_screen.dart';

class LearnWithFunPage extends StatelessWidget {
  final List<Map<String, String>> contentList = [
    {
      "image": "fun-img-1.png",
      "title": "The Core Structure of the 3D Design & Motion",
      "author": "Rob Tuytel"
    },
    {
      "image": "fun-img-2.png",
      "title": "Understanding Animation Layers in Fun Learning",
      "author": "Maya Cook"
    },
    {
      "image": "fun-img-3.png",
      "title": "Mastering Visual Effects for Kids",
      "author": "Alex Brenner"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// AppBar
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerRight,
          child: UIHelper.boldText(
            text: 'Learn with Fun',
            fontSize: 18,
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFCEDBF1),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
          ),
          onPressed: () => Get.back(),
        ),
      ),

      /// Body content
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            /// Top Row Buttons
            Row(
              children: [
                /// Upload Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => UploadFunlernScreen());
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textblue,
                        borderRadius: BorderRadius.circular(46),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: UIHelper.boldText(
                              text: 'Upload Fun Video',
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          UIHelper.customSvg(
                            svg: 'doubal-right-arrow-svg-icon.svg',
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                /// Smile & Search Icon Box
                Container(
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCDDCF4),
                    borderRadius: BorderRadius.circular(46),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 3,),
                      UIHelper.customSvgOnTap(
                        svg: "filter-svg-icon.svg",
                        height: 20,
                        width: 20,
                        onTap: () {
                         // Get.to(() => LearnWithFunPage());

                        },
                      ),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF03002F),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 16,
                            width: 16,
                            child: UIHelper.customSvgOnTap(
                              svg: "serch-icon-svg.svg",
                              onTap: ()=> Get.to(SearchScreen()),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

           // const SizedBox(height: 30),

            /// Swiper using CardSwiper (v7.0.2)
            SizedBox(
              height: 580,
              child: CardSwiper(
                cardsCount: contentList.length,
                isLoop: true,
                numberOfCardsDisplayed: 3,
                //padding: const EdgeInsets.symmetric(horizontal: 32), // creates spacing for side cards
                //backCardOffset: const Offset(0, 30), // <- horizontal stack (not vertical!)
                scale: 0.3, // scaling for depth
                cardBuilder: (context, index, percentX, percentY) {
                  final item = contentList[index];
                  return _buildContentCard(
                    context,
                    imageAsset: item['image']!,
                    title: item['title']!,
                    author: item['author']!,
                  );
                },
              ),
            ),


            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Content Card Widget
  Widget _buildContentCard(
      BuildContext context, {
        required String imageAsset,
        required String title,
        required String author,
      }) {
    return Container(
     // height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xffE0E2E9),
        borderRadius: BorderRadius.circular(35),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(35),
              ),
              child: UIHelper.customImage(img: imageAsset,fit: BoxFit.cover),
            ),

            /// Title & Author
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.boldText(
                    text: title,
                    fontSize: 14,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),

                  const SizedBox(height: 8.0),
                  UIHelper.mediumText(text: 'by: $author', fontSize: 12, color: Color(0xff88889f)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
