import 'package:e_commerce/app/modules/home/components/copyrigth.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_controller.dart';

class LorePage extends StatefulWidget {
  @override
  _LorePageState createState() => _LorePageState();
}

class _LorePageState extends State<LorePage> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 56,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            body(),
            CopyRigth(),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lore",
            style: fontTitle(context),
          ),
          SizedBox(height: 50),
          // Container(
          //   width: MediaQuery.of(context).size.width / 1.5,
          //   child: Text(
          //     "Escolha o plano ideal e aproveite os recursos para utilizar a nossa plataforma. Você pode cancelar a qualquer momento sem que seja cobrado taxas extras. Afinal, aqui nunca terá taxas extras! :)",
          //     style: fontMessage(context),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // SizedBox(height: 50),
          // CustomFutureBuilder(
          //   future: controller.listPlans(),
          //   builder: (context, snapshot) {
          //     List list = List.from(snapshot.data);
          //     return Wrap(
          //       alignment: WrapAlignment.center,
          //       crossAxisAlignment: WrapCrossAlignment.start,
          //       children: list.map((e) {
          //         return CustomCard(
          //           title: e['name'],
          //           message: e['description'],
          //           actionText: 'Assinar',
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),
          // SizedBox(height: 100),
        ],
      ),
    );
  }
}
