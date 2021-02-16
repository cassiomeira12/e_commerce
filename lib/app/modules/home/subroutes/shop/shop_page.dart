import 'package:e_commerce/app/modules/home/components/copyrigth.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../home_controller.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final controller = Get.put(HomeController());

  List<dynamic> menuItems;

  @override
  void initState() {
    super.initState();
    menuItems = [
      {
        'value': 'Lançamentos',
      },
      {
        'value': 'Camisetas',
      },
      {
        'value': 'Casacos',
      },
      {
        'value': 'Jaquetas',
      },
      {
        'value': 'Calças',
      },
      {
        'value': 'Acessórios',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          children: menuItems.asMap().entries.map((e) {
            return FlatButton(
              child: Text(
                e.value['value'].toUpperCase(),
                style: fontSubtitle(context, size: 15, bold: false),
              ),
              onPressed: () {
                //
              },
            );
          }).toList(),
        ),
        Expanded(child: body()),
      ],
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              // left: MediaQuery.of(context).size.width > 1000
              //     ? MediaQuery.of(context).size.width * .1
              //     : MediaQuery.of(context).size.width > 700
              //         ? 4
              //         : MediaQuery.of(context).size.width > 600
              //             ? 3
              //             : 2,
              // right: MediaQuery.of(context).size.width > 1000
              //     ? MediaQuery.of(context).size.width * .1
              //     : MediaQuery.of(context).size.width > 700
              //         ? 4
              //         : MediaQuery.of(context).size.width > 600
              //             ? 3
              //             : 2,
            ),
            child: GridView.builder(
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 1000
                    ? 5
                    : MediaQuery.of(context).size.width > 700
                        ? 4
                        : MediaQuery.of(context).size.width > 600
                            ? 3
                            : 2,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://cdn.shopify.com/s/files/1/0412/0133/6481/products/SHERPAJACKET-GREEN_600x600.jpg',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          CopyRigth(),
        ],
      ),
    );
  }
}
