
import 'package:flutter/material.dart';

import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';

class ReceiverMessage extends StatelessWidget {
  final String message, time;
  const ReceiverMessage({required this.message, required this.time, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 270,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFDCE1EB),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UIHelper.mediumText(text: "you", fontSize: 10, color: AppColors.textblue, fontWeight: FontWeight.w600),
                UIHelper.regularText(text: time, fontSize: 10, color: AppColors.grey),
              ],
            ),
            const SizedBox(height: 6),
            UIHelper.mediumText(text: message, fontSize: 14, color: AppColors.text,),
            //Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
