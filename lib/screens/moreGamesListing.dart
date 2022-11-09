// ignore_for_file: file_names

import 'package:tictactoe/Helper/color.dart';
import 'package:tictactoe/Helper/constant.dart';
import 'package:tictactoe/screens/moreGames.dart';

import 'package:tictactoe/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/utils.dart';
import '../functions/advertisement.dart';

class MoreGamesListing extends StatefulWidget {
  const MoreGamesListing({Key? key}) : super(key: key);

  @override
  State<MoreGamesListing> createState() => _MoreGamesListingState();
}

class _MoreGamesListingState extends State<MoreGamesListing> {
  final List<Widget> gameListUI = [];

  List<HTMLGames> gamesList = [
    HTMLGames(
        gameImage:
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/hextris.webp?alt=media&token=557e9a25-38a0-4d92-9d19-d592a6bf85b8',
        gameName: 'Hextris',
        gameURL: 'https://hextris.io/'),
    HTMLGames(
        gameImage:
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/clumsy-bird-open-source-game.webp?alt=media&token=fad3370e-c131-44c9-b083-abd7064daa97',
        gameName: 'Clumsy Bird',
        gameURL: 'https://ellisonleao.github.io/clumsy-bird/'),
    HTMLGames(
        gameImage:
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/pacman-html5-canvat.webp?alt=media&token=c651bb85-60af-4e84-b2d2-fe72ab235966',
        gameName: 'Pacman',
        gameURL: 'https://pacman.platzh1rsch.ch/'),
    HTMLGames(
        gameImage:
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/cover.jpg?alt=media&token=60c0e4a0-2036-45d9-9f04-3aab6bcbaf2d',
        gameName: '2048 Game',
        gameURL: 'https://play2048.co/'),
    HTMLGames(
        gameImage:
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/unnamed.png?alt=media&token=a1c29bf6-82ca-42a7-a3d2-bb90a0b65d59',
        gameName: 'Tetris',
        gameURL: 'https://dionyziz.com/graphics/canvas-tetris/'),
  ];

  @override
  void initState() {
    Advertisement.loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.games,
              size: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(utils.getTranslated(context, "playMoreGames")),
            ),
          ],
        ),
        backgroundColor: secondaryColor,
        elevation: 0,
      ),
      backgroundColor: secondaryColor,
      body: gamesList.isEmpty
          ? Center(
              child: Text(utils.getTranslated(context, "noMoreGamesFound")),
            )
          : showMoreGameList(context),
    );
  }

  Widget showMoreGameList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        children: [...getMoreGameList(context)],
      ),
    );
  }

  getMoreGameList(BuildContext context) {
    gameListUI.clear();
    for (var element in gamesList) {
      gameListUI.add(getGame(element, context));
    }
    return gameListUI;
  }

  Widget getGame(HTMLGames game, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              height: 70,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(
                                4, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: FadeInImage(
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          game.gameImage,
                        ),
                        placeholder: const AssetImage(
                          'assets/images/dora_placeholder.png',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          game.gameName,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: 70,
                padding: const EdgeInsets.all(2.0),
                decoration: const BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  utils.getTranslated(context, 'playNow'),
                ))),
            onTap: () async {
              music.play(click);
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PlayGame(gameURL: game.gameURL),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class HTMLGames {
  final String gameName;
  final String gameImage;
  final String gameURL;

  HTMLGames(
      {required this.gameName, required this.gameImage, required this.gameURL});
}
