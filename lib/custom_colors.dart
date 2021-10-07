import 'dart:ui';
import 'package:flutter/material.dart';

class CustomColors {
  Color whiteText = Color(0xFFFFFFFF);
  Color blackText = Color(0xFF000000);

  static var background = Color(0xFFebebeb);
  static var shade = Color(0xFFD3D3D3);
  static var selected = Color(0xFFC64635);

  //
  CustomColors._privateConstructor();

  static final CustomColors instance = CustomColors._privateConstructor();

  //
  Color getTextColor(Color background) {
    var r = background.toString().substring(10, 12);
    var g = background.toString().substring(12, 14);
    var b = background.toString().substring(14, 16);
    
    var ri = int.parse(r, radix: 16);
    var gi = int.parse(g, radix: 16);
    var bi = int.parse(b, radix: 16);

    if ((ri + gi + bi) > 382) {
      return blackText;
    } else {
      return whiteText;
    }
  }
}