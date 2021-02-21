import 'package:e_commerce/app/components/generate_form/generate_form.dart';
import 'package:e_commerce/app/modules/company/dashboard/components/card_page/card_page.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool createNewItem = false, updateItem = false;

  dynamic form;

  @override
  void initState() {
    super.initState();
    form = {
      "fields": [
        {
          "field": "title",
          "type": "textField",
          "title": "Título",
        },
        {
          "field": "message",
          "type": "textArea",
          "title": "Mensagem",
        },
        {
          "field": "topic",
          "type": "spinner",
          "title": "Tópico",
          "message": "Escolha uma opção",
          "values": [
            {
              "title": "Todos clientes",
              "value": kIsWeb
                  ? "com.navan.kideliver-android"
                  : "com.navan.kideliver-android",
            },
            {
              "title": "Todos usuários",
              "value": "ALL",
            }
          ],
        },
        {
          "type": "button",
          "title": "Testar notificação",
          "validateRequired": true,
          "alignment": Alignment.center,
          "action": (data) {
            print("Result");
          },
        },
        {
          "type": "button",
          "title": "Salvar",
          "validateRequired": true,
          "alignment": Alignment.center,
          "action": (data) {
            print("Result");
            print(data);
          },
        }
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardPage(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nova notificação",
                        style: fontTitle(context),
                      ),
                      // PrimaryButton(
                      //   text: createNewItem || updateItem
                      //       ? "Cancelar"
                      //       : "Adicionar",
                      //   onPressed: () {
                      //     setState(() {
                      //       if (createNewItem) {
                      //         createNewItem = false;
                      //       } else if (updateItem) {
                      //         updateItem = false;
                      //       } else {
                      //         createNewItem = true;
                      //       }
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
                GenerateForm(
                  fields: form,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
