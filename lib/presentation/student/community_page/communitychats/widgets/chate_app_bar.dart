
import 'package:flutter/material.dart';

import '../../../../../utils/ui_helper.dart';


class CustomAppBarRow extends StatelessWidget {
  const CustomAppBarRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          UIHelper.customImage(img: "gp-cht-ser.png", width: 55, height: 55),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Mathematic Heads",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text("80 Members", style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const Spacer(),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFCDD6E9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: UIHelper.customImage(img: "user-profiel-seting.png", height: 20, width: 20),
            ),
          ),
        ],
      ),
    );
  }
}
