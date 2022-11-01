// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/news_notifier.dart';
import '../widgets/news_item.dart';

class NewsHomePage extends ConsumerWidget {
  final ScrollController scrollController = ScrollController();
  final categoryId;
  NewsHomePage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        print("dd");
      }
    });
    final newsNotiferProvider = ref.watch(newsNotifierProvider(categoryId));
    return Center(
      child: newsNotiferProvider.when(initial: (() {
        return Container();
      }), loading: () {
        return const CircularProgressIndicator();
      }, data: ((news) {
        return Container(
          color: const Color(0xff1976D2),
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                if (index == news.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                        child: Text("Load more".toUpperCase(),
                            style: const TextStyle(fontSize: 14)),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.white)))),
                        onPressed: () {
                          ref
                              .read(newsNotifierProvider(categoryId).notifier)
                              .getPosts();
                        }),
                  );
                }
                return Container(
                  margin: EdgeInsets.only(
                      left: 7,
                      right: 7,
                      top: index == 0 ? 7 : 2.5,
                      bottom: 2.5),
                  child: NewsItem(
                      imgIcon: news[index].jetpackFeaturedMediaUrl,
                      title: news[index].title!.rendered.toString(),
                      date: news[index].date),
                );
              }),
              itemCount: news.length + 1),
        );
      }), error: ((error) {
        return Container();
      })),
    );
  }
}
