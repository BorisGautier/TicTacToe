import 'dart:async';

import 'package:tictactoe/Helper/color.dart';
import 'package:tictactoe/Helper/constant.dart';
import 'package:tictactoe/Helper/utils.dart';
import 'package:tictactoe/screens/offline_play.dart';

import 'package:tictactoe/screens/splash.dart';
import 'package:tictactoe/screens/pass_n_play.dart';

import 'package:tictactoe/widgets/alertDialoge.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialoge {
  static winner(
    BuildContext context,
    String? playerName,
    String? pic,
    String winText, [
    String? point,
    String? gameKey,
  ]) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          secondaryColor,
                          secondaryColor,
                          primaryColor,
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          utils.getTranslated(context, "gameOver"),
                          style: const TextStyle(color: white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: white,
                                )),
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    backgroundImage: (pic == ""
                                            ? const AssetImage(
                                                "assets/images/dora_win.png")
                                            : NetworkImage(pic!))
                                        as ImageProvider<Object>?))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "$playerName ${utils.getTranslated(context, "win")}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          winText,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: white),
                        ),
                      ),
                      point != ""
                          ? Chip(
                              backgroundColor: secondaryColor,
                              label: Text(
                                point!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: white),
                              ),
                              avatar:
                                  Image.asset("assets/images/coin_symbol.png"),
                            )
                          : Container(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () async {
                            music.play(click);

                            if (gameKey != null) {
                              removeChild("Game", gameKey);
                            }

                            Navigator.popUntil(
                                context, ModalRoute.withName("/home"));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 5),
                              child: Text(
                                utils.getTranslated(context, "ok"),
                                style: const TextStyle(color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  tie(BuildContext context, String fromScreen,
      [player1name, player2name, player1skin, player2skin, levelType]) {
    utils.alert(
        defaultActionButtonName: utils.getTranslated(context, "ok"),
        barrierDismissible: false,
        isMultipleAction: true,
        context: context,
        title: Text(
          utils.getTranslated(context, "gameOver"),
          style: const TextStyle(color: white),
        ),
        onTapActionButton: () {},
        content: const Text(
          "Game tie",
          style: TextStyle(color: white, fontSize: 25),
        ),
        multipleAction: <Widget>[
          TextButton(
            onPressed: () async {
              music.play(click);
              Navigator.of(context).pushReplacementNamed("/home");
            },
            child: Text(
              utils.getTranslated(context, "ok"),
              style: const TextStyle(color: white),
            ),
          ),
          TextButton(
            onPressed: () {
              fromScreen == "Singleplayer"
                  ? Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              SinglePlayerScreenActivity(
                                  player1skin, player2skin, levelType)))
                  : Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (BuildContext context) => PassNPLay(
                              player1name,
                              player2name,
                              player1skin,
                              player2skin)));
            },
            child: Text(utils.getTranslated(context, "restart"),
                style: const TextStyle(color: white)),
          )
        ]);
  }

  static lessMoney(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Alert(
            title: Text(
              utils.getTranslated(context, "aleart"),
              style: const TextStyle(color: white),
            ),
            isMultipleAction: true,
            defaultActionButtonName: utils.getTranslated(context, "ok"),
            onTapActionButton: () async {
              music.play(click);
              Navigator.pop(context);
            },
            content: Text(
              utils.getTranslated(context, "youDontHaveMoney"),
              style: const TextStyle(color: white),
            ),
          );
        });
  }

  static loading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                  ),
                ],
              ));
        });
  }

  tieMultiplayer(context, [gamekey]) {
    utils.alert(
        defaultActionButtonName: utils.getTranslated(context, "ok"),
        barrierDismissible: false,
        isMultipleAction: false,
        context: context,
        title: Text(
          utils.getTranslated(context, "gameOver"),
          style: const TextStyle(color: white),
        ),
        onTapActionButton: () async {
          music.play(click);
          Navigator.popUntil(context, ModalRoute.withName("/home"));
        },
        content: Text(
          utils.getTranslated(context, "tie"),
          style: const TextStyle(color: white),
        ),
        multipleAction: <Widget>[
          TextButton(
            onPressed: () async {
              music.play(click);

              if (gamekey != null) {
                removeChild("Game", gamekey);
              }

              //Navigator.pushReplacementNamed(context, "/home");
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              utils.getTranslated(context, "ok"),
              style: const TextStyle(color: white),
            ),
          ),
        ]);
  }

  curentRoundResult(context, String subtitle) {
    utils.alert(
        defaultActionButtonName: utils.getTranslated(context, "ok"),
        barrierDismissible: false,
        isMultipleAction: false,
        context: context,
        title: Text(
          utils.getTranslated(context, "nextRound"),
          style: const TextStyle(color: white),
          textAlign: TextAlign.center,
        ),
        onTapActionButton: () async {
          music.play(click);
        },
        content: Text(
          subtitle,
          style: const TextStyle(color: white),
          textAlign: TextAlign.center,
        ),
        multipleAction: <Widget>[
          TextButton(
            onPressed: () async {
              music.play(click);
              //Navigator.pushReplacementNamed(context, "/home");
              Navigator.pop(context);
            },
            child: Text(
              utils.getTranslated(context, "ok"),
              style: const TextStyle(color: white),
            ),
          ),
        ]);
  }

  oppornentDisconnect(context, entryfee, [gamekey]) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Alert(
              defaultActionButtonName: utils.getTranslated(context, "ok"),
              title: Text(
                utils.getTranslated(context, "opponentDisconnected"),
                style: const TextStyle(color: white),
              ),
              isMultipleAction: true,
              multipleAction: [
                MaterialButton(
                    onPressed: () {
                      music.play(click);
                      removeChild("Game", gamekey);
                      Navigator.popUntil(context, ModalRoute.withName("/home"));
                    },
                    child: Text(
                      utils.getTranslated(context, "ok"),
                      style: const TextStyle(color: white),
                    ))
              ],
              onTapActionButton: () async {},
              content: Text(
                "You got  ${entryfee * 2} coins.",
                style: const TextStyle(color: white),
              ),
            ),
          );
        });
  }

  error(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Alert(
            defaultActionButtonName: utils.getTranslated(context, "ok"),
            title: Text(
              utils.getTranslated(context, "error"),
              style: const TextStyle(color: white),
              textAlign: TextAlign.center,
            ),
            isMultipleAction: true,
            multipleAction: [
              MaterialButton(
                  onPressed: () {
                    music.play(click);
                    Navigator.pop(context);
                  },
                  child: Text(
                    utils.getTranslated(context, "ok"),
                    style: const TextStyle(color: white),
                  ))
            ],
            onTapActionButton: () async {},
            content: Text(
              utils.getTranslated(context, "checkYourInternet"),
              style: const TextStyle(color: white),
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  static removeChild(String parentNode, String? childNode) {
    Future.delayed(const Duration(minutes: 2)).then((value) {
      FirebaseDatabase.instance
          .ref()
          .child(parentNode)
          .child(childNode!)
          .remove();
    });
  }
}
