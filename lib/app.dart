import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/getx_localization/languages.dart';
import 'package:learning_guru_app/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'routes/routes_name.dart';



class LearningGuruApp extends StatelessWidget {
  const LearningGuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Learning Guru',
      debugShowCheckedModeBanner: false,

      // Theme mode
      //themeMode: ThemeMode.system,


      // GetX (Internationalization)
      translations: Languages(),                 // Translations map
      locale: const Locale('en'),                // Default locale
      fallbackLocale: const Locale('en'),        // Fallback if unsupported

      // Global SafeArea wrapper
     // builder: (context, child) => StatusBarWrapper(child: child ?? SizedBox()),

      //Inside GetMaterialApp or MaterialApp
      // builder: (context, child) {
      //   final Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
      //
      //   //final Brightness brightness = MediaQuery.of(context).platformBrightness;
      //
      //   // Determine the brightness to use
      //   final Brightness brightness =
      //   systemBrightness == Brightness.light || systemBrightness == Brightness.dark
      //       ? systemBrightness
      //       : Brightness.dark; // ✅ Default fallback
      //
      //   // Set correct status bar icon color
      //   final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
      //       ? SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,
      //     //statusBarColor: Colors.indigo,
      //     //statusBarColor: Colors.grey,
      //     //statusBarIconBrightness: Brightness.dark, // white icons
      //     statusBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      //
      //     statusBarBrightness: Brightness.dark,
      //   )
      //       : SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,
      //    // statusBarColor: Colors.white70,
      //    // statusBarIconBrightness: Brightness.dark, // black icons
      //     statusBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      //
      //     statusBarBrightness: Brightness.light,
      //   );
      //
      //   // Apply system overlay style
      //   SystemChrome.setSystemUIOverlayStyle(overlayStyle);
      //
      //   // Set scaffold background color as per theme
      //   final Color backgroundColor =
      //   brightness == Brightness.dark ? Colors.transparent : Colors.transparent;
      //  // brightness == Brightness.dark ? Colors.black : Colors.transparent;
      //
      //
      //   return WillPopScope(
      //     // onWillPop: () async {
      //     //   Get.back(); // Always go to previous screen
      //     //   return false; // Prevent default system pop
      //     // },
      //     onWillPop: () async {
      //       bool exitApp = await Get.dialog<bool>(
      //         AlertDialog(
      //           title: const Text("Exit App"),
      //           content: const Text("Are you sure you want to exit the app?"),
      //           actions: [
      //             TextButton(
      //               onPressed: () => Get.back(result: false),
      //               child: const Text("No"),
      //             ),
      //             TextButton(
      //               onPressed: () => Get.back(result: true),
      //               child: const Text("Yes"),
      //             ),
      //           ],
      //         ),
      //       ) ??
      //           false;
      //
      //       return exitApp;
      //     },
      //
      //     child: Scaffold(
      //       backgroundColor: backgroundColor,
      //       body: SafeArea(
      //         top: true,
      //         //bottom: true,
      //         child: child ?? Container(),
      //       ),
      //     ),
      //   );
      // },


      // builder: (context, child) {
      //   // ✅ Always set status bar icon color to dark (black icons)
      //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      //
      //   return Scaffold(
      //     backgroundColor: Colors.white, // ✅ Force full white background
      //     body: SafeArea(
      //       top: true,
      //       bottom: true,
      //       child: child ?? const SizedBox(),
      //     ),
      //   );
      // },

      // Routing
      //initialRoute: AppRoutes.initialRoute,
      initialRoute: RoutesName.splash,

      // Routing
      getPages: AppPages.pages,

      // IMPORTANT: Use `home` instead of `initialRoute`
      //home: const BottomNavigationPage(), // Entry point is the navigation shell

     // home: const PollCreate(),

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Respect system light/dark theme
      // Transitions (optional)
      defaultTransition: Transition.fadeIn,
      builder: EasyLoading.init(),
    );

  }
}
