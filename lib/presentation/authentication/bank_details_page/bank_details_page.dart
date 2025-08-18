import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/routes/app_routes.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../core/services/storage_service.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';
import '../../mentor/home_screen/mentro_home_page.dart';
import '../verify_documents_page.dart';


class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {

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
        // appBar: AppBar(
        //   backgroundColor: AppColors.white,
        //   elevation: 0,
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 16),
        //     child: GestureDetector(
        //       onTap: () {
        //         // Navigator.pop(context);
        //         Get.back();
        //       },
        //       child: Container(
        //         height: 40,
        //         width: 40,
        //         decoration: const BoxDecoration(
        //           color: Color(0xFFCEDBF1),
        //           shape: BoxShape.circle,
        //         ),
        //         padding: const EdgeInsets.all(8),
        //         child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
        //       ),
        //     ),
        //   ),
        //   toolbarHeight: 80,
        // ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  color: AppColors.white,
                  height: 80, // same as toolbarHeight
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFCEDBF1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                        ),
                      ),

                    ],
                  ),
                ),

                UIHelper.boldText(
                  text:  'Bank Details',
                  fontSize: 32,
                  color: AppColors.textblue,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: AppConstantsSpacing.spacingSmall),

                UIHelper.mediumText(
                  text:
                  'Provide us a little more details about you',
                  fontSize: 14,
                  color: AppColors.grey,
                  fontWeight: FontWeight.normal,
                ),

                const SizedBox(height: AppConstantsSpacing.spacingExtraLarge),
                _buildInputField('Account Holder Name', "bank-user-icon-svg.svg",  holderNameController, Validator.validateName),
                const SizedBox(height: AppConstantsSpacing.spacingMedium),
                _buildInputField('Bank Name', "bank-icon-svg.svg", bankNameController, Validator.validateBankName),
                const SizedBox(height: AppConstantsSpacing.spacingMedium),
                _buildInputField('Account Number', "bank-acc-icon-svg.svg", accountNumberController, Validator.validateAccountNumber, keyboardType: TextInputType.number),
                const SizedBox(height: AppConstantsSpacing.spacingMedium),
                _buildInputField('Routing Number',"bank-number-icon-svg.svg",  routingNumberController, Validator.validateRoutingNumber, keyboardType: TextInputType.number),
                const SizedBox(height: AppConstantsSpacing.spacingExtraLarge * 4),

                // GradientButton(text: "Proceed Further",
                //     onTap: () async {
                //       final holderName = holderNameController.text.trim();
                //       final bankName = bankNameController.text.trim();
                //       final accountNumber = accountNumberController.text.trim();
                //       final routingNumber = routingNumberController.text.trim();
                //
                //       final holderError = Validator.validateName(holderName);
                //       final bankError = Validator.validateBankName(bankName);
                //       final accNumError = Validator.validateAccountNumber(accountNumber);
                //       final routingError = Validator.validateRoutingNumber(routingNumber);
                //
                //       // if (holderError == null &&
                //       //     bankError == null &&
                //       //     accNumError == null &&
                //       //     routingError == null) {
                //       //   // All fields valid
                //       //   Get.snackbar(
                //       //     "Success",
                //       //     "Bank Details Submitted",
                //       //     backgroundColor: Colors.green.shade100,
                //       //     snackPosition: SnackPosition.TOP,
                //       //     colorText: Colors.black,
                //       //     margin: const EdgeInsets.all(16),
                //       //     borderRadius: 10,
                //       //   );
                //       //
                //       //   // Navigator.push(
                //       //   //   context,
                //       //   //   MaterialPageRoute(builder: (context) =>  VerifyDocumentsPage()),
                //       //   // );
                //       //
                //       //   await StorageService.setBankDetailsUpdated(true);
                //       //   Get.to(() => VerifyDocumentsPage());
                //       // } else {
                //       //   // Show the first validation error
                //       //   final errorMsg = holderError ?? bankError ?? accNumError ?? routingError;
                //       //
                //       //   Get.snackbar(
                //       //     "Validation Error",
                //       //     errorMsg!,
                //       //     backgroundColor: Colors.red.shade100,
                //       //     snackPosition: SnackPosition.TOP,
                //       //     colorText: Colors.black,
                //       //     margin: const EdgeInsets.all(16),
                //       //     borderRadius: 10,
                //       //   );
                //       // }
                //
                //       await StorageService.setBankDetailsUpdated(true);
                //       Get.to(() => VerifyDocumentsPage());
                //     }
                //
                //
                // ),
                SizedBox(
                    height: MediaQuery.of(context).padding.bottom +
                        AppConstantsSpacing.spacingLarge),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstantsSpacing.paddingLarge,
            vertical: 18,
          ),
          child: GradientButton(text: "Proceed Further",
              onTap: () async {
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
                //   // All fields valid
                //   Get.snackbar(
                //     "Success",
                //     "Bank Details Submitted",
                //     backgroundColor: Colors.green.shade100,
                //     snackPosition: SnackPosition.TOP,
                //     colorText: Colors.black,
                //     margin: const EdgeInsets.all(16),
                //     borderRadius: 10,
                //   );
                //
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(builder: (context) =>  VerifyDocumentsPage()),
                //   // );
                //
                //   await StorageService.setBankDetailsUpdated(true);
                //   Get.to(() => VerifyDocumentsPage());
                // } else {
                //   // Show the first validation error
                //   final errorMsg = holderError ?? bankError ?? accNumError ?? routingError;
                //
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

                await StorageService.setBankDetailsUpdated(true);
                // Get.to(() => VerifyDocumentsPage());
                Get.toNamed(RoutesName.verifyDocuments);

              }


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
        //   margin: const EdgeInsets.only(right: 4),
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
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: UIHelper.customSvgOnTap(
              // svg: "password-check.svg",
              svg: svgIcon,
              height: 20,
              width: 20,
              //onTap: onToggleVisibility,
            ),
          ),
        ),
      ),
    );
  }

}
