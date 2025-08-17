
import 'package:flutter/material.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';


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
                UIHelper.mediumText(text: "you", fontSize: 12, color: AppColors.textblue),
                UIHelper.mediumText(text: time, fontSize: 12, color: AppColors.textblue),
              ],
            ),
            const SizedBox(height: 6),
            Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
