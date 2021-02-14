import 'package:e_commerce/app/styles/font_style.dart';
import 'package:e_commerce/app/utils/strings/strings.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;
  VoidCallback onTap;

  //var auth = Get.find<AuthService>();

  CustomAppBar({
    @required this.child,
    this.height = 70, // kToolbarHeight,
    this.onTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor,
      child: appBarHome(context),
    );
  }

  Widget appBarHome(context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                child: Text(
                  APP_NAME,
                  style: fontTitle(context, size: 30, bold: true),
                ),
                onTap: () {
                  // setState(() {
                  //   selectedPage = 0;
                  //   categoryIndex = 0;
                  //   menuIndex = 0;
                  // });
                },
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                padding: EdgeInsets.symmetric(horizontal: 20),
                tooltip: 'Pesquisar',
                onPressed: () {
                  //
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle, color: Colors.black),
                padding: EdgeInsets.symmetric(horizontal: 20),
                tooltip: 'Pesquisar',
                onPressed: () {
                  //
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ],
      ),
    );
  }
}
