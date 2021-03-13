import 'package:e_commerce/app/modules/home/subroutes/newsletter/newsletter_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/privacy/privacy_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/product/product_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/terms/terms_page.dart';
import 'package:e_commerce/app/pages/recover_password/recover_password_page.dart';
import 'package:e_commerce/app/pages/splash/splash_page.dart';
import 'package:e_commerce/app/utils/middlewares/admin_middleware.dart';
import 'package:e_commerce/app/utils/middlewares/auth_middleware.dart';
import 'package:get/get.dart';

import 'admin/admin_page.dart';
import 'admin/dashboard/dashboard_bind.dart' as AdminDashboard;
import 'admin/dashboard/dashboard_page.dart' as AdminDashboard;
import 'admin/login/login_page.dart' as AdminLogin;
import 'client/client_bind.dart';
import 'client/client_page.dart';
import 'client/dashboard/dashboard_bind.dart' as ClientDashboard;
import 'client/dashboard/dashboard_page.dart' as ClientDashboard;
import 'client/login/login_page.dart' as ClientLogin;
import 'home/home_bind.dart';
import 'home/home_page.dart';

class Routes {
  static var routes = [
    GetPage(
      name: '/',
      page: () => SplashPage(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBind(),
      children: [
        GetPage(
          name: '/product',
          page: () => ProductPage(),
        ),
      ],
    ),
    GetPage(
      name: '/politica-de-privacidade',
      page: () => PrivacyPage(),
    ),
    GetPage(
      name: '/termos_de_uso',
      page: () => TermsPage(),
    ),
    GetPage(
      name: '/recover_password',
      page: () => RecoverPasswordPage(),
    ),
    GetPage(
      name: '/newsletter',
      page: () => NewsletterPage(),
    ),
    GetPage(
      name: '/admin',
      page: () => AdminPage(),
      children: [
        GetPage(
          name: '/login',
          page: () => AdminLogin.LoginPage(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => AdminDashboard.DashboardPage(),
          binding: AdminDashboard.DashboardBind(),
          middlewares: [AdminMiddleware(0, redirectPath: '/admin')],
        ),
      ],
    ),
    GetPage(
      name: '/client',
      page: () => ClientPage(),
      binding: ClientBind(),
      children: [
        GetPage(
          name: '/login',
          page: () => ClientLogin.LoginPage(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => ClientDashboard.DashboardPage(),
          binding: ClientDashboard.DashboardBind(),
          middlewares: [AuthMiddleware(0, redirectPath: '/client')],
        ),
      ],
    ),
    // GetPage(
    //   name: '/company',
    //   page: () => CompanyPage(),
    //   children: [
    //     GetPage(
    //       name: '/login',
    //       page: () => CompanyLogin.LoginPage(),
    //     ),
    //     GetPage(
    //       name: '/dashboard',
    //       page: () => CompanyDashboard.DashboardPage(),
    //       binding: CompanyBind.DashboardBind(),
    //       //middlewares: [CompanyMiddleware(0, redirectPath: '/company')],
    //       children: [
    //         GetPage(
    //           name: '/order_details',
    //           page: () => OrderDetailsPage(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ];
}
