// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../res/colors/app_color.dart';
// import 'Dummy.dart';
// import 'chat_model/chat_model.dart';
// import 'chat_model/course_model.dart';
// import 'chat_model/user_model.dart';
//
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _searchController = TextEditingController();
//   String searchText = '';
//
//   final List<Tab> tabs = const [
//     Tab(icon: Icon(Icons.message), text: 'Chats'),
//     Tab(icon: Icon(Icons.person), text: 'Users'),
//     Tab(icon: Icon(Icons.school), text: 'Courses'),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabs.length, vsync: this);
//     _searchController.addListener(() {
//       setState(() {
//         searchText = _searchController.text;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   List<ChatModel> get filteredChats {
//     if (searchText.isEmpty) return chatList;
//     return chatList.where((chat) => chat.name.toLowerCase().contains(searchText.toLowerCase())).toList();
//   }
//
//   List<UserModel> get filteredUsers {
//     if (searchText.isEmpty) return userList;
//     return userList.where((user) => user.username.toLowerCase().contains(searchText.toLowerCase())).toList();
//   }
//
//   List<CourseModel> get filteredCourses {
//     if (searchText.isEmpty) return courseList;
//     return courseList.where((course) => course.title.toLowerCase().contains(searchText.toLowerCase())).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: const Text("Search"),
//         backgroundColor: AppColors.primary1,
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: tabs,
//           indicatorColor: AppColors.white,
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//               ),
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 buildChatList(filteredChats),
//                 buildUserList(filteredUsers),
//                 buildCourseList(filteredCourses),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildChatList(List<ChatModel> chats) {
//     return ListView.builder(
//       itemCount: chats.length,
//       itemBuilder: (_, index) {
//         final chat = chats[index];
//         return ListTile(
//           title: Text(chat.name),
//           subtitle: Text(chat.message),
//           trailing: Text(chat.updatedAt.toLocal().toString().split(' ').last),
//         );
//       },
//     );
//   }
//
//   Widget buildUserList(List<UserModel> users) {
//     return ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (_, index) {
//         final user = users[index];
//         return ListTile(
//           title: Text(user.username),
//           subtitle: Text(user.role),
//           trailing: Text(user.updatedAt.toLocal().toString().split(' ').last),
//         );
//       },
//     );
//   }
//
//   Widget buildCourseList(List<CourseModel> courses) {
//     return ListView.builder(
//       itemCount: courses.length,
//       itemBuilder: (_, index) {
//         final course = courses[index];
//         return ListTile(
//           title: Text(course.title),
//           subtitle: Text(course.instructor),
//           trailing: Text(course.updatedAt.toLocal().toString().split(' ').last),
//         );
//       },
//     );
//   }
// }
