// ignore_for_file: constant_identifier_names

import 'package:tictactoe/screens/home_screen.dart';

const String findingOpp = "Recherche d'un joueur adverse....";
const String watchEarn = "Watch Ads and Earn";
const String LAGUAGE_CODE = 'languageCode';

const int plusPurchaseCoin = 10;
const int squarePurchaseCoin = 1000;
const int polygonPurchaseCoin = 1500;
const int hexaPurchaseCoin = 2500;
const int octaPurchaseCoin = 4000;
const int trianglePurchaseCoin = 6000;
const int diamondPurchaseCoin = 8500;

const String c100 = "100 Coins";
const String c500 = "500 Coins";
const String c1000 = "1000 Coins";
const String c2000 = "2000 Coins";
const String c5000 = "5000 Coins";

const String price2 = "100 XAF";
const String price10 = "200 XAF";
const String price50 = "500 XAF";
const String price100 = "1000 XAF";
const String price250 = "2500 XAF";

final Map userSkin = {
  "Classic": {
    'userSkin': "assets/images/cross_skin.png",
    'opponentSkin': "assets/images/circle_skin.png",
    'price': 0
  },
  "Plus": {
    'userSkin': "assets/images/plus_skin.png",
    'opponentSkin': "assets/images/circle_skin.png",
    'price': 100
  },
  "Square": {
    'userSkin': "assets/images/square_skin.png",
    'opponentSkin': "assets/images/circle_skin.png",
    'price': 150
  },
  "Polygon": {
    'userSkin': "assets/images/polygon_skin.png",
    'opponentSkin': "assets/images/cross_skin.png",
    'price': 150
  },
  "Hexagon": {
    'userSkin': "assets/images/hexagon_skin.png",
    'opponentSkin': "assets/images/cross_skin.png",
    'price': 200
  },
  "Octagon": {
    'userSkin': "assets/images/octagon_skin.png",
    'opponentSkin': "assets/images/circle_skin.png",
    'price': 300
  },
  "Triangle": {
    'userSkin': "assets/images/triangle_skin.png",
    'opponentSkin': "assets/images/circle_skin.png",
    'price': 150
  },
  "Diamond": {
    'userSkin': "assets/images/diamond_skin.png",
    'opponentSkin': "assets/images/circle_skin.png",
    'price': 150
  },
  "Offer": {
    'userSkin': "assets/images/cross_skin.png",
    'opponentSkin': "assets/images/octagon_skin.png",
    'price': 0
  },
};

List<String> rtlLanguages = ['ar'];

List<Item> coinList = [
  Item(icon: "assets/images/coin_1.png", name: c100, desc: price2),
  Item(icon: "assets/images/coin_2.png", name: c500, desc: price10),
  Item(icon: "assets/images/coin_3.png", name: c1000, desc: price50),
  Item(icon: "assets/images/coinbag_1.png", name: c2000, desc: price100),
  Item(icon: "assets/images/coinbag_2.png", name: c5000, desc: price250),
  Item(icon: "assets/images/coinbag_2.png", name: c5000, desc: price250),
  Item(icon: "assets/images/watchad_icon.png", name: watchEarn, desc: "")
];
