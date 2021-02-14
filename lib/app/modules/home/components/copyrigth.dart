import 'package:e_commerce/app/styles/font_style.dart';
import 'package:e_commerce/app/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyRigth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //color: Colors.red,
      //margin: EdgeInsets.only(top: 100),
      padding: EdgeInsets.only(left: 50, right: 50, top: 7, bottom: 7),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '© Copyright ${APP_NAME}. Todos os direitos reservados. ',
              style: fontSubtitle(context, size: 15),
            ),
          ),
          Wrap(
            //mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                child: Text(
                  "Newsletter",
                  style: fontSubtitle(context, size: 15),
                ),
                onPressed: () => Get.toNamed('/termos_de_uso'),
              ),
              FlatButton(
                child: Text(
                  "Institucional",
                  style: fontSubtitle(context, size: 15),
                ),
                onPressed: () => Get.toNamed('/politica-de-privacidade'),
              ),
              FlatButton(
                child: Text(
                  "Formas de Envio",
                  style: fontSubtitle(context, size: 15),
                ),
                onPressed: () => Get.toNamed('/politica-de-privacidade'),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // InkWell(
              //   child: Container(
              //     padding: EdgeInsets.all(10),
              //     margin: EdgeInsets.symmetric(horizontal: 5),
              //     child: FaIcon(
              //       FontAwesomeIcons.whatsapp,
              //       color: Colors.white,
              //     ),
              //   ),
              //   onTap: () async {
              //     var link =
              //         "https://api.whatsapp.com/send?phone=5577999116731";
              //     if (await canLaunch(link)) {
              //       await launch(link);
              //     }
              //   },
              // ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  var link = "https://www.instagram.com/bitethebullet.co/";
                  if (await canLaunch(link)) {
                    await launch(link);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
