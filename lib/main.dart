import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:timesofkashmir/core/util/configurations.dart';
import 'package:timesofkashmir/core/util/firebase_helper.dart';
import 'package:timesofkashmir/core/util/one_signal_helper.dart';
import 'package:timesofkashmir/features/news/presentation/pages/splash.dart';

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
    MaterialColor createMaterialColor(Color color) {
      List strengths = <double>[.05];
      Map<int, Color> swatch = {};
      final int r = color.red, g = color.green, b = color.blue;

      for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
      for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
      return MaterialColor(color.value, swatch);
    }

    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Times of Kashmir',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xff1976D2)),
        textTheme: GoogleFonts.ubuntuTextTheme(textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}
