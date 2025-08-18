import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/authentication/login_screen/login_screen.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../core/services/storage_service.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../routes/app_routes.dart';
import '../register_screen/register_screen.dart';
import '../setup_your_profile/setup_profile_page.dart';

class OTPVerificationPage extends StatefulWidget {
  final String source; // "login" or "register"

  const OTPVerificationPage({Key? key, required this.source}) : super(key: key);

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}


class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _fetchUserRole();

    print("OTP Page from: ${widget.source}");

    // Auto-focus the first field with a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _focusNodes[0].requestFocus();
    });

  }

  void _fetchUserRole() async {
    final role = await StorageService.getUserRole();
    print("User role from StorageService: $role");

    if (role != null && role.isNotEmpty) {
      setState(() {
        userRole = role; // This triggers UI rebuild
      });
    }
  }

  String userRole = ''; // Example: "Mentor", "Teacher", etc.


  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child:WillPopScope(
        onWillPop: () async{
          Get.back();
          return false;
        },
        child: Scaffold(
        backgroundColor: Colors.transparent,
          //backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                  // );
                  Get.offAllNamed(RoutesName.login);

                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCEDBF1), // #CEDBF1
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                ),
              ),
            ),

            toolbarHeight: 80,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.boldText(text:  'Verification', fontSize: 32, color: AppColors.textblue),
                const SizedBox(height: AppConstantsSpacing.spacingSmall),
                userRole == 'student'?  UIHelper.mediumText(text:    'Enter the 6 Digit OTP received on your\nregistered Email or Phone.', fontSize: 14, color: AppColors.grey)
                :  UIHelper.mediumText(text:    'Enter the 6 Digit OTP received on your\nregistered Email.', fontSize: 14, color: AppColors.grey),
                const SizedBox(height: 56),
                _buildOtpFields(),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      UIHelper.mediumText(text:    "Didn't Received a code? ", fontSize: 14, color: AppColors.text),
                    GestureDetector(
                      onTap: () {
                        debugPrint('Resend OTP tapped');
                      },
                      child:
                      UIHelper.mediumText(text:   'Resend', fontSize: 14, color: AppColors.primary1, fontWeight: FontWeight.bold),

                    ),
                  ],
                ),
                const SizedBox(height: AppConstantsSpacing.spacingExtraLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 50,
          height: 60,
          child: TextField(
            textInputAction: TextInputAction.none,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            showCursor: true,
            enableSuggestions: false,
            autocorrect: false,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'BeVietnamPro',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: AppColors.lightgreencolor,
              hintText: "-",
              hintStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text.withOpacity(0.3),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80), // 🔄 Rounded corner 80
                borderSide: BorderSide.none,
              ),
            ),
            // onChanged: (value) {
            //   if (value.isNotEmpty && index < 5) {
            //     FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            //   } else if (value.isEmpty && index > 0) {
            //     FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            //   }
            //
            //   bool allFilled = _otpControllers.every((controller) => controller.text.trim().isNotEmpty);
            //   if (allFilled) {
            //     Future.delayed(const Duration(milliseconds: 200), () {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => const SetupProfileScreen()),
            //       );
            //     });
            //   }
            // },

              onChanged: (value) async {
                if (value.isNotEmpty) {
                  if (index < 5) {
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  } else {
                    // ✅ All fields filled
                    bool allFilled = _otpControllers.every(
                            (controller) => controller.text.trim().isNotEmpty);

                    if (allFilled) {
                      FocusScope.of(context).unfocus(); // Hide keyboard
                      await Future.delayed(const Duration(milliseconds: 200));
                      print("✅ OTP filled from: ${widget.source}");

                      await StorageService.setLoginStatus(true);
                      await StorageService.setLoginRegisterStatus(true);

                      if (widget.source == "login") {
                        await StorageService.setLoginStatus(true);
                        await StorageService.setRegisterStatus(true);
                        print("Login flow complete");
                        Get.offAllNamed(RoutesName.navigation);

                      } else {
                        await StorageService.setRegisterStatus(true);
                        print("Register flow complete");
                        Get.off(() => const SetupProfileScreen());
                      }
                    }
                  }
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }},

          ),
        );
      }),
    );
  }


}
