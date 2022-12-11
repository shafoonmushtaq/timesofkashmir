import 'package:flutter/material.dart';
import '/features/news/presentation/widgets/app_bar_title.dart';
import '/features/news/presentation/widgets/web_widget.dart';

import '/core/util/environment.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Contact us",
        ),
      ),
      body: const WebPage(url: contact),
    );
  }
}
