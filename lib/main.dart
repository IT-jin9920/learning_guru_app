import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'core/services/storage_service.dart';
import 'presentation/app_navigation/bottom_navigation_page.dart';
import 'presentation/student/community_page/chat_details_page/chat_details.dart';

void main() async {

  // WidgetsFlutterBinding.ensureInitialized();
  //
  // Get.put(DialController());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // default to black icons
  ));

  WidgetsFlutterBinding.ensureInitialized();

  // Lock device orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await StorageService.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  Get.lazyPut(() => BottomNavController());
  runApp(const LearningGuruApp());

}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Needed for async work in main()
//   await StorageService.init(); // 👈 initialize shared preferences
//
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode, // Only in debug mode
//       builder: (context) => const LearningGuruApp(),
//     ),
//   );
// }

