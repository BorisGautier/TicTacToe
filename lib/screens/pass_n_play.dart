// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:tictactoe/Helper/color.dart';
import 'package:tictactoe/Helper/constant.dart';

import 'package:tictactoe/Helper/utils.dart';
import 'package:tictactoe/functions/dialoges.dart';

import 'package:tictactoe/widgets/alertDialoge.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:flutter/material.dart';

import 'splash.dart';

class PassNPLay extends StatefulWidget {
  final String? player1, player2, player1Skin, player2Skin;

  const PassNPLay(
      this.player1, this.player2, this.player1Skin, this.player2Skin,
      {Key? key})
      : super(key: key);

  @override
  _PassNPLayState createState() => _PassNPLayState();
}

class _PassNPLayState extends State<PassNPLay> {
  final CountDownController _countDownPlayer = CountDownController();
  String gameStatus = "";

  Utils u = Utils();
  Map buttons = {};
  String? currentMove;
  late Random randomValue;
  String? player;
  String? winner = "0";
  int calledCount = 0;
  int tieCalled = 0;

  @override
  void initState() {
    super.initState();
    buttons = u.gameButtons;
    randomValue = Random();
    int randomNumber = randomValue.nextInt(2);

    player = randomNumber == 0 ? "X" : "O";
    gameStatus = "started";

    playGame();
  }

  void check() {
    for (var i = 0; i < buttons.length; i++) {
      for (var j = 0; j < utils.winningCondition.length; j++) {
        if (buttons[utils.winningCondition[j][0]]["player"] ==
                buttons[utils.winningCondition[j][1]]["player"] &&
            buttons[utils.winningCondition[j][1]]["player"] ==
                buttons[utils.winningCondition[j][2]]["player"] &&
            buttons[utils.winningCondition[j][1]]["player"] != "0") {
          winner = buttons[utils.winningCondition[j][1]]["player"];

          gameStatus = "over";

          calledCount += 1;
          setState(() {});
        } else {
          int count = 0;
          for (var k = 0; k < buttons.length; k++) {
            if (buttons[k]["state"] != "" && winner == "0") {
              count++;
            }
            if (count == 9) {
              gameStatus = "tie";

              tieCalled += 1;
            }
          }

          if (count == 9 && tieCalled == 1 && winner == "0") {
            if (mounted) {
              setState(() {});
            }

            music.play(tiegame);

            Future.delayed(const Duration(seconds: 1)).then((value) {
              if (winner == "0" && gameStatus == "tie") {
                Dialoge().tie(
                    context,
                    "passnplay",
                    widget.player1.toString(),
                    widget.player2.toString(),
                    widget.player1Skin,
                    widget.player2Skin);
              }
              _countDownPlayer.pause();
              setState(() {});
            });
          }
        }
      }
    }

    if (gameStatus == "over" && mounted && winner != "0") {
      winner == "1" ? music.play(wingame) : music.play(losegame);

      _countDownPlayer.pause();
      setState(() {});

      Dialoge.winner(
        context,
        winner == "1" ? widget.player2.toString() : widget.player1.toString(),
        "",
        "",
        "",
        "",
      );
    }
  }

