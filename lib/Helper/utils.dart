import 'dart:async';
import 'dart:io';

import 'package:tictactoe/Helper/demo_localization.dart';
import 'package:tictactoe/Helper/string.dart';
import 'package:tictactoe/functions/dialoges.dart';
import 'package:tictactoe/functions/playbgm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'color.dart';
import 'constant.dart';

Music music = Music();
InterstitialAd? interstitialAd;

class Utils {
  final List winningCondition = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  Map gameButtons = {
    0: {
      "state": "",
      "player": "0",
    },
    1: {
      "state": "",
      "player": "0",
    },
    2: {
      "state": "",
      "player": "0",
    },
    3: {
      "state": "",
      "player": "0",
    },
    4: {
      "state": "",
      "player": "0",
    },
    5: {
      "state": "",
      "player": "0",
    },
    6: {
      "state": "",
      "player": "0",
    },
    7: {
      "state": "",
      "player": "0",
    },
    8: {
      "state": "",
      "player": "0",
    },
  };

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case "en":
        return const Locale("en", 'US');
      case "fr":
        return const Locale("fr", 'FR');
      case "es":
        return const Locale("es", "ES");
      case "hi":
        return const Locale("hi", "IN");
      case "ar":
        return const Locale("ar", "DZ");
      case "ru":
        return const Locale("ru", "RU");
      case "ja":
        return const Locale("ja", "JP");
      case "de":
        return const Locale("de", "DE");
      default:
        return const Locale("en", 'US');
    }
  }

  String getTranslated(BuildContext context, String key) {
    return DemoLocalization.of(context)!.translate(key) ?? key;
  }

  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LAGUAGE_CODE, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(LAGUAGE_CODE) ?? "fr";
    return _locale(languageCode);
  }

  Future getSfxValue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getBool("${appName}SFX-ENABLED") ?? false;
  }

  Future setSfxValue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setBool("${appName}SFX-ENABLED", true);
  }

  Future setSkinValue(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString(key, value);
  }

  Future getSkinValue(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString(key) ?? "";
  }

  Future setUserLoggedIn(String key, bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setBool(key, value);
  }

  Future getUserLoggedIn(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getBool(key) ?? false;
  }

  replaceScreenAfter(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  Widget showCircularProgress(bool isProgress, Color color) {
    if (isProgress) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ));
    }
    return const SizedBox(
      height: 0.0,
      width: 0.0,
    );
  }

  alert(
      {required context,
      required bool isMultipleAction,
      required String defaultActionButtonName,
      required Widget title,
      required Widget content,
      required void Function() onTapActionButton,
      required bool barrierDismissible,
      List? multipleAction}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                backgroundColor: primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: title,
                content: content,
                actions: multipleAction as List<Widget>?,
              ),
            ));
  }

  getCoins() async {
    int? coin = 0;

    FirebaseDatabase db = FirebaseDatabase.instance;
    var once = await db
        .ref()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .once();
    coin = await (once.snapshot.value as Map)["coin"];

    db
        .ref()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .onChildChanged
        .listen((DatabaseEvent ev) {
      if (ev.snapshot.key == "coin") {
        coin = int.parse(ev.snapshot.value.toString());
      }
    });
    return coin;
  }

  Future<bool> checkConnection(context) async {
    try {
      await InternetAddress.lookup('google.com');
      return true;
    } on SocketException catch (_) {
      var dialoge = Dialoge();
      dialoge.error(context);
      return false;
    }
  }

  limitChar(String value, [int? q]) {
    var useQ = q ?? 20;
    var st = value.length > useQ ? "..." : "";

    var r = value.substring(0, value.length > useQ ? useQ : value.length);
    return r + st;
  }

  BoxDecoration gradBack() {
    return const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          secondaryColor,
          primaryColor,
        ]));
  }

  String? validatePass(String value, String? msg1, String? msg2) {
    if (value.isEmpty) {
      return msg1;
    } else if (value.length <= 5) {
      return msg2;
    } else {
      return null;
    }
  }

  String? validateEmail(String value, String? msg1, String? msg2) {
    if (value.isEmpty) {
      return msg1;
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
            r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
            r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return msg2;
    } else {
      return null;
    }
  }

  returnImage(int i, Map buttons, String? imagex, String? imageo) {
    if (buttons[i]["player"] == "1" && buttons[i]["player"] != "0") {
      return imagex;
    } else if (buttons[i]["player"] == "2" && buttons[i]["player"] != "0") {
      return imageo;
    }
  }

  setSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: primaryColor),
      ),
      backgroundColor: white,
      elevation: 1.0,
    ));
  }

  JavascriptChannel toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
