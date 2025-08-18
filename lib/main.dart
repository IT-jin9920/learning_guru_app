import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';
import 'app.dart';
import 'core/services/storage_service.dart';
import 'presentation/app_navigation/bottom_navigation_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize network service
  await NetworkService.instance.initialize();

  // Configure EasyLoading
  _configureEasyLoading();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // default to black icons
  ));


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

void _configureEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black87
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..progressColor = Colors.white
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
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

