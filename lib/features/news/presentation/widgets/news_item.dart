// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatelessWidget {
  final imgIcon, title, date;
  const NewsItem(
      {super.key,
      required this.imgIcon,
      required this.title,
      required this.date});

  @override
  Widget build(BuildContext context) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);
    return Container(
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
                style: const TextStyle(color: Color(0xffba1f1f), fontSize: 11),
              ),
              SizedBox(
                height: 25,
                child: IconButton(
                    onPressed: () {},
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
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                    height: 45,
                    width: 45,
                    child: Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(),
                    )),
                errorWidget: (context, url, error) => SizedBox(
                  height: 45,
                  width: 45,
                  child: Icon(Icons.image),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: AutoSizeText(
                  title,
                  maxLines: 2,
                  minFontSize: 12,
                  maxFontSize: 15,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black87, fontSize: 13),
                  softWrap: true,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
