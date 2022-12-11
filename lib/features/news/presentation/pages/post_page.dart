import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/util/url_launcher.dart';
import '/features/news/presentation/pages/news_home_page.dart';
import '/features/news/presentation/widgets/admob_inline_banner.dart';
import '/features/news/presentation/widgets/app_bar_title.dart';
import 'package:toast/toast.dart';
import '/core/util/fade_on_scroll.dart';
import '/core/util/add_helper.dart';
import '/features/news/presentation/logic/news_notifier.dart';
import '/features/news/presentation/widgets/admob_banner_add.dart';
import '/features/news/presentation/widgets/placeholder.dart';
import '/features/news/presentation/pages/main_home_page.dart';

class PostPage extends ConsumerStatefulWidget {
  final int postId;
  const PostPage(this.postId, {super.key});

  @override
  ConsumerState<PostPage> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  InterstitialAd? _interstitialAd;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
            ref.read(addStateProvider.notifier).state = 0;
            ad.dispose();
          }, onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
            ad.dispose();
          });

          setState(() {
            _interstitialAd = ad;
          });
          _showInterstitialAd();
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print('Failed to load an interstitial ad: ${err.message}');
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    super.initState();
    final addProvider = ref.read(addStateProvider);
    if (addProvider == 4) {
      if (kDebugMode) {
        print("loadingloadInterstitialAd");
      }
      _loadInterstitialAd();
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: ((context) {
                            return const HomeView();
                          })));
                        },
                        icon: const Icon(Icons.arrow_back)),
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      title: FadeOnScroll(
                          fullOpacityOffset: 50,
                          scrollController: scrollController,
                          child: const AppBarTitle()),
                      background: Consumer(builder: (_, WidgetRef ref, __) {
                        final postProvider =
                            ref.watch(postNotifierProvider(widget.postId));
                        return postProvider.when(
                          data: (data) {
                            return data.jetpackFeaturedMediaUrl == null ||
                                    data.jetpackFeaturedMediaUrl!.isEmpty
                                ? const PlaceHolderImage()
                                : CachedNetworkImage(
                                    imageUrl:
                                        data.jetpackFeaturedMediaUrl.toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        const PlaceHolderImage(),
                                    errorWidget: (context, url, error) =>
                                        const PlaceHolderImage());
                          },
                          error: (Object error, StackTrace stackTrace) {
                            return const PlaceHolderImage();
                          },
                          loading: () {
                            return const PlaceHolderImage();
                          },
                        );
                      }),
                    ),
                  ),
                ];
              },
              body: Consumer(builder: (context, ref, _) {
                final postProvider =
                    ref.watch(postNotifierProvider(widget.postId));
                return Container(
                  child: postProvider.when(data: ((data) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const InlineBanner(),
                          Html(
                            data: data.content!.rendered
                                .toString()
                                .replaceAll("\n", ""),
                            style: {
                              "table": Style(
                                backgroundColor: const Color.fromARGB(
                                    0x50, 0xee, 0xee, 0xee),
                              ),
                              "tr": Style(
                                border: const Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                              "th": Style(
                                padding: const EdgeInsets.all(6),
                                backgroundColor: Colors.grey,
                              ),
                              "td": Style(
                                padding: const EdgeInsets.all(6),
                                alignment: Alignment.topLeft,
                              ),
                              'h1': Style(
                                fontSize: const FontSize(15.0),
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              'h2': Style(
                                fontSize: const FontSize(13.0),
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              'h3': Style(
                                fontSize: const FontSize(12.0),
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              'h4': Style(
                                fontSize: const FontSize(10.0),
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            },
                            customRender: {
                              "table": (context, child) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: (context.tree as TableLayoutElement)
                                      .toWidget(context),
                                );
                              },
                            },
                            onLinkTap: (url, _, __, ___) async {
                              UrlLauncher.urllaunch(url.toString());
                            },
                            onImageTap: (src, _, __, ___) async {},
                            onImageError: (exception, stackTrace) {},
                            onCssParseError: (css, messages) {
                              return "css error";
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    );
                  }), error: ((error, stackTrace) {
                    return const Center(
                        child:
                            Text("Something went wrong, please try again !"));
                  }), loading: (() {
                    return const Center(child: CircularProgressIndicator());
                  })),
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BannerAdd(
              bannerAdUnitId: AdHelper.bannerAdUnitId,
            ),
          )
        ],
      ),
    );
  }
}
