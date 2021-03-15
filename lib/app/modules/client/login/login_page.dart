import 'package:e_commerce/app/components/shapes/shape_round.dart';
import 'package:e_commerce/app/shared/repositories/auth_service.dart';
import 'package:e_commerce/app/styles/font_style.dart';
import 'package:e_commerce/app/utils/strings/errors.dart';
import 'package:e_commerce/app/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social_signin_buttons/social_signin_buttons.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  var controller = LoginController();
  var auth = Get.find<AuthService>();

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  checkCurrentUser() async {
    await auth.currentUser();
    if (auth.isAuth()) {
      Get.offNamed('/client/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        progressIndicator: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(),
          ),
        ),
        child: keyboardDismisser(),
      ),
    );
  }

  Widget keyboardDismisser() {
    return KeyboardDismisser(
      gestures: [GestureType.onTap, GestureType.onVerticalDragDown],
      child: SingleChildScrollView(child: body()),
    );
  }

  Widget body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MediaQuery.of(context).size.width > 800
            ? Flexible(child: banner())
            : Container(),
        Flexible(
          child: bodyAppScrollView(),
        ),
      ],
    );
  }

  Widget banner() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/image_1.jpeg'),
        ),
      ),
    );
  }

  Widget bodyAppScrollView() {
    return Container(
      width: MediaQuery.of(context).size.width > 800
          ? MediaQuery.of(context).size.width / 2
          : MediaQuery.of(context).size.width / 1.4,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: ShapeRound(child: _showForm()),
          ),
        ],
      ),
    );
  }

  Widget _showForm() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Text("Entrar", style: fontTitle(context)),
          showLogo(),
          googleButton(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget showLogo() {
    return Column(
      children: <Widget>[
        Hero(
          tag: APP_NAME,
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 100,
              child: Image.asset("assets/images/logo_app.png"),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget googleButton() {
    return SignInButton(
      Buttons.Google,
      text: "Login com o Google",
      onPressed: () async {
        try {
          setState(() => _loading = true);
          await controller.signInWithGoogle();
          Get.offNamed('/home');
        } catch (error) {
          catchError(title: 'Erro ao fazer login', error: error);
        } finally {
          setState(() => _loading = false);
        }
      },
    );
  }
}
