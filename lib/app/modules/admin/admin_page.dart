import 'package:e_commerce/app/shared/repositories/auth_service.dart';
import 'package:e_commerce/app/shared/repositories/parse/parse_init.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/notifications/push_notification.dart';
import '../../shared/repositories/admin_service.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  AdminService admin;
  PushNotification pushNotification;

  @override
  void initState() {
    super.initState();
    Get.putAsync(() => ParseInit.init(), permanent: true).then((value) {
      Get.put(AuthService(), permanent: true);
      admin = Get.put(AdminService(), permanent: true);
      pushNotification = Get.put(PushNotification(), permanent: true);
      checkCurrentUser();
    });
  }

  checkCurrentUser() async {
    try {
      await admin.currentAdminUser();
      Get.offNamed(admin.isAdmin() ? '/admin/dashboard' : '/admin/login');
    } catch (error) {
      print(error);
      Get.offNamed('/admin/login');
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
