// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:timesofkashmir/features/news/presentation/logic/news_notifier.dart';

import '../widgets/news_item.dart';
import 'news_home_page.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
          body: catProvider.when(initial: () {
        return null;
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      }, data: (categories) {
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
                title: AutoSizeText(
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
                ),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: categories
                      .map((tabName) =>
                          Tab(child: Text(tabName.name.toString())))
                      .toList(),
                ),
              ),
              body: SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                header: const WaterDropMaterialHeader(
                  backgroundColor: Colors.blue,
                ),
                physics: const BouncingScrollPhysics(),
                footer: const ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                  completeDuration: Duration(milliseconds: 500),
                ),
                onRefresh: () async {
                  // monitor network fetch
                  ref.refresh(categoryNotifierProvider);
                  await Future.delayed(const Duration(milliseconds: 1000));
                  // if failed,use refreshFailed()
                  _refreshController.refreshCompleted();
                },
                child: TabBarView(
                  children: categories
                      .map((e) => NewsHomePage(categoryId: e.id))
                      .toList(),
                ),
              ),
            ),
          ),
        );
      }, error: ((error) {
        return Center(
          child: Text(error.toString()),
        );
      }))),
    );
  }
}
