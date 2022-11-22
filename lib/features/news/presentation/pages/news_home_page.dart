import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:timesofkashmir/features/news/presentation/pages/post_page.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/news_item_shimmer.dart';

import '../../../../core/util/add_helper.dart';
import '../logic/news_notifier.dart';
import '../widgets/admob_banner_add.dart';
import '../widgets/news_item.dart';

// 1. extend [ConsumerStatefulWidget]
class NewsHomePage extends ConsumerStatefulWidget {
  final int categoryId;
  const NewsHomePage({required this.categoryId, super.key});

  @override
  ConsumerState<NewsHomePage> createState() => _NewsHomePageState();
}

// 2. extend [ConsumerState]
class _NewsHomePageState extends ConsumerState<NewsHomePage> {
  InterstitialAd? _interstitialAd;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.pop(context);
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print('Failed to load an interstitial ad: ${err.message}');
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsNotiferProvider =
        ref.watch(newsNotifierProvider(widget.categoryId));
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: newsNotiferProvider.when(data: ((news) {
            return Container(
              color: const Color(0xff1976D2),
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge) {
                    bool isTop = metrics.pixels == 0;
                    if (isTop) {
                    } else {
                      ref
                          .read(
                              newsNotifierProvider(widget.categoryId).notifier)
                          .getPosts();
                    }
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    // monitor network fetch
                    ref.refresh(newsNotifierProvider(widget.categoryId));
                  },
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        if (index == news.length) {
                          return Container(
                              margin: EdgeInsets.only(
                                  left: 7,
                                  right: 7,
                                  top: index == 0 ? 7 : 2.5,
                                  bottom: 5),
                              child: const NewsItemShimmer());
                        }
                        return Container(
                          margin: EdgeInsets.only(
                              left: 7,
                              right: 7,
                              top: index == 0 ? 7 : 2.5,
                              bottom: 2.5),
                          child: NewsItem(
                              onClick: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return PostPage(news[index].id ?? 12);
                                }));
                              },
                              imgIcon:
                                  news[index].jetpackFeaturedMediaUrl ?? "",
                              title: news[index].title!.rendered.toString(),
                              date: news[index].date ?? ""),
                        );
                      }),
                      itemCount:
                          news.length >= 20 ? news.length + 1 : news.length),
                ),
              ),
            );
          }), error: ((error, stack) {
            return const Center(child: Text("Something went wrong..!"));
          }), loading: () {
            return const Center(child: CircularProgressIndicator());
          }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BannerAdd(
            bannerAdUnitId: AdHelper.bannerAdUnitId,
          ),
        )
      ],
    );
  }
}
