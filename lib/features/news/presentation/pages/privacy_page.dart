import 'package:flutter/material.dart';
import '/features/news/presentation/widgets/app_bar_title.dart';
import '/features/news/presentation/widgets/web_widget.dart';

import '/core/util/environment.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Privacy",
        ),
      ),
      body: const WebPage(url: privacyPolicy),
    );
  }
}
