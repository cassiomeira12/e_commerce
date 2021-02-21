import 'package:e_commerce/app/components/buttons/primary_button.dart';
import 'package:e_commerce/app/modules/home/components/copyrigth.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MediaQuery.of(context).size.width < 600 ? null : Container(),
        title: InkWell(
          child: Text(
            'Bite The Bullet',
            style: fontTitle(
              context,
              size: MediaQuery.of(context).size.width > 1000
                  ? 35
                  : MediaQuery.of(context).size.width > 700
                      ? 30
                      : MediaQuery.of(context).size.width > 600
                          ? 30
                          : 25,
            ),
          ),
          onTap: () {
            // setState(() {
            //   selectedPage = 0;
            //   categoryIndex = 0;
            //   menuIndex = 0;
            // });
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            padding: EdgeInsets.symmetric(horizontal: 20),
            tooltip: 'Pesquisar',
            onPressed: () {
              //
            },
          ),
          // Visibility(
          //   visible: MediaQuery.of(context).size.width > 600,
          //   child: IconButton(
          //     icon: ImageIcon(
          //       AssetImage('assets/images/ligh_mode.jpeg'),
          //     ),
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     tooltip: 'Tema',
          //     onPressed: () async {
          //       var pref = await SharedPreferences.getInstance();
          //       int index = pref.getInt('theme');
          //       index = index == null
          //           ? 1
          //           : index == 1
          //               ? 2
          //               : 1;
          //       pref.setInt("theme", index);
          //       Get.changeThemeMode(ThemeMode.values[index]);
          //     },
          //   ),
          // ),
          IconButton(
            icon: Icon(Icons.account_circle),
            padding: EdgeInsets.symmetric(horizontal: 20),
            tooltip: 'Entrar',
            onPressed: () {
              //
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 5,
        top: 50,
        bottom: 100,
        right: MediaQuery.of(context).size.width / 5,
      ),
      child: Wrap(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 400,
            height: 300,
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
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sobre o aSFASFAS",
                style: fontTitle(context),
              ),
              Text(
                "Sobre o aSFASFAS",
                style: fontTitle(context),
              ),
              Text(
                "R\$ 150,00",
                style: fontTitle(context),
              ),
              PrimaryButton(
                text: "Adicionar",
                onPressed: () {
                  //
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
