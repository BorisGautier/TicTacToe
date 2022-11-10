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
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/8BallBilliardsClassicTeaser.jpg?alt=media&token=8e282731-ca12-4954-a78b-0bea734922d2',
        gameName: 'Billard',
        gameURL:
            'https://games.cdn.famobi.com/html5games/0/8-ball-billiards-classic/v250/?fg_domain=play.famobi.com&fg_aid=A1000-100&fg_uid=82038e98-d4e1-46dd-8de9-1460d1395eab&fg_pid=5a106c0b-28b5-48e2-ab01-ce747dda340f&fg_beat=671&original_ref=https%3A%2F%2Fhtml5games.com%2F'),
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
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/ElementBlocksTeaser.jpg?alt=media&token=8596a396-5342-4ed2-806b-f0044d95831f',
        gameName: 'Element Block',
        gameURL:
            'https://games.cdn.famobi.com/html5games/e/element-blocks/v290/?fg_domain=play.famobi.com&fg_aid=A1000-100&fg_uid=8c70b6c7-5792-4c40-b891-496eef2fb5ed&fg_pid=5a106c0b-28b5-48e2-ab01-ce747dda340f&fg_beat=649&original_ref=https%3A%2F%2Fhtml5games.com%2F'),
    HTMLGames(
        gameImage:
            'https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/BubbleTower3dTeaser.jpg?alt=media&token=6e451dd7-f9ac-4aa8-a02e-8df569563d72',
        gameName: 'Bubble Tower',
        gameURL:
            'https://games.cdn.famobi.com/html5games/b/bubble-tower-3d/v050/?fg_domain=play.famobi.com&fg_aid=A1000-100&fg_uid=1385d98a-b5f2-4339-bce7-b99a8dd2e8b0&fg_pid=5a106c0b-28b5-48e2-ab01-ce747dda340f&fg_beat=668&original_ref=https%3A%2F%2Fhtml5games.com%2F'),
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
