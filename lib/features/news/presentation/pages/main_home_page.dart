import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/util/configurations.dart';
import '/core/util/environment.dart';
import '/core/util/url_launcher.dart';
import '/features/news/presentation/logic/news_notifier.dart';
import '/features/news/presentation/pages/about_us_page.dart';
import '/features/news/presentation/pages/contact_page.dart';
import '/features/news/presentation/pages/disclaimer_page.dart';
import '/features/news/presentation/pages/privacy_page.dart';
import '/features/news/presentation/widgets/svg_icon.dart';
import '/features/news/presentation/widgets/app_bar_title.dart';
import '/features/news/presentation/pages/news_home_page.dart';

import '/core/util/text_share.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // // "ref" can be used in all life-cycles of a StatefulWidget.
    // ref.read(counterProvider);
  }

  @override
  void dispose() {
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
            child: Scaffold(
              backgroundColor: Colors.white,
              drawer: Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: const Color(0xff5BC6FA),
                          width: double.infinity,
                          height: 120,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Image.asset("assets/image/app_icon_.jpg"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    UrlLauncher.urllaunch(facebookUrl);
                                  },
                                  child: const SvgIcon(
                                      path: "assets/svg/fb_icon.svg")),
                              GestureDetector(
                                  onTap: () async {
                                    UrlLauncher.urllaunch(twitterUrl);
                                  },
                                  child: const SvgIcon(
                                      path: "assets/svg/twitter_icon.svg")),
                              const SvgIcon(
                                  path: "assets/svg/youtube_icon.svg"),
                              const SvgIcon(path: "assets/svg/insta_icon.svg")
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        )
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text("About Us"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return const AboutUs();
                        })));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip),
                      title: const Text("Privacy Policy"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return const PrivacyPage();
                        })));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.warning),
                      title: const Text("Disclaimer"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return const DisclaimerPage();
                        })));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text("Contact Us"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return const Contact();
                        })));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text("Share App"),
                      onTap: () {
                        Share.share(appTitle, appInfo, googlePlayUrl, appTitle);
                      },
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                actions: const [
                  //   SizedBox(
                  //       width: 30,
                  //       child: IconButton(
                  //           onPressed: () {}, icon: const Icon(Icons.search))),
                  //   SizedBox(
                  //       width: 30,
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(Icons.notifications))),
                  //   SizedBox(
                  //       child: IconButton(
                  //           onPressed: () {}, icon: const Icon(Icons.category)))
                ],
                title: const AppBarTitle(),
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
            ));
      }, error: ((error, stack) {
        return Center(
          child: Text(error.toString()),
        );
      }), loading: () {
        return const Center(child: CircularProgressIndicator());
      })),
    );
  }
}
