import 'package:e_commerce/app/components/card/card_page.dart';
import 'package:flutter/material.dart';

class PaymentTypesPage extends StatefulWidget {
  @override
  _PaymentTypesPageState createState() => _PaymentTypesPageState();
}

class _PaymentTypesPageState extends State<PaymentTypesPage> {
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
