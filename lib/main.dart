import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/util/configurations.dart';
import 'core/util/firebase_helper.dart';
import 'core/util/one_signal_helper.dart';
import 'features/news/presentation/pages/splash.dart';
import 'core/util/color_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  FirebaseHelper().initializeFirebaseUtility();
  await OneSignalHelper(oneSignalId).initOneSignalUtility();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ["4D7ADA20A7C2C778AB12B3A1AE1DEC3D"]));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: MaterialColorGenerator()
            .createMaterialColor(const Color(0xff1976D2)),
        textTheme: GoogleFonts.ubuntuTextTheme(textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}
