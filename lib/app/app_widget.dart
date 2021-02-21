import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'modules/routes.dart';
import 'styles/themes/dark_theme.dart';
import 'styles/themes/light_theme.dart';
import 'styles/themes/theme.dart';
import 'utils/strings/strings.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    getTheme().then((value) {
      Get.changeThemeMode(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        GetMaterialApp(
          title: APP_NAME,
          themeMode: ThemeMode.light,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          initialRoute: '/',
          getPages: Routes.routes,
          enableLog: kDebugMode,
          defaultTransition: kIsWeb ? Transition.fade : Transition.cupertino,
          opaqueRoute: Get.isOpaqueRouteDefault,
          popGesture: Get.isPopGestureEnable,
          debugShowCheckedModeBanner: false,
        ),
        //maxWidth: 1200,
        minWidth: 480,
        defaultScale: false,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        //background: Container(color: Colors.white),
      ),
    );
  }
}
