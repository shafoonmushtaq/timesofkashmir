import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:timesofkashmir/core/util/configurations.dart';

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          appTitle,
          style: GoogleFonts.ptSerif(
            textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 0.8,
                fontStyle: FontStyle.normal),
          ),
        ),
      ),
    );
  }
}
