import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarWrapper extends StatelessWidget {
  final Widget child;

  const StatusBarWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // final SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    //   statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    // );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // value: overlayStyle,
      value: SystemUiOverlayStyle.light.copyWith( // black icons
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent, // background of status bar
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: SafeArea(
        top: true,
        child: child,
      ),
    );
  }
}
