import 'package:flutter/material.dart';

class UpSlideBanner extends StatefulWidget {
  @override
  State<UpSlideBanner> createState() => _UpSlideBannerState();
}

class _UpSlideBannerState extends State<UpSlideBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Our Recommendation',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800),
          ),
          Container(
            width: 70,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  'View all',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
