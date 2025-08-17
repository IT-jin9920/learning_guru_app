// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/services/storage_service.dart';
// import '../../../routes/app_routes.dart';
// import '../../../utils/ui_helper.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Timer(const Duration(seconds: 3), () {
//     //   Get.offNamed(RoutesName.userSelection); // Navigate to bottom nav
//     // });
//
//     Timer(const Duration(seconds: 3), () async {
//       final role = await StorageService.getUserRole();
//
//       if (role != null && role.isNotEmpty) {
//         Get.offNamed(RoutesName.navigation); // Role selected, go to dashboard
//       } else {
//         Get.offNamed(RoutesName.userSelection); // Ask for role
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Faded background text "MENTORS"
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 60, left: 5, right: 5),
//                 child: UIHelper.gradientText(
//                   text: 'MENTORs',
//                   fontSize: 69,
//                   gradientColors: [
//                     Color(0xfffafbfe),
//                     Color(0xffe7edf8),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Center SVG splash icon
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   UIHelper.customSvg(svg: "splash-svg.svg"),
//                 ],
//               ),
//             ),
//
//             // Bottom Logo SVG: "Learning Guru"
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 30),
//                 child: UIHelper.customSvg(svg: "learning-svg.svg"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/ui_helper.dart';

import '../../app_navigation/bottom_navigation_page.dart';
import '../bank_details_page/bank_details_page.dart';
import '../login_screen/login_screen.dart';
import '../mentor_details/mentor_setup_page.dart';
import '../register_screen/register_screen.dart';
import '../setup_your_profile/setup_profile_page.dart';
import '../user_selection/SelectionScree.dart';
import '../verify_documents_page.dart';
import '../walkthrough/walkthrough.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 // String _roleText = "MENTORS"; // Default fallback
  String? _roleText; // Default now is null

  // @override
  // void initState() {
  //   super.initState();
  //   checkSession();
  //
  //  //_checkUserRole();
  //
  //   Timer(const Duration(seconds: 5), () async {
  //
  //    // Get.offNamed(RoutesName.walk);
  //
  //     final role = await StorageService.getUserRole();
  //     final isLoggedIn = StorageService.isLoggedIn();
  //
  //     if (role != null && role.isNotEmpty) {
  //       // User has selected role before
  //     // Get.offNamed(RoutesName.walk); // Navigate to dashboard
  //      Get.offNamed(RoutesName.navigation); // Navigate to dashboard
  //
  //       // Get.offNamed(RoutesName.userSelection);
  //     } else {
  //       // First time → go to selection
  //      // Get.offNamed(RoutesName.walk);
  //       Get.offNamed(RoutesName.userSelection); // Go to role selection
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds:5), () {
      checkSession(); // let this handle the actual flow
    });
  }


  Future<void> checkSession() async {
    final role = await StorageService.getUserRole();
    final isRegistered = StorageService.isRegistered();
    final isLoggedIn = StorageService.isLoggedIn();
    final walkthroughDone = StorageService.isWalkthroughCompleted();
    final setLoginRegisterStatus = await StorageService.getLoginRegisterStatus();
    final profileDone = StorageService.isProfileCompleted();
    final mentoringDone = StorageService.isMentoringSetup();
    final bankDone = StorageService.isBankDetailsUpdated();
    final docDone = StorageService.isDocumentsUploaded();

    print("🔍 Status Check:");
    print("Role: $role");
    print("Walkthrough Done: $walkthroughDone");
    print("Registered: $isRegistered");
    print("Logged In: $isLoggedIn");
    print("LoginRegisterStatus: $setLoginRegisterStatus");
    print("Profile Done: $profileDone");
    print("Mentoring Done: $mentoringDone");
    print("Bank Done: $bankDone");
    print("Docs Done: $docDone");

    // ✅ CASE 1: First-time user (nothing completed)
    if (role == null && !isRegistered && !isLoggedIn && !setLoginRegisterStatus) {
      print("➡️ First-time user → Walkthrough");
      print("Flow: Splash → Walkthrough → UserSelect → Register → OTP → Setup → Bank → Docs → Home");
      Get.offNamed(RoutesName.walk);
      return;
    }

    // ✅ CASE 2: Registered but not completed flow (e.g. app restart mid-onboarding)
    if (role != null && !isRegistered) {
      print("➡️ Role exists but not registered → Register");
      print("Flow: Splash → Register → OTP → Setup → Bank → Docs → Home");
      Get.offNamed(RoutesName.register);
      return;
    }

    // ✅ CASE 3: Registered + Logged In + LoginRegisterStatus FALSE → Start onboarding
    if (isLoggedIn && isRegistered && !setLoginRegisterStatus) {
      if (!profileDone) {
        print("➡️ Profile not completed → SetupProfileScreen");
        Get.offNamed(RoutesName.setupProfileImg);
        return;
      }

      if (!mentoringDone) {
        print("➡️ Mentoring not setup → MentoringSetupScreen");
        Get.off(() => MentoringSetupScreen());
        return;
      }

      if (!bankDone) {
        print("➡️ Bank details not updated → BankDetailsPage");
        Get.offNamed(RoutesName.bankDetails);
        return;
      }

      if (!docDone) {
        print("➡️ Documents not uploaded → VerifyDocumentsPage");
        Get.offNamed(RoutesName.verifyDocuments);
        return;
      }
    }




    // ✅ CASE 4: All setup completed
    if (role != null &&
        isRegistered &&
        isLoggedIn &&
        profileDone &&
        mentoringDone &&
        bankDone &&
        docDone) {
      print("✅ All setup complete → Home");
      Get.offAllNamed(RoutesName.navigation);
      return;
    }

    // ✅ CASE 5: Registered but not logged in → Login setLoginRegisterStatus && !isLoggedIn
     if ( role == null || !isRegistered || !isLoggedIn || setLoginRegisterStatus) {
      print("➡️ Registered but not logged in → Login");
      Get.offNamed(RoutesName.login);
      return;
    }

// ✅ CASE 4: All setup completed
    if (role != null &&
        !isRegistered &&
        isLoggedIn &&
        !profileDone &&
        !mentoringDone &&
        !bankDone &&
        !docDone && setLoginRegisterStatus
    ) {
      print("✅ All setup complete → Home");
      Get.offAllNamed(RoutesName.navigation);
      return;
    }


    // ❗Fallback: Something's wrong → Ask user to login again
    print("⚠️ Fallback → Showing error dialog & redirecting to login");

    Get.defaultDialog(
      title: "Oops!",
      middleText: "Something went wrong. Please login again.",
      confirm: ElevatedButton(
        onPressed: () {
          Get.offNamed(RoutesName.login);
        },
        child: const Text("OK"),
      ),
    );
  }


  // Future<void> checkSession() async {
  //   final role = await StorageService.getUserRole();
  //   final isRegistered = StorageService.isRegistered();
  //   final isLoggedIn = StorageService.isLoggedIn();
  //   final walkthroughDone = StorageService.isWalkthroughCompleted();
  //   final setLoginRegisterStatus = await StorageService.getLoginRegisterStatus(); // 🟢 properly await
  //   final profileDone = StorageService.isProfileCompleted(); // ✅ correct getter
  //   final mentoringDone = StorageService.isMentoringSetup();
  //   final bankDone = StorageService.isBankDetailsUpdated();
  //   final docDone = StorageService.isDocumentsUploaded();
  //
  //   print("🔍 Print:=>");
  //   print("🔍 Role: $role");
  //   print("🔍 Walkthrough Done: $walkthroughDone");
  //   print("🔍 Registered: $isRegistered");
  //   print("🔍 Logged In: $isLoggedIn");
  //   print("🔍 Profile Done: $profileDone");
  //   print("🔍 mentoring Done: $mentoringDone");
  //   print("🔍 Bank Done: $bankDone");
  //   print("🔍 Docs Done: $docDone");
  //
  //   // 1 CASE: First-Time User
  //   if (role == null && isRegistered == false && isLoggedIn == false) {
  //     print("➡️ First-time user → Walkthrough");
  //     print("Splash → Walkthrough → UserSelection → Register → OTP → Setup Profile → Bank → Docs → Home");
  //     Get.off(() => WalkthroughScreen());
  //     return;
  //   }
  //
  //   // 2 CASE: Ragister User
  //   if (role != null && isRegistered == false) {
  //     print("➡️ Not registered → Register");
  //     print("Splash → Register → OTP → Setup Profile → Bank → Docs → Home");
  //     Get.off(() => const RegisterScreen());
  //     return;
  //   }
  //
  //   // if (isLoggedIn == true &&
  //   //     isRegistered == true &&
  //   //     setLoginRegisterStatus == false &&
  //   //     profileDone == false) {
  //   //   print(" → SetupProfileScreen");
  //   //   Get.off(() => const SetupProfileScreen());
  //   //   return;
  //   // }
  //   //
  //   // if (isLoggedIn == true &&
  //   //     isRegistered == true &&
  //   //     setLoginRegisterStatus == false &&
  //   //     profileDone == true && mentoringDone == false) {
  //   //   print(" → MentoringSetupScreen");
  //   //   Get.off(() => MentoringSetupScreen());
  //   //   return;
  //   // }
  //   //
  //   // if (isLoggedIn == true &&
  //   //     isRegistered == true &&
  //   //     setLoginRegisterStatus == false &&
  //   //     profileDone == true &&
  //   //     mentoringDone == true &&
  //   //     bankDone == false) {
  //   //   print(" → BankDetailsPage");
  //   //   Get.off(() => BankDetailsPage());
  //   // }
  //   //
  //   //
  //   //
  //   // if (isLoggedIn == true &&
  //   //     isRegistered == true &&
  //   //     setLoginRegisterStatus == false &&
  //   //     profileDone == true &&
  //   //     mentoringDone == true &&
  //   //     bankDone == true &&
  //   //     docDone == false
  //   // ) {
  //   //   print(" → VerifyDocumentsPage");
  //   //   Get.off(() => VerifyDocumentsPage());
  //   //   return;
  //   // }
  //
  //
  //   // ✅ CASE 2: Registered (Login initiated) but Role Null & Not Logged In → Login
  //   if (role == null && setLoginRegisterStatus == true && isLoggedIn == false && isRegistered == false) {
  //     print("➡️ Registered but Role not null & not logged in → Login");
  //     Get.off(() => const LoginScreen());
  //     return;
  //   }
  //
  //
  //   // ✅ CASE 3: Logged In but Role is null and Not Registered → User Selection
  //   if (role == null && isLoggedIn == false && isRegistered == false) {
  //     print("➡️ Logged in but role null → User Selection");
  //     Get.off(() => const UserSelectionScreen());
  //     return;
  //   }
  //
  //   // ✅ CASE 4: Not Registered → Register
  //   if (isRegistered == false) {
  //     print("➡️ Not registered → Register");
  //     Get.off(() => const RegisterScreen());
  //     return;
  //   }
  //
  //   // ✅ CASE 5A: Registered but not logged in → Login → OTP → Home
  //   if (setLoginRegisterStatus == true && isLoggedIn == false) {
  //     print("➡️ Registered but not logged in → Login");
  //     Get.off(() => const LoginScreen());
  //     return;
  //   }
  //
  //   // ✅ CASE 5B: Logged in, Profile not completed → Home (if profile not mandatory)
  //   if (isLoggedIn == true && profileDone == false) {
  //     print("➡️ Logged in but profile not completed → HomePage");
  //     Get.offAllNamed(RoutesName.navigation);
  //     return;
  //   }
  //
  //   // ✅ CASE 6A: Profile Done, Bank Not Done → Bank Details
  //   if (profileDone == true && bankDone == false) {
  //     print("➡️ Profile done but bank not done → Bank Details");
  //     Get.off(() => BankDetailsPage());
  //     return;
  //   }
  //
  //   // ✅ CASE 6B: Bank Done, Documents Not Uploaded → Verify Documents
  //   if (bankDone == true && docDone == false) {
  //     print("➡️ Bank done but docs not uploaded → Verify Documents");
  //     Get.off(() => VerifyDocumentsPage());
  //     return;
  //   }
  //
  //   // ✅ CASE 7: All Setup Completed → Home Page
  //   if (role != null &&
  //       isRegistered == true &&
  //       isLoggedIn == true &&
  //       profileDone == true &&
  //       bankDone == true &&
  //       docDone == true) {
  //     print("✅ All setup done → Home Page");
  //     Get.offAllNamed(RoutesName.navigation);
  //     return;
  //   }
  //
  //   // ❗Fallback: Default to Login (if somehow no condition matched)
  //   print("⚠️ Fallback → Login");
  //   // Get.off(() => const LoginScreen());
  //   // ❗Fallback: Default to Login (if somehow no condition matched)
  //   print("⚠️ Fallback → Login");
  //
  //   Get.defaultDialog(
  //     title: "Oops!",
  //     middleText: "Something went wrong. Please login again.",
  //     confirm: ElevatedButton(
  //       onPressed: () {
  //         Get.off(() => const LoginScreen());
  //       },
  //       child: const Text("OK"),
  //     ),
  //   );
  //
  //
  // }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            /// Bottom role-based text (STUDENTS / MENTORS / TUTORS)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60,),
                child: UIHelper.gradientText(
                  // text: _roleText,
                  text: _roleText ?? "",
                  fontSize: 65,
                  gradientColors: const [
                    Color(0xfffafbfe),
                    Color(0xffe7edf8),
                  ],
                ),
              ),
            ),

            /// Center SVG icon
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.customSvg(svg: "splash-svg.svg"),
                ],
              ),
            ),

            /// Bottom Logo SVG
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: UIHelper.customSvg(svg: "learning-svg.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
