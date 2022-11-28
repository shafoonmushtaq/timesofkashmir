// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:timesofkashmir/core/util/html_remover.dart';

import '../../../../core/util/configurations.dart';
import '../../../../core/util/text_share.dart';

class NewsItem extends StatelessWidget {
  final String imgIcon, title, date, link;
  final Function onClick;
  const NewsItem(
      {super.key,
      required this.imgIcon,
      required this.title,
      required this.date,
      required this.link,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  maxLines: 1,
                  minFontSize: 8,
                  maxFontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  outputDate,
                  style:
                      const TextStyle(color: Color(0xffba1f1f), fontSize: 11),
                ),
                SizedBox(
                  height: 25,
                  child: IconButton(
                      onPressed: () {
                        Share.share(title, "", link, appTitle);
                      },
                      icon: Icon(
                        Icons.share,
                        size: 20,
                        color: Colors.black,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imgIcon,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                      height: 50,
                      width: 50,
                      child: Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(),
                      )),
                  errorWidget: (context, url, error) => SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.image),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: AutoSizeText(
                    HtmlProcess.parseHtmlString(title),
                    maxLines: 2,
                    minFontSize: 14,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87),
                    softWrap: true,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
