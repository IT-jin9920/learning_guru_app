import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learning_guru_app/presentation/mentor/home_screen/mentro_home_page.dart';

import '../../core/common/doumnts_uplode.dart';
import '../../res/colors/app_color.dart';
import '../../res/constants/constants.dart';
import '../app_navigation/bottom_navigation_page.dart';
import 'bank_details_page/bank_details_page.dart';


class UplodeVerifyDocumentsPage extends StatefulWidget {
  const UplodeVerifyDocumentsPage({super.key});

  @override
  State<UplodeVerifyDocumentsPage> createState() => _UplodeVerifyDocumentsPageState();
}

class _UplodeVerifyDocumentsPageState extends State<UplodeVerifyDocumentsPage> {
  final List<String> _qualificationDocuments = ['Education Degree'];
  final List<String> _certificateDocuments = ['Certificate 1', 'Certificate 2'];

  void _uploadDocument(String category) {
    setState(() {
      if (category == 'Qualification') {
        _qualificationDocuments.add('New Qualification ${_qualificationDocuments.length + 1}');
      } else if (category == 'Certificates') {
        _certificateDocuments.add('New Certificate ${_certificateDocuments.length + 1}');
      }
    });
  }

  void _removeDocument(String category, int index) {
    setState(() {
      if (category == 'Qualification') {
        _qualificationDocuments.removeAt(index);
      } else if (category == 'Certificates') {
        _certificateDocuments.removeAt(index);
      }
    });
  }

  void _showDetailsSubmittedBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppConstants.spacingExtraLarge * 2),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ✅ Icon Container
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),

                          child: Container(
                            height: 150,
                            decoration: const BoxDecoration(
                              color: Color(0xffe2eafb),
                              borderRadius: BorderRadius.only(
                                // topLeft: Radius.circular(32),
                                // topRight: Radius.circular(32),
                                bottomRight:  Radius.circular(30),bottomLeft:  Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.verified_outlined,
                                    color: Color(0xff0842a0),
                                    size: 38,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ✅ Text and Button Section
                        Padding(
                          padding: const EdgeInsets.all(AppConstants.paddingLarge),
                          child: Column(
                            children: [
                              const Text(
                                'Details Submitted',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0842a0),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppConstants.spacingSmall),
                              const Text(
                                'Your details are submitted to the Admin for verification, once your details are been verified, we will update you.',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontSize: 14,
                                  color: Color(0xff828282),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppConstants.spacingExtraLarge),
                              // ✅ Okay Button
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const BottomNavigationPage()),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0a0a3c),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Okay',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Verify Documents',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primary1,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              'Please provide us your valid Documentation so that we can verify you as Mentor',
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: AppConstants.spacingExtraLarge),

            _buildDocumentSection('Qualification', Icons.description_outlined, _qualificationDocuments),
            const SizedBox(height: AppConstants.spacingMedium),
            _buildDocumentSection('Certificates', Icons.description_outlined, _certificateDocuments),
            const SizedBox(height: AppConstants.spacingMedium),
            _buildMultiLineInputField('Write your Qualifications\n(Max 300 words)', Icons.description_outlined),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const BankDetailsPage()),
                // );

                _showDetailsSubmittedBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: AppColors.primary1,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
                textStyle: const TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Submit'),
                  SizedBox(width: AppConstants.spacingSmall),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + AppConstants.spacingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentSection(String category, IconData leadingIcon, List<String> documents) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.roundbg,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.text,
                  shape: BoxShape.circle,
                ),
                child: Icon(leadingIcon, color: AppColors.white, size: AppConstants.iconSizeMedium),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              Expanded(
                child: Text(
                  category,
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontSize: 16,
                    color: AppColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () => _uploadDocument(category),
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                    vertical: AppConstants.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary1.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add_circle_outline, size: AppConstants.iconSizeSmall, color: AppColors.primary1),
                      SizedBox(width: 6),
                      Text(
                        'Upload',
                        style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary1,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (documents.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppConstants.paddingSmall),
              child: Column(
                children: documents.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String docName = entry.value;
                  return _buildUploadedDocumentItem(docName, () => _removeDocument(category, idx));
                }).toList(),
              ),
            ),

          SizedBox(height: 30,),


        ],
      ),
    );
  }

  Widget _buildUploadedDocumentItem(String fileName, VoidCallback onRemove) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffccdaf2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined, color: AppColors.grey, size: AppConstants.iconSizeSmall),
          const SizedBox(width: AppConstants.spacingSmall),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                fontFamily: 'BeVietnamPro',
                fontSize: 16,
                color: AppColors.text,
              ),
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.delete_outline_rounded, color: AppColors.grey, size: AppConstants.iconSizeMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiLineInputField(String hintText, IconData suffixIcon) {
    return TextField(
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16, color: AppColors.text),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.roundbg,
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16, color: AppColors.grey),
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
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingMedium,
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: AppConstants.paddingMedium),
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(suffixIcon, color: AppColors.grey, size: AppConstants.iconSizeMedium),
        ),
      ),
    );
  }
}
