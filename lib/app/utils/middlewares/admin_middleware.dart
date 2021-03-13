import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/repositories/admin_service.dart';

class AdminMiddleware extends GetMiddleware {
  String redirectPath;

  AdminMiddleware(int priority, {this.redirectPath})
      : super(priority: priority);

  @override
  RouteSettings redirect(String route) {
    var auth = Get.find<AdminService>();
    return auth.isAdmin() ? null : RouteSettings(name: redirectPath ?? '/');
  }

  @override
  GetPage onPageCalled(GetPage page) {
    var auth = Get.find<AdminService>();
    return page.copyWith(
      transition: auth.isAdmin() ? page.transition : Transition.upToDown,
      transitionDuration: auth.isAdmin() ? page.transitionDuration : 1.seconds,
    );
  }

  @override
  List<Bindings> onBindingsStart(List<Bindings> bindings) {
    var auth = Get.find<AdminService>();
    if (!auth.isAdmin()) {
      bindings = <Bindings>[];
    }
    return super.onBindingsStart(bindings);
  }
}
