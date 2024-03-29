import 'package:flutter/material.dart';

containerUtils(
    {Widget? child,
    Duration? duration,
    Curve? curve,
    double? height,
    double? width,
    Alignment? alignment,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? borderColor,
    Color? color,
    BoxShape? shape,
    double? borderRadius}) {
  return duration != null
      ? AnimatedContainer(
          duration: duration,
          curve: curve ?? Curves.linear,
          margin: margin,
          height: height,
          width: width,
          alignment: alignment,
          padding: padding,
          decoration: BoxDecoration(
            border: borderColor != null ? Border.all(color: borderColor) : null,
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius)
                : null,
            shape: shape ?? BoxShape.rectangle,
            color: color,
          ),
          child: child,
        )
      : Container(
          margin: margin,
          height: height,
          width: width,
          alignment: alignment,
          padding: padding,
          decoration: BoxDecoration(
            border: borderColor != null ? Border.all(color: borderColor) : null,
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius)
                : null,
            color: color,
          ),
          child: child,
        );
}
