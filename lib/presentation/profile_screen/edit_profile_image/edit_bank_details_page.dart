import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';


class EditBankDetailsPage extends StatefulWidget {
  const EditBankDetailsPage({super.key});

  @override
  State<EditBankDetailsPage> createState() => _EditBankDetailsPageState();
}

class _EditBankDetailsPageState extends State<EditBankDetailsPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController routingNumberController = TextEditingController();

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
              text: 'Edit Bank Details',
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
                        const SizedBox(height: AppConstantsSpacing.spacingLarge),
                        _buildInputField('Account Holder Name', "bank-user-icon-svg.svg",  holderNameController, Validator.validateName),
                        const SizedBox(height: AppConstantsSpacing.spacingMedium),
                        _buildInputField('Bank Name', "bank-icon-svg.svg", bankNameController, Validator.validateBankName),
                        const SizedBox(height: AppConstantsSpacing.spacingMedium),
                        _buildInputField('Account Number', "bank-acc-icon-svg.svg", accountNumberController, Validator.validateAccountNumber, keyboardType: TextInputType.number),
                        const SizedBox(height: AppConstantsSpacing.spacingMedium),
                        _buildInputField('Routing Number',"bank-number-icon-svg.svg",  routingNumberController, Validator.validateRoutingNumber, keyboardType: TextInputType.number),
      
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
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              color: Colors.white, // white background
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: UIHelper.customSvg(
              svg: svgIcon,
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }

}
