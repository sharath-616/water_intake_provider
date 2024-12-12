import 'package:flutter/material.dart';

class CustomTextWidgets extends StatelessWidget {
  final String text;
  final Color? clr;
  final double? fs;
  final double? lp;
  final FontWeight? fw;
  const CustomTextWidgets({super.key, required this.text, this.clr, this.fs, this.lp, this.fw});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: clr,
        fontSize: fs,
        fontWeight: fw,
        letterSpacing: lp,
      ),
    );
  }
}
