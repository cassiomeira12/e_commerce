import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductWidget extends StatefulWidget {
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool showImagens = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://cdn.shopify.com/s/files/1/0412/0133/6481/products/SHERPAJACKET-GREEN_600x600.jpg',
                  ),
                ),
              ),
            ),
          ),
          showImagens
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://cdn.shopify.com/s/files/1/0412/0133/6481/products/SHERPAJACKET-GREEN_600x600.jpg',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://cdn.shopify.com/s/files/1/0412/0133/6481/products/SHERPAJACKET-GREEN_600x600.jpg',
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(height: 40),
        ],
      ),
      onTap: () {
        Get.toNamed('/home/product');
      },
      onHover: (hover) => setState(() => showImagens = hover),
    );
  }
}
