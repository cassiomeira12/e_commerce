import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/repositories/admin_company_service.dart';

class CompanyMiddleware extends GetMiddleware {
  String redirectPath;

  CompanyMiddleware(int priority, {this.redirectPath})
      : super(priority: priority);

  @override
  RouteSettings redirect(String route) {
    var auth = Get.find<AdminCompanyService>();
    return auth.isAdmin() ? null : RouteSettings(name: redirectPath ?? '/');
  }

  @override
  GetPage onPageCalled(GetPage page) {
    var auth = Get.find<AdminCompanyService>();
    return page.copyWith(
      transition: auth.isAdmin() ? page.transition : Transition.upToDown,
      transitionDuration: auth.isAdmin() ? page.transitionDuration : 1.seconds,
    );
  }

  @override
  List<Bindings> onBindingsStart(List<Bindings> bindings) {
    var auth = Get.find<AdminCompanyService>();
    if (!auth.isAdmin()) {
      bindings = <Bindings>[];
    }
    return super.onBindingsStart(bindings);
  }
}
