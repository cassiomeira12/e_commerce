import 'package:e_commerce/app/components/card/card_page.dart';
import 'package:e_commerce/app/components/custom_snackbar/custom_snackbar.dart';
import 'package:e_commerce/app/components/generate_form/generate_form.dart';
import 'package:e_commerce/app/components/image_network/image_network_widget.dart';
import 'package:e_commerce/app/shared/repositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

import 'account_controller.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool loading = false;

  var controller = Get.put(AccountController());

  var auth = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardPage(
            child: body(),
          ),
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
            ? Container(
                height: MediaQuery.of(context).size.height - 180,
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Container(
                    width: 180,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          child: Center(
                            child: ImageNetworkWidget(
                              url: auth.getUser().avatarURL,
                              size: 160,
                            ),
                          ),
                          onTap: () {
                            //
                          },
                        ),
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: RawMaterialButton(
                        //     child: Icon(Icons.camera_alt, color: Colors.white),
                        //     shape: CircleBorder(),
                        //     elevation: 2,
                        //     fillColor: Theme.of(context).primaryColorDark,
                        //     padding: EdgeInsets.all(10),
                        //     onPressed: () async {
                        //       print('antes');
                        //       FilePickerResult result =
                        //           await FilePicker.platform.pickFiles(
                        //         allowCompression: true,
                        //         allowMultiple: false,
                        //         allowedExtensions: ['jpg', 'png'],
                        //       );
                        //       print('depois');
                        //       print(result.count);
                        //       print(result.files);
                        //       print(result.files.first);
                        //       print(result.files.first.name);
                        //       print(result.files.first.size);
                        //       print(result.files.first.bytes);
                        //       print(result.files.first.readStream);
                        //       // if (result != null) {
                        //       //   File file = File(result.files.single.path);
                        //       //   print(file);
                        //       //   print(file.absolute);
                        //       // }
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  GenerateForm(
                    fields: {
                      "fields": [
                        {
                          "field": "name",
                          "title": "Nome",
                          "initial": auth.getUser().name,
                          "type": "textField",
                        },
                        {
                          "field": "phoneNumber",
                          "title": "Telefone",
                          "type": "textField",
                          "initial": auth.getUser().phoneNumber ?? null,
                          "controller": MaskedTextController(
                            mask: '+55 00 0 00000000',
                            text: auth.getUser().phoneNumber ?? null,
                          ),
                          "textInputType": TextInputType.number,
                          "validator": (String value) {
                            if (value.isEmpty || value.length < 17) {
                              return "Digite seu telefone";
                            }
                            return null;
                          },
                        },
                        {
                          "field": "email",
                          "title": "E-mail",
                          "initial": auth.getUser().email,
                          "enable": false,
                          "return": false,
                          "type": "textField",
                        },
                        {
                          "type": "button",
                          "title": "Salvar",
                          "validateRequired": true,
                          "action": (Map<String, dynamic> data) async {
                            print(data);
                            sendData(data);
                          },
                        }
                      ]
                    },
                  ),
                ],
              ),
      ),
    );
  }

  sendData(data) async {
    setState(() => loading = true);
    try {
      var user = auth.getUser();
      user.name = data['name'];
      user.phoneNumber = data['phoneNumber'];
      await controller.updateUserData(user);
      CustomSnackbar.show(
        context,
        message: 'Dados atualizados sucesso!',
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
