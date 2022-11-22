import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsItemShimmer extends StatelessWidget {
  const NewsItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
