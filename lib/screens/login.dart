// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:tictactoe/Helper/color.dart';
import 'package:tictactoe/Helper/constant.dart';
import 'package:tictactoe/Helper/utils.dart';
import 'package:tictactoe/functions/authentication.dart';
import 'package:tictactoe/screens/login_with_email.dart';
import 'package:tictactoe/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _AuthOptionsScreenState createState() => _AuthOptionsScreenState();
}

class _AuthOptionsScreenState extends State<Login> {
  Timer? t;

  Utils localValue = Utils();

  @override
  void initState() {
    super.initState();

    checkUserLoggedIn();
  }

  @override
  void dispose() {
    super.dispose();
    t?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: utils.gradBack(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset("assets/images/signin_Dora.png")),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1),
              child: Text(
                utils.getTranslated(context, "CalculateEveryMove"),
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontFamily: 'DISPLATTER', color: white),
              ),
            ),
            Platform.isIOS
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return secondarySelectedColor;
                            }
                            return white;
                          },
                        ),
                      ),
                      onPressed: () async {
                        Auth.signin(context, false, "IOS");
                      },
                      icon: Image.asset('assets/images/apple_icon.png'),
                      label: Center(
                        child: Text(
                          utils.getTranslated(context, "signInApple"),
                          style: const TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return secondarySelectedColor;
                      }
                      return white;
                    },
                  ),
                ),
                onPressed: () async {
                  Auth.signin(context, false, "Android",
                      email: "", password: "");
                },
                icon: getSvgImage(imageName: "google_logo"),
                label: Center(
                  child: Text(
                    utils.getTranslated(context, "signInGoogle"),
                    style: const TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return secondarySelectedColor;
                      }
                      return white;
                    },
                  ),
                ),
                onPressed: () async {
                  await Auth.anonymousSignin(context).then((value) {
                    t?.cancel();
                  });
                },
                icon: Image.asset(
                  'assets/images/play_guest.png',
                ),
                label: Center(
                  child: Text(
                    utils.getTranslated(context, "signInGuest"),
                    style: const TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.only(
                  start: 40.0, end: 40, bottom: 10),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return secondarySelectedColor;
                      }
                      return white;
                    },
                  ),
                ),
                onPressed: () async {
                  await Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const LoginWithEmail()));
                },
                icon: const Icon(
                  Icons.email,
                  color: red,
                ),
                label: Center(
                  child: Text(
                    utils.getTranslated(context, "signInEmail"),
                    style: const TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkUserLoggedIn() async {
    bool value = await utils.getUserLoggedIn("isLoggedIn");

    if (value) {
      utils.replaceScreenAfter(context, "/home");
    }
  }
}
