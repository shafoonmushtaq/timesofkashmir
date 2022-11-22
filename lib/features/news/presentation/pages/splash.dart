import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timesofkashmir/features/news/domain/entities/category.dart';
import 'package:timesofkashmir/features/news/presentation/pages/main_home_page.dart';
import '../logic/news_notifier.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catProvider = ref.watch(categoryNotifierProvider);
    ref.listen<AsyncValue<List<Category>>>(categoryNotifierProvider, (a, b) {
      b.map(
          loading: ((value) {}),
          data: ((value) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: ((context) {
              return const HomeView();
            })));
          }),
          error: ((value) {}));
    });
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Times of Kashmir",
            style: GoogleFonts.ptSerif(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 0.8,
                  fontStyle: FontStyle.normal),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          catProvider.when(loading: (() {
            return const CircularProgressIndicator();
          }), data: ((category) {
            return Container();
          }), error: ((error, stack) {
            return const Text("Something went wrong, please try again.");
          }))
        ],
      )),
    );
  }
}
