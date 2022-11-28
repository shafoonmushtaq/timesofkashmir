import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timesofkashmir/core/util/configurations.dart';

class AppBarTitle extends StatelessWidget {
  final double minFontSize, maxFontSize;
  final Color color;
  final String title;
  const AppBarTitle(
      {Key? key,
      this.minFontSize = 14,
      this.maxFontSize = 18,
      this.color = Colors.white,
      this.title = appTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      maxLines: 1,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.ptSerif(
        textStyle: TextStyle(
            color: color,
            fontSize: 18,
            letterSpacing: 0.8,
            fontStyle: FontStyle.normal),
      ),
    );
  }
}
