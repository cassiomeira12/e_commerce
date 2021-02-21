import 'package:e_commerce/app/components/drawer/drawer_widget.dart';
import 'package:e_commerce/app/components/responsive/responsive.dart';
import 'package:e_commerce/app/modules/home/home_controller.dart';
import 'package:e_commerce/app/modules/home/subroutes/about/about_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/contact/contact_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/initial/initial_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/lookbook/lookbook_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/lore/lore_page.dart';
import 'package:e_commerce/app/modules/home/subroutes/shop/shop_page.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0, categoryIndex = 0, menuIndex = 0;

  List<dynamic> menuItems;
  List<dynamic> pages = List();

  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    menuItems = [
      {
        'value': 'Home',
        'page': InitialPage(),
      },
      {
        'value': 'Shop',
        'page': ShopPage(),
      },
      {
        'value': 'Lookbook',
        'page': LookbookPage(),
      },
      {
        'value': 'Lore',
        'page': LorePage(),
      },
      {
        'value': 'Sobre nós',
        'page': AboutPage(),
      },
      {
        'value': 'Contato',
        'page': ContactPage(),
      },
      // {
      //   'value': 'Tema',
      //   'icon': Icons.brightness_medium,
      //   'action': () {
      //     showConfirmationDialog(
      //       context: context,
      //       barrierDismissible: false,
      //       title: "Escolha um tema",
      //       cancelLabel: "Cancelar",
      //       okLabel: "OK",
      //       actions: [
      //         AlertDialogAction(
      //           key: ThemeMode.system,
      //           label: "Automático",
      //           isDefaultAction: true,
      //         ),
      //         AlertDialogAction(
      //           key: ThemeMode.light,
      //           label: "Claro",
      //         ),
      //         AlertDialogAction(
      //           key: ThemeMode.dark,
      //           label: "Escuro",
      //         ),
      //       ],
      //     ).then((value) async {
      //       if (value != null) {
      //         var pref = await SharedPreferences.getInstance();
      //         pref.setInt("theme", ThemeMode.values.indexOf(value));
      //         Get.changeThemeMode(value);
      //       }
      //     });
      //   }
      // },
      // {
      //   'value': 'Entrar',
      //   'action': () => Get.toNamed('/company'),
      // }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.width > 600 ? 100 : kToolbarHeight,
        ),
        child: Container(
          padding: MediaQuery.of(context).size.width > 600
              ? EdgeInsets.only(top: 15)
              : EdgeInsets.zero,
          child: Column(
            children: [
              AppBar(
                leading: MediaQuery.of(context).size.width < 600
                    ? null
                    : Container(),
                title: InkWell(
                  // child: Image.asset(
                  //   "assets/images/logo_only.png",
                  //   height: kToolbarHeight,
                  //   //width: MediaQuery.of(context).size.width / 3,
                  // ),
                  child: Text(
                    'Bite The Bullet',
                    style: fontTitle(
                      context,
                      size: MediaQuery.of(context).size.width > 1000
                          ? 35
                          : MediaQuery.of(context).size.width > 700
                              ? 30
                              : MediaQuery.of(context).size.width > 600
                                  ? 30
                                  : 25,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedPage = 0;
                      categoryIndex = 0;
                      menuIndex = 0;
                    });
                  },
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    tooltip: 'Pesquisar',
                    onPressed: () {
                      //
                    },
                  ),
                  // Visibility(
                  //   visible: MediaQuery.of(context).size.width > 600,
                  //   child: IconButton(
                  //     icon: ImageIcon(
                  //       AssetImage('assets/images/ligh_mode.jpeg'),
                  //     ),
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     tooltip: 'Tema',
                  //     onPressed: () async {
                  //       var pref = await SharedPreferences.getInstance();
                  //       int index = pref.getInt('theme');
                  //       index = index == null
                  //           ? 1
                  //           : index == 1
                  //               ? 2
                  //               : 1;
                  //       pref.setInt("theme", index);
                  //       Get.changeThemeMode(ThemeMode.values[index]);
                  //     },
                  //   ),
                  // ),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    tooltip: 'Entrar',
                    onPressed: () {
                      //
                    },
                  ),
                ],
              ),
              Visibility(
                visible: MediaQuery.of(context).size.width > 610,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: menuItems.asMap().entries.map((e) {
                    return FlatButton(
                      child: Text(
                        e.value['value'].toUpperCase(),
                        style: fontSubtitle(context, size: 18, bold: true),
                      ),
                      onPressed: () {
                        if (e.value['action'] == null) {
                          MediaQuery.of(context).size.width < 990
                              ? Navigator.pop(context)
                              : null;
                          setState(() {
                            selectedPage = e.value['index'];
                            categoryIndex = e.key;
                            menuIndex = 0;
                          });
                        } else {
                          MediaQuery.of(context).size.width < 990
                              ? Navigator.pop(context)
                              : null;
                          e.value['action'].call();
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Responsive(child: drawer()),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: pages[selectedPage],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          onPressed: () {
            //
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget drawer() {
    return DrawerWidget(
      selectedPageIndex: selectedPage,
      categoryIndex: categoryIndex,
      menuIndex: menuIndex,
      pages: pages,
      hasHeader: false,
      drawerItems: menuItems,
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
