import 'package:e_commerce/app/components/card/card_page.dart';
import 'package:flutter/material.dart';

class PhoneContactPage extends StatefulWidget {
  @override
  _PhoneContactPageState createState() => _PhoneContactPageState();
}

class _PhoneContactPageState extends State<PhoneContactPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardPage(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
