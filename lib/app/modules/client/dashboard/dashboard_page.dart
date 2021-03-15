import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:e_commerce/app/components/drawer/drawer_widget.dart';
import 'package:e_commerce/app/components/responsive/responsive.dart';
import 'package:e_commerce/app/shared/repositories/auth_service.dart';
import 'package:e_commerce/app/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_controller.dart';
import 'submodules/account/account_page.dart';
import 'submodules/address/address_page.dart';
import 'submodules/history/history_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedPage = 0, categoryIndex = 0, menuIndex = 0;

  List<dynamic> drawerItems;
  List<dynamic> pages = [];

  var auth = Get.find<AuthService>();
  var controller = DashBoardController();

  @override
  void initState() {
    super.initState();
    drawerItems = [
      {
        'value': 'Minha conta',
        'icon': Icons.account_circle,
        'page': AccountPage(),
        'menus': [
          {
            'value': 'Endereços',
            'page': AddressPage(),
          },
        ],
      },
      {
        'value': 'Minhas compras',
        'icon': Icons.shopping_cart_outlined,
        'page': HistoryPage(),
        // 'menus': [
        //   {
        //     'value': 'Cadastrar Estabelecimento',
        //     'page': NewCompanyPage(),
        //   }
        // ],
      },
      {
        'value': 'Tema',
        'icon': Icons.brightness_medium,
        'action': () {
          showConfirmationDialog(
            context: context,
            barrierDismissible: false,
            title: "Escolha um tema",
            cancelLabel: "Cancelar",
            okLabel: "OK",
            actions: [
              AlertDialogAction(
                key: ThemeMode.system,
                label: "Automático",
                isDefaultAction: true,
              ),
              AlertDialogAction(
                key: ThemeMode.light,
                label: "Claro",
              ),
              AlertDialogAction(
                key: ThemeMode.dark,
                label: "Escuro",
              ),
            ],
          ).then((value) async {
            if (value != null) {
              var pref = await SharedPreferences.getInstance();
              pref.setInt("theme", ThemeMode.values.indexOf(value));
              Get.changeThemeMode(value);
            }
          });
        }
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Responsive(child: Container(), other: drawer()),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leading: MediaQuery.of(context).size.width < 990
                    ? null
                    : Container(),
                title: Text(
                  drawerItems[categoryIndex]['menus'] == null || menuIndex == 0
                      ? drawerItems[categoryIndex]['page'] == null
                          ? List.from(drawerItems[categoryIndex]['menus'])[
                              menuIndex]['value']
                          : drawerItems[categoryIndex]['value']
                      : drawerItems[categoryIndex]['page'] == null
                          ? List.from(drawerItems[categoryIndex]['menus'])[
                              menuIndex]['value']
                          : List.from(drawerItems[categoryIndex]['menus'])[
                              menuIndex - 1]['value'],
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  MaterialButton(
                    child: Text(
                      CLOSE,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => controller.signOut(context),
                  ),
                ],
              ),
              drawer: Responsive(child: drawer()),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: pages[selectedPage],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    return DrawerWidget(
      selectedPageIndex: selectedPage,
      categoryIndex: categoryIndex,
      menuIndex: menuIndex,
      hasHeader: true,
      pages: pages,
      drawerItems: drawerItems,
      avatarName: auth.getUser().name,
      avatarURL: auth.getUser().avatarURL,
      onChanged: (data) {
        setState(() {
          selectedPage = data['page'];
          categoryIndex = data['category'];
          menuIndex = data['menu'];
        });
      },
    );
  }
}