  playGame([i]) async {
    if (gameStatus == "started") {
      currentMove =
          player == "X" ? "${widget.player1} Turn" : "${widget.player2} Turn";

      setState(() {});

      if (player == "X" && i != null) {
        if (buttons[i]["state"] == "") {
          music.play(dice);

          buttons[i]["state"] = "true";

          buttons[i]["player"] = "2";
          player = "O";
          _countDownPlayer.restart();

          currentMove = "${widget.player1} Turn";

          setState(() {});

          playGame();
        }
        if (gameStatus == "started") {
          check();
        }
      }

      if (player == "O" && i != null) {
        if (buttons[i]["state"] == "") {
          music.play(dice);

          buttons[i]["state"] = "true";

          buttons[i]["player"] = "1";
          player = "X";
          _countDownPlayer.restart();

          currentMove = "${widget.player1} Turn";

          setState(() {});

          playGame();
        }
        if (gameStatus == "started") {
          check();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          music.play(click);

          showDialog(
              context: context,
              builder: (context) {
                var color = secondaryColor;

                return Alert(
                  title: Text(
                    utils.getTranslated(context, "aleart"),
                    style: const TextStyle(color: white),
                  ),
                  isMultipleAction: true,
                  defaultActionButtonName: utils.getTranslated(context, "ok"),
                  onTapActionButton: () {},
                  content: Text(
                    utils.getTranslated(context, "areYouSure"),
                    style: const TextStyle(color: white),
                  ),
                  multipleAction: [
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color)),
                        onPressed: () async {
                          music.play(click);

                          Navigator.popUntil(
                              context, ModalRoute.withName("/home"));
                        },
                        child: Text(utils.getTranslated(context, "ok"),
                            style: const TextStyle(color: white))),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color)),
                        onPressed: () async {
                          music.play(click);

                          Navigator.pop(context);
                        },
                        child: Text(utils.getTranslated(context, "cancle"),
                            style: const TextStyle(color: white)))
                  ],
                );
              });

          return await Future.value(false);
        },
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: utils.gradBack(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          CircularCountDownTimer(
                            height: 25,
                            duration: countdowntime,
                            ringColor: back,
                            fillColor: secondarySelectedColor,
                            width: 25,
                            strokeWidth: 3,
                            controller: _countDownPlayer,
                            textFormat: CountdownTextFormat.S,
                            textStyle:
                                const TextStyle(color: white, fontSize: 10),
                            // autoStart: player == "X" ? true : false,
                            isReverse: true,
                            initialDuration: 0,
                            onComplete: () async {
                              music.play(losegame);
                              Dialoge.winner(
                                  context,
                                  currentMove == "${widget.player1} Turn"
                                      ? widget.player2.toString()
                                      : widget.player1.toString(),
                                  "",
                                  "",
                                  "",
                                  "");
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 8.0),
                            child: Text("$currentMove"),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          padding: const EdgeInsets.only(),
                          onPressed: () {
                            showQuitGameDialog();
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: back,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Center(
                      child: Stack(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));
                                  if (gameStatus == "started") {
                                    playGame(index);
                                  }
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/grid_box.png"),
                                          fit: BoxFit.fill)),
                                  child: buttons[index]['state'] == ""
                                      ? Container()
                                      : Image.asset(
                                          u.returnImage(
                                              index,
                                              buttons,
                                              widget.player2Skin,
                                              widget.player1Skin),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/signin_Dora.png",
                            ),
                            radius: 25,
                            backgroundColor: Colors.transparent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${utils.getTranslated(context, "sign")} : ",
                                    ),
                                    Image.asset(
                                      widget.player1Skin!,
                                      height: 12,
                                      color: secondarySelectedColor,
                                    )
                                  ],
                                ),
                                Text(
                                  widget.player1.toString(),
                                  style: const TextStyle(color: white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Image.asset("assets/images/vs_small.png")),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    widget.player2Skin!,
                                    height: 12,
                                  ),
                                  Text(
                                    " : ${utils.getTranslated(context, "sign")}",
                                  ),
                                ],
                              ),
                              Text(
                                widget.player2.toString(),
                                style: const TextStyle(color: white),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                "assets/images/signin_Dora.png",
                              ),
                              radius: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showQuitGameDialog() {
    music.play(click);
    showDialog(
        context: context,
        builder: (context) {
          var color = secondaryColor;

          return Alert(
            title: Text(
              utils.getTranslated(context, "aleart"),
              style: const TextStyle(color: white),
            ),
            isMultipleAction: true,
            defaultActionButtonName: utils.getTranslated(context, "ok"),
            onTapActionButton: () {},
            content: Text(
              utils.getTranslated(context, "areYouSure"),
              style: const TextStyle(color: white),
            ),
            multipleAction: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(color)),
                  onPressed: () async {
                    music.play(click);

                    Navigator.popUntil(context, ModalRoute.withName("/home"));
                  },
                  child: Text(utils.getTranslated(context, "ok"),
                      style: const TextStyle(color: white))),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(color)),
                  onPressed: () async {
                    music.play(click);

                    Navigator.pop(context);
                  },
                  child: Text(utils.getTranslated(context, "cancle"),
                      style: const TextStyle(color: white)))
            ],
          );
        });
  }
}
