import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class SelectLanguagePopUp extends StatefulWidget {
  const SelectLanguagePopUp({super.key});

  @override
  State<SelectLanguagePopUp> createState() => _SelectLanguagePopUpState();
}

class _SelectLanguagePopUpState extends State<SelectLanguagePopUp> {
  String _selectedLangCode = Get.locale?.languageCode ?? 'en';

  void _onLanguageTap(String code) {
    setState(() {
      _selectedLangCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: FractionallySizedBox(
          heightFactor: 0.50,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF03002F),
                      radius: 16,
                      child: UIHelper.customSvg(
                        svg: "session-svg-icon.svg",
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    UIHelper.boldText(
                      text: 'Select Language',
                      fontSize: 14,
                      color: AppColors.text,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                /// Language List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildLanguageTile(
                          flagPath: 'assets/images/uk_flag.png',
                          label: 'English',
                          langCode: 'en',
                        ),
                        const SizedBox(height: 12),
                        _buildLanguageTile(
                          flagPath: 'assets/images/uk_flag.png',
                          label: 'हिन्दी',
                          langCode: 'hi',
                        ),
                        const SizedBox(height: 12),
                        _buildLanguageTile(
                          flagPath: 'assets/images/uk_flag.png',
                          label: 'ગુજરાતી',
                          langCode: 'gu',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Bottom Buttons
                Row(
                  children: [
                    IconButton(
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFCEDBF1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: UIHelper.customSvg(svg: "cancalled-icon-svg.svg"),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF03002F),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        onPressed: () {
                          // Save language and close
                          Get.updateLocale(Locale(_selectedLangCode));
                          Get.back();
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BeVietnamPro',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile({
    required String flagPath,
    required String label,
    required String langCode,
  }) {
    final bool isSelected = _selectedLangCode == langCode;

    return GestureDetector(
      onTap: () => _onLanguageTap(langCode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD6E4FF) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.blue, width: 1.5) : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage(flagPath),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'BeVietnamPro',
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, size: 18, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
