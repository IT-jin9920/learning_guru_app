
import 'package:flutter/material.dart';

import '../../../../../utils/ui_helper.dart';

class SenderMessage extends StatelessWidget {
  final String sender, message, time;
  const SenderMessage({required this.sender, required this.message, required this.time, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
    Padding(
    padding: const EdgeInsets.only(bottom: 15,right: 10),
    child: UIHelper.customImage(img: "user-1.png", height: 32, width: 32),
    ), Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(top: 4, bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF2FF),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sender, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent)),
                Text(time, style: const TextStyle(fontSize: 10, color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 6),
            Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    ) ], );
  }
}
