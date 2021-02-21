import 'dart:ui';

import 'package:e_commerce/app/styles/font_style.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * 0.65,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/image_1.jpeg'),
            // image: NetworkImage(
            //   'https://cdn.shopify.com/s/files/1/0412/0133/6481/files/IMG_0229_900x900.jpg',
            // ),
          ),
        ),
        child: Visibility(
          visible: showText,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                alignment: Alignment.center,
                child: Text(
                  'CHOCOLATE',
                  style: fontTitle(context, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        //
      },
      onHover: (hover) => setState(() => showText = hover),
    );
  }
}
