import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/util/fade_on_scroll.dart';
import '../../../../core/util/add_helper.dart';
import '../logic/news_notifier.dart';
import '../widgets/admob_banner_add.dart';
import '../widgets/placeholder.dart';
import 'main_home_page.dart';

class PostPage extends StatelessWidget {
  final int postId;
  const PostPage(this.postId, {super.key});

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
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      title: FadeOnScroll(
                          fullOpacityOffset: 180,
                          scrollController: scrollController,
                          child: const AppBarTitle()),
                      background: Consumer(builder: (_, WidgetRef ref, __) {
                        final postProvider =
                            ref.watch(postNotifierProvider(postId));
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
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Colors.red,
                                                        BlendMode.colorBurn)),
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
                final postProvider = ref.watch(postNotifierProvider(postId));
                return Container(
                  child: postProvider.when(data: ((data) {
                    return SingleChildScrollView(
                      child: Html(
                        data: data.content!.rendered
                            .toString()
                            .replaceAll("\n", ""),
                        style: {
                          "table": Style(
                            backgroundColor:
                                const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
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
                          if (!await launchUrl(Uri.parse(
                              url ?? 'https://www.timesofkashmir.in/'))) {
                            Toast.show("Couldn't launch the url",
                                duration: Toast.lengthShort,
                                gravity: Toast.bottom);
                          }
                        },
                        onImageTap: (src, _, __, ___) async {},
                        onImageError: (exception, stackTrace) {},
                        onCssParseError: (css, messages) {
                          return "css error";
                        },
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
