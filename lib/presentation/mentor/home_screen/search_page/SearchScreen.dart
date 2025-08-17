// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:learning_guru_app/presentation/session_screen/session_details_page.dart';
// import '../../../res/colors/app_color.dart';
// import '../../../res/constants/constants.dart';
// import '../../../utils/ui_helper.dart';
// import '../../app_navigation/bottom_navigation_page.dart'; // Ensure UIHelper methods are implemented properly
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   int selectedTabIndex = 0;
//
//   final List<String> tabs = ["Community", "Sessions", "Courses"];
//   final List<String> icons = [
//     "Community.svg",
//     "Sessions.svg",
//     "Courses.svg",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFeaf2ff),
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         toolbarHeight: 70,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: GestureDetector(
//             onTap: () {
//              // Get.back();
//               Navigator.pop(context);
//             },
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFCEDBF1),
//                 shape: BoxShape.circle,
//               ),
//               padding: const EdgeInsets.all(8),
//               child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
//             ),
//           ),
//         ),
//         title: Padding(
//           padding: const EdgeInsets.only(right: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: const [
//               Text(
//                 'Search Bar',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: Stack(
//         children: [
//           /// Rotated Background Image
//           // Positioned(
//           //   top: -100,
//           //   right: -50,
//           //   child: Transform.rotate(
//           //     angle: 48.36 * 3.1416 / 180,
//           //     child: Opacity(
//           //       opacity: 0.4,
//           //       child: SizedBox(
//           //         width: 250,
//           //         height: 250,
//           //         child: UIHelper.customImage(img: 'bg.png'),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           _buildDecorativeBackground(),
//
//           /// Foreground Content
//           SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     spreadRadius: 2,
//                     blurRadius: 10,
//                     offset: const Offset(0, -3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 24),
//
//                   /// Search Field
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFCDDCF4),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(3.0),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Color(0xFF03002F),
//                             ),
//                             child: Center(
//                               child: SizedBox(
//                                 height: 16,
//                                 width: 16,
//                                 child: UIHelper.customSvg(svg: "serch-icon-svg.svg"),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         const Expanded(
//                           child: TextField(
//                             style: TextStyle(
//                               fontFamily: 'BeVietnamPro',
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12,
//                             ),
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.symmetric(vertical: 12),
//                               hintText: "Search for Community, Chats, Courses..",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                 fontFamily: 'BeVietnamPro',
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   /// Tabs
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(tabs.length, (index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedTabIndex = index;
//                           });
//                         },
//                         child: _buildTab(tabs[index], selectedTabIndex == index,icons[index]),
//
//                       );
//                     }),
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   /// Underline Animation
//                   Stack(
//                     children: [
//                       Container(height: 2, width: double.infinity),
//                       AnimatedAlign(
//                         alignment: Alignment(
//                           -1 + (selectedTabIndex * (2 / (tabs.length - 1))),
//                           0,
//                         ),
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 32),
//                           height: 2,
//                           width: MediaQuery.of(context).size.width / tabs.length - 32,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   /// Dynamic Tab Content
//                   Expanded(child: _buildTabContent()),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDecorativeBackground() => Stack(
//     children: [
//       UIHelper.customImage(
//         img: "bg.png",
//         fit: BoxFit.cover, // Ensures the image fills the entire background
//       ),
//     ],
//   );
//
//   Widget _buildTab(String label, bool selected, String icon) {
//     return Row(
//       children: [
//         SizedBox(
//           height: 18,
//           width: 18,
//           child: UIHelper.customSvg(
//             svg: icon,
//             color: selected ? Colors.blue : Colors.grey,
//           ),
//         ),
//         const SizedBox(width: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: selected ? Colors.black : Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTabContent() {
//     if (selectedTabIndex == 0) {
//       return ListView(
//         physics: BouncingScrollPhysics(),
//         children: [
//           _chatItem(
//             imagePath: "assets/images/user-1.png",
//             name: "Mathematic Heads",
//             message: "Luke Tailor: Hello All.!!",
//             time: "10:23 AM",
//             showNotification: true,
//           ),
//           _chatItem(
//             imagePath: "assets/images/png-user-2.png",
//             name: "Maths todo",
//             message: "You: Sure I’ll Share it Soon.",
//             time: "09:05 AM",
//             showNotification: false,
//           ),
//         ],
//       );
//     } else if (selectedTabIndex == 1) {
//       return SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             SizedBox(height: 12),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 const SizedBox(width: 11), // Spacer between cards
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
//               ],
//             ),
//             SizedBox(height: 12),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 const SizedBox(width: 11), // Spacer between cards
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
//               ],
//             ),
//             SizedBox(height: 12),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 const SizedBox(width: 11), // Spacer between cards
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
//               ],
//             ),
//             SizedBox(height: 12),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 const SizedBox(width: 11), // Spacer between cards
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
//               ],
//             ),
//             SizedBox(height: 12),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 const SizedBox(width: 11), // Spacer between cards
//                 _buildUserCard(
//                   name: 'Luke Tailor',
//                   subject: 'Maths',
//                   imagePath: 'user-1.png',
//                   price: '10',
//                   rating: 4.8,
//                 ),
//
//                 // const SizedBox(height: AppConstants.spacingExtraLarge * 2),
//               ],
//             ),
//           ],
//         ),
//       );
//     } else {
//       return ListView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         children: [
//           buildCourseCard(
//             image: 'assets/images/cours_imag_thum.png',
//             category: 'Business',
//             title: 'The Core Structure of the 3D Design & Motion',
//             author: 'Rob Tuytel',
//             rating: 4.2,
//           ),
//           buildCourseCard(
//             image: 'assets/images/cours_imag_thum.png',
//             category: 'Design',
//             title: 'Master UI/UX in 30 Days',
//             author: 'Sarah Klein',
//             rating: 4.8,
//           ),
//           buildCourseCard(
//             image: 'assets/images/cours_imag_thum.png',
//             category: 'Programming',
//             title: 'Full Stack Web Development Bootcamp',
//             author: 'James Carter',
//             rating: 4.6,
//           ),
//           buildCourseCard(
//             image: 'assets/images/cours_imag_thum.png',
//             category: 'Photography',
//             title: 'Product Photography with Lighting',
//             author: 'Mia Sanders',
//             rating: 4.7,
//           ),
//           buildCourseCard(
//             image: 'assets/images/cours_imag_thum.png',
//             category: 'Teaching',
//             title: 'Effective Teaching Strategies',
//             author: 'Dr. Neil Joseph',
//             rating: 4.3,
//           ),
//         ],
//       );
//
//
//     }
//   }
//
//   Widget _chatItem({
//     required String imagePath,
//     required String name,
//     required String message,
//     required String time,
//     bool showNotification = false,
//   }) {
//     return ListTile(
//       leading: Stack(
//         children: [
//           CircleAvatar(
//             radius: 28,
//             backgroundImage: AssetImage(imagePath),
//           ),
//           if (showNotification)
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: Container(
//                 height: 20,
//                 width: 20,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue,
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "1",
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       title: Text(
//         name,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF03002F),
//         ),
//       ),
//       subtitle: Text(
//         message,
//         style: const TextStyle(color: Colors.grey),
//       ),
//       trailing: Text(
//         time,
//         style: const TextStyle(color: Colors.grey, fontSize: 12),
//       ),
//     );
//   }
//
//   Widget _buildUserCard({
//     required String name,
//     required String subject,
//     required String imagePath,
//     required String price,
//     required double rating,
//   }) {
//     return GestureDetector(
//       onTap: () {
//        // Get.to(() => SessionDetailsPage());
//         final bottomNavController = Get.find<BottomNavController>();
//         bottomNavController.changeTab(4);
//         //Get.to(SessionDetailsPage());
//         Get.back();
//         print("Tap on user chat");
//       },
//       child: Container(
//         height: 131,
//         width: 158,
//         decoration: BoxDecoration(
//           color: const Color(0xFFe6e8ed),
//           borderRadius: BorderRadius.circular(32),
//         ),
//         padding: const EdgeInsets.all(5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Avatar and Price
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Avatar
//                 SizedBox(
//                   width: 60,
//                   height: 60,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(32),
//                     child: UIHelper.customImage(img: "$imagePath"),
//                   ),
//                 ),
//
//                 // Chat Tag
//                 GestureDetector(
//                   onTap: () {
//                     final bottomNavController = Get.find<BottomNavController>();
//                     bottomNavController.changeTab(1);
//                     Get.back();
//                     print("Tap on user chat");
//                   },
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
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// Name
//                   UIHelper.boldText(text: name, fontSize: 14, color: AppColors.text, ),
//
//                   const SizedBox(height: 2),
//
//                   /// Rating
//                   Row(
//                     children: [
//                       UIHelper.mediumText(text: "11th Nov,",fontSize: 12, color: AppColors.textblue, ),
//                       const SizedBox(width: 4),
//                       UIHelper.mediumText(text:  "10:00 AM",fontSize: 12, color: AppColors.textblue, ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildCourseCard({
//     required String image,
//     required String category,
//     required String title,
//     required String author,
//     required double rating,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16), // spacing between cards
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F4FA),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image section
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(24),
//               topRight: Radius.circular(24),
//             ),
//             child: Image.asset(
//               image,
//               height: 160,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           // Info section
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Category + Rating Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Category badge
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Text(
//                         category,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//
//                     // Rating
//                     Row(
//                       children: [
//                         const Icon(Icons.star, color: Colors.blue, size: 18),
//                         const SizedBox(width: 4),
//                         Text(
//                           rating.toStringAsFixed(1),
//                           style: const TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 /// Title
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//
//                 const SizedBox(height: 6),
//
//                 /// Author
//                 Text(
//                   'by: $author',
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }
