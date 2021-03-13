import 'package:e_commerce/app/components/custom_snackbar/custom_snackbar.dart';
import 'package:e_commerce/app/components/generate_form/generate_form.dart';
import 'package:e_commerce/app/modules/home/components/copyrigth.dart';
import 'package:e_commerce/app/modules/home/subroutes/newsletter/newsletter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class NewsletterPage extends StatefulWidget {
  @override
  _NewsletterPageState createState() => _NewsletterPageState();
}

class _NewsletterPageState extends State<NewsletterPage> {
  var controller = NewsletterController();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/logo_app.png'),
                  ),
                ),
              ),
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
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 20),
        child: loading
            ? Container(
                height: MediaQuery.of(context).size.height - 180,
                child: Center(child: CircularProgressIndicator()),
              )
            : GenerateForm(
                fields: {
                  "fields": [
                    {
                      "field": "name",
                      "title": "Nome",
                      "type": "textField",
                    },
                    {
                      "field": "email",
                      "title": "E-mail",
                      "type": "textField",
                      "textInputType": TextInputType.emailAddress,
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
                      "field": "instagram",
                      "title": "Instagram",
                      "type": "textField",
                      "textCapitalization": TextCapitalization.none,
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
      await controller.sendNewsletter(
        firstname: data['name'],
        lastname: data['instagram'],
        email: data['email'],
        phonenumber:
            data['phoneNumber'].toString().replaceAll(' ', '').substring(1),
      );
      CustomSnackbar.show(
        context,
        message: 'Cadastro feito com sucesso!',
        seconds: 4,
      );
    } catch (error) {
      CustomSnackbar.showError(
        context,
        message: 'Ops! algo deu errado',
        seconds: 4,
      );
    } finally {
      setState(() => loading = false);
    }
  }
}
