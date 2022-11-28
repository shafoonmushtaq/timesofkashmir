import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final double width, height;
  final String path;
  const SvgIcon(
      {super.key, required this.path, this.width = 50, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 2.5, left: 0),
      child: SvgPicture.asset(
        path,
        width: width,
        height: height,
      ),
    );
  }
}
