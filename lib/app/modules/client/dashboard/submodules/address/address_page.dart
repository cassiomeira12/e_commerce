import 'package:e_commerce/app/components/buttons/primary_button.dart';
import 'package:e_commerce/app/components/card/card_page.dart';
import 'package:e_commerce/app/components/custom_snackbar/custom_snackbar.dart';
import 'package:e_commerce/app/components/future_builder/custom_future_builder.dart';
import 'package:e_commerce/app/components/generate_form/generate_form.dart';
import 'package:e_commerce/app/modules/client/dashboard/submodules/address/address_controller.dart';
import 'package:e_commerce/app/shared/models/address/address.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool loading = false, createNewItem = false, updateItem = false;

  final controller = Get.put(AddressController());

  dynamic newData;
  dynamic data;

  @override
  void initState() {
    super.initState();
    newData = {
      "fields": [
        {
          "field": "nome",
          "type": "textField",
          "title": "Nome completo do destinatário",
        },
        {
          "field": "cep",
          "type": "textField",
          "title": "CEP",
          "controller": MaskedTextController(
            mask: '00000-000',
          ),
          "textInputType": TextInputType.number,
          "validator": (String value) {
            if (value.isEmpty || value.length < 9) {
              return "Digite seu CEP";
            }
            return null;
          },
        },
        {
          "field": "pais",
          "type": "textField",
          "title": "País",
          "initial": "Brasil",
          "enable": false,
        },
        {
          "field": "estado",
          "type": "textField",
          "title": "Estado",
        },
        {
          "field": "cidade",
          "type": "textField",
          "title": "Cidade",
        },
        {
          "field": "bairro",
          "type": "textField",
          "title": "Bairro",
        },
        {
          "field": "endereco",
          "type": "textField",
          "title": "Rua / Avenida",
        },
        {
          "field": "numero",
          "type": "textField",
          "title": "Número",
        },
        {
          "field": "complemento",
          "type": "textField",
          "title": "Complemento",
        },
        {
          "field": "referencia",
          "type": "textField",
          "title": "Referência",
        },
        {
          "field": "principal",
          "type": "checkbox",
          "title": "Definir como endereço padrão",
        },
        {
          "type": "button",
          "title": "Salvar endereço",
          "validateRequired": true,
          "action": (Map<String, dynamic> result) async {
            result['principal'] = result['principal'] == 'true';
            try {
              Address address = Address.fromMap(result);
              print(address.toMap());
              sendDataCreate(address);
            } catch (error) {
              print(error);
            }
          },
        }
      ]
    };
  }

  setData(Address item) {
    this.data = {
      "fields": [
        {
          "field": "nome",
          "type": "textField",
          "initial": item.nome,
          "title": "Nome completo do destinatário",
        },
        {
          "field": "cep",
          "type": "textField",
          "title": "CEP",
          "controller": MaskedTextController(
            mask: '00000-000',
            text: item.cep.replaceAll('-', ''),
          ),
          "textInputType": TextInputType.number,
          "validator": (String value) {
            if (value.isEmpty || value.length < 9) {
              return "Digite seu CEP";
            }
            return null;
          },
        },
        {
          "field": "pais",
          "type": "textField",
          "title": "País",
          "initial": item.pais,
          "enable": false,
        },
        {
          "field": "estado",
          "type": "textField",
          "title": "Estado",
          "initial": item.estado,
          "enable": false,
        },
        {
          "field": "cidade",
          "type": "textField",
          "title": "Cidade",
          "initial": item.cidade,
          "enable": false,
        },
        {
          "field": "bairro",
          "type": "textField",
          "title": "Bairro",
          "initial": item.bairro,
        },
        {
          "field": "endereco",
          "type": "textField",
          "title": "Rua / Avenida",
          "initial": item.endereco,
        },
        {
          "field": "numero",
          "type": "textField",
          "title": "Número",
          "initial": item.numero,
        },
        {
          "field": "complemento",
          "type": "textField",
          "title": "Complemento",
          "initial": item.complemento,
        },
        {
          "field": "referencia",
          "type": "textField",
          "title": "Referência",
          "initial": item.referencia,
        },
        {
          "field": "principal",
          "type": "checkbox",
          "title": "Definir como endereço padrão",
          "initial": item.principal,
        },
        {
          "type": "button",
          "title": "Atualizar",
          "validateRequired": true,
          "action": (Map<String, dynamic> result) async {
            item.nome = result['nome'];
            item.cep = result['cep'];
            item.bairro = result['bairro'];
            item.endereco = result['endereco'];
            item.numero = result['numero'];
            item.complemento = result['complemento'];
            item.referencia = result['referencia'];
            item.principal = result['principal'];
            sendDataUpdate(item);
          },
        }
      ]
    };
  }

  Widget itemWidget(Address item) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destinatário: ',
                        style: fontSubtitle(context),
                      ),
                      Flexible(
                        child: Text(
                          item.nome,
                          overflow: TextOverflow.ellipsis,
                          style: fontSubtitle(context, bold: true),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: Text(item.principal ? 'Padão' : 'Definir como padão'),
                  onPressed: () {
                    //
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Endereço: ',
                  style: fontSubtitle(context),
                ),
                Flexible(
                  child: Text(
                    item.toString(),
                    style: fontSubtitle(context, bold: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                        "Cadastrar",
                        style: fontTitle(context),
                      ),
                      PrimaryButton(
                        text: createNewItem || updateItem
                            ? "Cancelar"
                            : "Adicionar",
                        onPressed: () {
                          setState(() {
                            if (createNewItem) {
                              createNewItem = false;
                            } else if (updateItem) {
                              updateItem = false;
                            } else {
                              createNewItem = true;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                loading
                    ? Center(child: CircularProgressIndicator())
                    : createNewItem || updateItem
                        ? GenerateForm(fields: createNewItem ? newData : data)
                        : CustomFutureBuilder(
                            future: controller.list(),
                            builder: (context, snapshot) {
                              List list = List.from(snapshot.data);
                              if (list.isEmpty) {
                                return Center(
                                  child: Text(
                                    'Nenhum endereço cadastrado',
                                    style: fontSubtitle(context),
                                  ),
                                );
                              } else {
                                return Column(
                                  children: list.map((e) {
                                    return InkWell(
                                      child: itemWidget(e),
                                      onTap: () {
                                        setData(e);
                                        setState(() => updateItem = true);
                                      },
                                    );
                                  }).toList(),
                                );
                              }
                            },
                          ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendDataCreate(item) async {
    setState(() => loading = true);
    try {
      await controller.create(item);
      CustomSnackbar.show(
        context,
        message: 'Endereço cadastrado com sucesso!',
        seconds: 4,
      );
    } catch (error) {
      CustomSnackbar.showError(
        context,
        message: 'Ops! algo deu errado',
        seconds: 4,
      );
    } finally {
      setState(() {
        loading = false;
        updateItem = false;
        createNewItem = false;
      });
    }
  }

  sendDataUpdate(item) async {
    setState(() => loading = true);
    try {
      await controller.updateItem(item);
      CustomSnackbar.show(
        context,
        message: 'Endereço atualizado com sucesso!',
        seconds: 4,
      );
    } catch (error) {
      CustomSnackbar.showError(
        context,
        message: 'Ops! algo deu errado',
        seconds: 4,
      );
    } finally {
      setState(() {
        loading = false;
        updateItem = false;
        createNewItem = false;
      });
    }
  }
}
