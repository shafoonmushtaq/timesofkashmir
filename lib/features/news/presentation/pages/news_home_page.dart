import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesofkashmir/core/util/environment.dart';
import 'package:timesofkashmir/features/news/presentation/pages/post_page.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/news_item_shimmer.dart';

import 'package:timesofkashmir/core/util/add_helper.dart';
import 'package:timesofkashmir/features/news/presentation/logic/news_notifier.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/admob_banner_add.dart';
import 'package:timesofkashmir/features/news/presentation/widgets/news_item.dart';

final addStateProvider = StateProvider<int>((ref) {
  return 0;
});

// 1. extend [ConsumerStatefulWidget]
class NewsHomePage extends ConsumerStatefulWidget {
  final int categoryId;
  const NewsHomePage({required this.categoryId, super.key});

  @override
  ConsumerState<NewsHomePage> createState() => _NewsHomePageState();
}

// 2. extend [ConsumerState]
class _NewsHomePageState extends ConsumerState<NewsHomePage> {
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
                  child: CustomScrollView(slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                              ref.read(addStateProvider.notifier).state++;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return PostPage(news[index].id ?? 12);
                              }));
                            },
                            imgIcon: news[index].jetpackFeaturedMediaUrl ?? "",
                            title: news[index].title!.rendered.toString(),
                            date: news[index].date ?? "",
                            link: news[index].link ?? baseUrl,
                          ),
                        );
                      },
                      childCount:
                          news.length >= 20 ? news.length + 1 : news.length,
                    )),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 50),
                    )
                  ]),
                ),
              ),
            );
          }), error: ((error, stack) {
            return RefreshIndicator(
                onRefresh: () async {
                  // monitor network fetch
                  ref.refresh(newsNotifierProvider(widget.categoryId));
                },
                child: const CustomScrollView(slivers: [
                  SliverFillRemaining(
                    child: Center(child: Text("Something went wrong..!")),
                  )
                ]));
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
