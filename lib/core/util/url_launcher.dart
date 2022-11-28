import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static urllaunch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      Toast.show("Couldn't launch the url",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    }
  }
}
