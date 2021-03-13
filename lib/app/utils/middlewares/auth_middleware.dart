import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/repositories/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  String redirectPath;

  AuthMiddleware(int priority, {this.redirectPath}) : super(priority: priority);

  @override
  RouteSettings redirect(String route) {
    var auth = Get.find<AuthService>();
    return auth.isAuth() ? null : RouteSettings(name: redirectPath ?? '/');
  }
}
