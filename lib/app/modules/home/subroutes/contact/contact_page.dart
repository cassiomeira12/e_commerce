import 'package:e_commerce/app/components/generate_form/generate_form.dart';
import 'package:e_commerce/app/modules/home/components/copyrigth.dart';
import 'package:e_commerce/app/modules/home/subroutes/contact/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var controller = ContactController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          body(),
          CopyRigth(),
        ],
      ),
    );
  }

  Widget body() {
    return Container(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 20),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : GenerateForm(
                fields: {
                  "fields": [
                    {
                      "field": "name",
                      "title": "Nome",
                      "type": "textField",
                    },
                    {
                      "field": "phoneNumber",
                      "title": "Telefone",
                      "type": "textField",
                      "controller":
                          MaskedTextController(mask: '+55 00 0 00000000'),
                      "textInputType": TextInputType.number,
                      "validator": (String value) {
                        if (value.isEmpty || value.length < 17) {
                          return "Digite seu telefone";
                        }
                        return null;
                      },
                    },
                    {
                      "field": "subject",
                      "title": "Assunto",
                      "type": "textField",
                    },
                    {
                      "field": "message",
                      "type": "textArea",
                      "title": "Mensagem",
                    },
                    {
                      "type": "button",
                      "title": "Enviar",
                      "validateRequired": true,
                      "action": (Map<String, dynamic> data) async {
                        sendNewContact(data);
                      },
                    }
                  ]
                },
              ),
      ),
    );
  }

  sendNewContact(data) async {
    setState(() => loading = true);
    try {
      await controller.sendContact(
        name: data['name'],
        phoneNumber:
            data['phoneNumber'].toString().replaceAll(' ', '').substring(1),
        subject: data['subject'],
        message: data['message'],
      );
      Get.showSnackbar(GetBar(
        messageText: Text(
          'Contato enviado com sucesso!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 3),
      ));
    } catch (error) {
      Get.showSnackbar(GetBar(
        messageText: Text(
          'Ops! algo deu errado',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ));
    } finally {
      setState(() => loading = false);
    }
  }
}
