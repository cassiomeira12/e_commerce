import 'package:e_commerce/app/modules/client/client_controller.dart';
import 'package:e_commerce/app/shared/repositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientPage extends GetView<ClientController> {
  var auth = Get.find<AuthService>();

  ClientPage() {
    checkCurrentUser();
  }

  checkCurrentUser() async {
    try {
      await auth.currentUser();
      Get.offNamed(auth.isAuth() ? '/client/dashboard' : '/client/login');
    } catch (error) {
      Get.offNamed('/client/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 100,
                  child: Image.asset("assets/images/logo_app.png"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
