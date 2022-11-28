import 'package:flutter/material.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/app_bar_title.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/web_widget.dart';

import '../../../../core/util/environment.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Disclaimer",
        ),
      ),
      body: const WebPage(url: disclaimer),
    );
  }
}
