
import 'package:flutter/material.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';


class Senderloder extends StatelessWidget {
  final String loder;
  const Senderloder({Key? key, required this.loder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: UIHelper.customImage(img: loder, height: 30, width: 70),
    );
  }
}
