
import 'package:flutter/material.dart';

import '../../../../../utils/ui_helper.dart';

class SenderImageMessage extends StatelessWidget {
  final String sender, time;
  final List<String> imagePaths;
  const SenderImageMessage({required this.sender, required this.imagePaths, required this.time, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(top: 4, bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF2FF),
          borderRadius: BorderRadius.circular(20),
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
            Row(
              children: imagePaths
                  .map((path) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: UIHelper.customImage(
                    img: path,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ))
                  .toList(),
            ),

          ],
        ),
      ),
    );
  }
}
