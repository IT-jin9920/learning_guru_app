import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../core/services/storage_service.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';


class EditMentorshipDetailsPage extends StatefulWidget {
  const EditMentorshipDetailsPage({super.key});

  @override
  State<EditMentorshipDetailsPage> createState() => _EditMentorshipDetailsPageState();
}

class _EditMentorshipDetailsPageState extends State<EditMentorshipDetailsPage> {
  bool _isByProfessionSelected = true;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController routingNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
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
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerRight,
            child: UIHelper.boldText(
              text: 'Edit Mentorship Info',
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
          toolbarHeight: 80,
        ),
      
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Form(
                  key: _formKey,
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[


                        // Toggle Tabs
                        if (userRole == 'mentor')...[
                          Row(
                            children: [
                              Expanded(
                                child: _buildToggleButton(
                                  text: 'By Profession',
                                  isSelected: _isByProfessionSelected,
                                  onTap: () =>
                                      setState(() => _isByProfessionSelected = true),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildToggleButton(
                                  text: 'By Lifecoaching',
                                  isSelected: !_isByProfessionSelected,
                                  onTap: () =>
                                      setState(() => _isByProfessionSelected = false),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Conditional Fields
                        if (userRole == 'mentor') ...[
                          _buildDropdown('Mentorship Category'),
                          const SizedBox(height: 16),
                          _buildDropdown('Mentorship Sub Category'),
                          const SizedBox(height: 16),
                        ] else if (userRole == 'tutor') ...[
                          _buildDropdown('Teaching Field'),
                          const SizedBox(height: 16),
                          _buildDropdown('Teaching Standard'),
                          const SizedBox(height: 16),
                        ],

                        // Hourly Charges Input
                        _buildHourlyChargesInput(),


                        // const SizedBox(height: AppConstants.spacingLarge),
                        // _buildInputField('Account Holder Name', "bank-user-icon-svg.svg",  holderNameController, Validator.validateName),
                        // const SizedBox(height: AppConstants.spacingMedium),
                        // _buildInputField('Bank Name', "bank-icon-svg.svg", bankNameController, Validator.validateBankName),
                        // const SizedBox(height: AppConstants.spacingMedium),
                        // _buildInputField('Account Number', "bank-acc-icon-svg.svg", accountNumberController, Validator.validateAccountNumber, keyboardType: TextInputType.number),
                        // const SizedBox(height: AppConstants.spacingMedium),
                        // _buildInputField('Routing Number',"bank-number-icon-svg.svg",  routingNumberController, Validator.validateRoutingNumber, keyboardType: TextInputType.number),
      
                        const Spacer(), // Push button to bottom when possible
      
                        const SizedBox(height: AppConstantsSpacing.spacingLarge),
                        // GradientButton(
                        //   text: "Proceed Further",
                        //   onTap: () {
                        //     final holderName = holderNameController.text.trim();
                        //     final bankName = bankNameController.text.trim();
                        //     final accountNumber = accountNumberController.text.trim();
                        //     final routingNumber = routingNumberController.text.trim();
                        //
                        //     final holderError = Validator.validateName(holderName);
                        //     final bankError = Validator.validateBankName(bankName);
                        //     final accNumError = Validator.validateAccountNumber(accountNumber);
                        //     final routingError = Validator.validateRoutingNumber(routingNumber);
                        //
                        //     if (holderError == null &&
                        //         bankError == null &&
                        //         accNumError == null &&
                        //         routingError == null) {
                        //       Get.snackbar(
                        //         "Success",
                        //         "Bank Details Submitted",
                        //         backgroundColor: Colors.green.shade100,
                        //         snackPosition: SnackPosition.TOP,
                        //         colorText: Colors.black,
                        //         margin: const EdgeInsets.all(16),
                        //         borderRadius: 10,
                        //       );
                        //       Get.back(); // or navigate to next
                        //     } else {
                        //       final errorMsg = holderError ?? bankError ?? accNumError ?? routingError;
                        //       Get.snackbar(
                        //         "Validation Error",
                        //         errorMsg!,
                        //         backgroundColor: Colors.red.shade100,
                        //         snackPosition: SnackPosition.TOP,
                        //         colorText: Colors.black,
                        //         margin: const EdgeInsets.all(16),
                        //         borderRadius: 10,
                        //       );
                        //     }
                        //   },
                        // ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom + AppConstantsSpacing.spacingLarge),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge, vertical: 18),
      child:   GradientButton(
        text: "Proceed Further",
        onTap: () {
          final holderName = holderNameController.text.trim();
          final bankName = bankNameController.text.trim();
          final accountNumber = accountNumberController.text.trim();
          final routingNumber = routingNumberController.text.trim();

          final holderError = Validator.validateName(holderName);
          final bankError = Validator.validateBankName(bankName);
          final accNumError = Validator.validateAccountNumber(accountNumber);
          final routingError = Validator.validateRoutingNumber(routingNumber);

          // if (holderError == null &&
          //     bankError == null &&
          //     accNumError == null &&
          //     routingError == null) {
          //   Get.snackbar(
          //     "Success",
          //     "Bank Details Submitted",
          //     backgroundColor: Colors.green.shade100,
          //     snackPosition: SnackPosition.TOP,
          //     colorText: Colors.black,
          //     margin: const EdgeInsets.all(16),
          //     borderRadius: 10,
          //   );
          //   Get.back(); // or navigate to next
          // } else {
          //   final errorMsg = holderError ?? bankError ?? accNumError ?? routingError;
          //   Get.snackbar(
          //     "Validation Error",
          //     errorMsg!,
          //     backgroundColor: Colors.red.shade100,
          //     snackPosition: SnackPosition.TOP,
          //     colorText: Colors.black,
          //     margin: const EdgeInsets.all(16),
          //     borderRadius: 10,
          //   );
          // }

          Get.back(); // or navigate to next
        },
      ),
      ),
      ),
    );
  }

  Widget _buildInputField(
      String hintText,
      String svgIcon,
      TextEditingController controller,
      String? Function(String?) validator, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'BeVietnamPro',
        fontSize: 16,
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightgreencolor,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 16,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstantsSpacing.paddingMedium,
          vertical: AppConstantsSpacing.paddingMedium,
        ),
        // suffixIcon: Container(
        //   margin: const EdgeInsets.only(right: AppConstants.paddingMedium),
        //   decoration: const BoxDecoration(
        //     color: AppColors.white,
        //     shape: BoxShape.circle,
        //   ),
        //   padding: const EdgeInsets.all(8),
        //   child: UIHelper.customSvg(
        //     svg: svgIcon,
        //     height: 20,
        //     width: 20,
        //   ),
        // ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white, // white background
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: UIHelper.customSvg(
              svg: svgIcon,
              height: 25,
              width: 25,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String title) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.lightgreencolor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UIHelper.mediumText(
            text: title,
            fontSize: 14,
            color: AppColors.black,
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyChargesInput() {
    return TextField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 16, color: AppColors.text),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightgreencolor,
        hintText: "Hourly Charges",
        hintStyle: AppFontStyles.beVietnamProMedium500.copyWith(
          fontSize: 16,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              height: 20,
              width: 20,
              child: UIHelper.customSvg(
                svg: "hourely-rate-icon-svg.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightgreencolor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected ? AppColors.primary1 : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: UIHelper.mediumText(
          text: text,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? AppColors.primary1
              : AppColors.text.withOpacity(0.7),
        ),
      ),
    );
  }

}
