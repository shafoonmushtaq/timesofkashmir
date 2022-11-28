import 'package:flutter_share/flutter_share.dart';

class Share {
  static Future<void> share(title, text, link, chooserTitle) async {
    await FlutterShare.share(
        title: title, text: text, linkUrl: link, chooserTitle: chooserTitle);
  }
}
