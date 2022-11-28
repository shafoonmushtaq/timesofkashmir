import 'package:flutter/material.dart';
import 'package:timesofkashmir/core/util/environment.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/app_bar_title.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/web_widget.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "About us",
        ),
      ),
      body: const WebPage(url: aboutUs),
    );
  }
}
