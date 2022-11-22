// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:timesofkashmir/features/news/presentation/logic/news_notifier.dart';

import 'news_home_page.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  late FancyDrawerController _controller;

  @override
  void initState() {
    super.initState();
    // // "ref" can be used in all life-cycles of a StatefulWidget.
    // ref.read(counterProvider);
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {}); // Must call setState
      }); // This chunk of code is important
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We can also use "ref" to listen to a provider inside the build method
    final catProvider = ref.watch(categoryNotifierProvider);
    return SafeArea(
      child: Scaffold(
          body: catProvider.when(data: (categories) {
        return DefaultTabController(
          length: categories.length,
          child: FancyDrawerWrapper(
            backgroundColor: Colors.white,
            drawerItems: const [
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About Us"),
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text("Terms of Use"),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text("Privacy Policy"),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text("Contact Us"),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text("Advertise with Us"),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share App"),
              ),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text("Rate App"),
              )
            ], // Drawer items
            controller: _controller,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _controller.open();
                  },
                ),
                actions: [
                  SizedBox(
                      width: 30,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search))),
                  SizedBox(
                      width: 30,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.notifications))),
                  SizedBox(
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.category)))
                ],
                title: AppBarTitle(),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: categories
                      .map((tabName) =>
                          Tab(child: Text(tabName.name.toString())))
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: categories
                    .map((e) => NewsHomePage(categoryId: e.id ?? 123))
                    .toList(),
              ),
            ),
          ),
        );
      }, error: ((error, stack) {
        return Center(
          child: Text(error.toString()),
        );
      }), loading: () {
        return Center(child: const CircularProgressIndicator());
      })),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      "Times of Kashmir",
      maxLines: 1,
      minFontSize: 14,
      maxFontSize: 18,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.ptSerif(
        textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 0.8,
            fontStyle: FontStyle.normal),
      ),
    );
  }
}
