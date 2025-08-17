import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../res/fonts/app_fonts.dart';

class UIHelper {

  // ---------------- Images ----------------

  static Widget customImage({required String img,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset("assets/images/$img",
      height: height,
      width: width,
      fit: fit,
    );
  }


  static Widget customImageOnTap({
    required String png,
    double? height,
    double? width,
    VoidCallback? onTap, // Optional tap handler
  }) {
    Widget pngWidget = Image.asset(
      "assets/images/$png",
      height: height,
      width: width,
    );

    return onTap != null
        ? GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: pngWidget,
    )
        : pngWidget;
  }


  static Widget customSvg({
    required String svg,
    BoxFit fit = BoxFit.contain,
    double? height,
    double? width,
    Color? color,
  }) {
    return SvgPicture.asset(
      "assets/svg/$svg",
      height: height,
      width: width,
      fit:fit,
      color: color,
    );
  }

  static Widget customSvgOnTap({
    required String svg,
    double? height,
    double? width,
    Color? color,
    VoidCallback? onTap, // Optional tap handler
  }) {
    Widget svgWidget = SvgPicture.asset(
      "assets/svg/$svg",
      height: height,
      width: width,
      color: color,
    );

    return onTap != null
        ? GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: svgWidget,
    )
        : svgWidget;
  }

  static Widget customNetworkImage({
    required String imageUrl,
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    bool isCircular = false,
  }) {
    final Widget image = Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            SizedBox(
              height: height,
              width: width,
              child: const Center(child: CircularProgressIndicator()),
            );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
              ),
              child: const Icon(Icons.error_outline, color: Colors.grey),
            );
      },
    );

    return isCircular
        ? ClipOval(child: image)
        : ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: image,
    );
  }



  // ---------------- Text ----------------

  static Widget customText({
    required String text,
    required Color color,
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    String fontFamily = 'BeVietnamPro',
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  static Widget regularText({
    required String text,
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    required Color color,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: AppFontStyles.beVietnamProRegular400.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  static Widget regularTextCenter({
    required String text,
    required double fontSize,
    required Color color,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: AppFontStyles.beVietnamProRegular400.copyWith(
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static Widget mediumText({
    required String text,
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.w500,
    TextAlign textAlign = TextAlign.start,
    TextDecoration? textDecoration,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: AppFontStyles.beVietnamProMedium500.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }

  static Widget semiBoldText({
    required String text,
    required double fontSize,
    required Color color,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: AppFontStyles.beVietnamProSemiBold600.copyWith(
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  static Widget boldText({
    required String text,
    required double fontSize,
    required Color color,
    FontStyle? fontstyle,
    FontWeight fontWeight = FontWeight.w700,
    TextAlign textAlign = TextAlign.start,
    int maxLines = 1,
    bool? softWrap,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      style: AppFontStyles.beVietnamProBold700.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontstyle,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static Widget boldTextCenter({
    required String text,
    required double fontSize,
    required Color color,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: AppFontStyles.beVietnamProBold700.copyWith(
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  // ---------------- Gradient Text ----------------

  static Widget gradientText({
    required String text,
    required double fontSize,
    required List<Color> gradientColors,
    FontWeight fontWeight = FontWeight.w700,
    TextAlign textAlign = TextAlign.center,
    String fontFamily = 'BeVietnamPro',
  }) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradientColors,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ),
      ),
    );
  }

  // ---------------- Container Utility ----------------

  static Widget roundedContainer({
    required Widget child,
    double radius = 20,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    Color bgColor = const Color(0xFFF8F8F8),
    List<BoxShadow>? boxShadow,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              )
            ],
      ),
      child: child,
    );
  }
}
