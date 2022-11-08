import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/* If value of "wantGoogleAd" is true then it will show Google ad
*  If value of "wantGoogleAd" is false then it will show unity ad*/
const bool wantGoogleAd = false;

//admob/google ad setting
//Example ids
const String rewardedAdID = "ca-app-pub-3940256099942544/5224354917";
const String interstitialAdID = "ca-app-pub-3940256099942544/1033173712";
//add your id here
/*
final String rewardedAdID= Platform.isAndroid?"android reward ad id here ":"ios reward ad id here";
final String interstitialAdID= Platform.isAndroid?"android  interstitial ad id here ":"ios  interstitial ad id here";
*/

//unity ad setting
//final String gameID =  Platform.isAndroid ? "place your android ad gameID  here":"place your android ad gameID  here";

// Example of unity ad ids
//final String gameID = Platform.isAndroid ? "4839511" : "4839510";

//rewarded video ad limit for one day
const int adLimit = 5;

//set which is set in adUnit
const int adRewardAmount = 50;

const int winScore = 20;
const int loseScore = 5;
const int tieScore = 10;

//music setting
const String click = "click.mp3";
const String wingame = "wingame.mp3";
const String tiegame = "wingame.mp3";
const String losegame = "wingame.mp3";
const String dice = "click.mp3";
const String backMusic = "music.mp3";

const String appName = "TicTacToe";

const guestProfilePic =
    "https://firebasestorage.googleapis.com/v0/b/tictactoe-50abc.appspot.com/o/user.png?alt=media&token=0b90503c-e649-4784-9446-61bbf898562c";

final List multiplayerEntryAmount = [25, 50, 100, 200];
final List<String> typeOfLevel = ["Easy", "Medium", "Hard"];

final List noOfRound = ["UN", "TROIS", "CINQ", "SEPT"];
final List noOfRoundDigit = [1, 3, 5, 7];

const countdowntime = 20;
//--Add custom default images to images/ folder
const defaultXskin = "assets/images/cross_skin.png";

const defaultOskin = "assets/images/circle_skin.png";

const String appStoreId = '123456789';

const String appFind =
    "Vous pouvez trouver notre application à partir de l'url ci-dessous \nAndroid:";

const String packageName = 'cm.tbg.tictactoe';
const String androidLink = 'https://play.google.com/store/apps/details?id=';

const String iosPackage = 'cm.tbg.tictactoe';
const String iosLink = 'votre lien ios ici';

List<String> langCode = ["en", "fr", "es", "hi", "ar", "ru", "ja", "de"];

const String privacyText = '''
<p></p><h2><b>Privacy policy</b></h2><a href="https://www.google.com"> goooogllee</a>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce aliquet vulputate tincidunt. Etiam pharetra auctor massa in aliquet. Curabitur a elit ut mauris ullamcorper pulvinar. Phasellus maximus tellus dui, id iaculis lectus fermentum nec. Aliquam odio erat, porttitor vel luctus id, sollicitudin non tortor. Vestibulum neque est, semper vel dui eu, varius aliquam ante. Donec mollis magna sed metus vestibulum consequat. Ut aliquam vulputate ligula, non cursus nibh gravida vitae. Phasellus tellus tellus, accumsan eget tortor laoreet, molestie mollis nisl.<br><br> Donec molestie semper nibh in efficitur. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse dignissim, ex ac iaculis pulvinar, sem nisi scelerisque justo, pulvinar pellentesque ex mi bibendum urna. Quisque ac commodo justo. Integer ut dignissim lectus. Donec a elementum dolor. Vivamus eu nunc vitae mi iaculis imperdiet.<br><br>Ut ullamcorper risus leo, sit amet dictum magna consequat id. Cras eros leo, ullamcorper a vehicula sed, suscipit nec mi. Donec facilisis, urna eu placerat condimentum, nisi quam tincidunt ex, ac auctor nisi metus vel tellus. Curabitur aliquam felis ut ex facilisis eleifend. Mauris dapibus consectetur eros, id venenatis risus pretium eget. Proin sit amet egestas odio. Vivamus interdum, enim nec egestas vulputate, purus dui convallis velit, eu elementum massa nibh at nulla. Morbi ullamcorper accumsan ipsum, id pulvinar purus ultrices vel. In vehicula ultrices diam sit amet dapibus. Integer arcu diam, luctus nec urna eu, iaculis tempor arcu. Sed sit amet pulvinar arcu, eget consequat ante. Curabitur nunc ante, venenatis at tellus eu, euismod vulputate lectus. Vivamus finibus arcu nulla.<br><br>Proin mollis ullamcorper nibh et viverra. Nullam iaculis leo et erat commodo pretium. Phasellus ut sapien vel dui mattis vulputate. Duis non volutpat elit. Nulla vitae mi metus. Donec euismod vulputate risus, ac maximus erat maximus quis. Nullam molestie eget orci ac accumsan. Proin tortor lectus, ultrices id tortor vel, mollis faucibus enim. Proin augue ante, mollis id libero eget, ultrices auctor augue. Nam lacinia dapibus dui, nec bibendum lacus pharetra sit amet. <br><br>Maecenas ut diam urna. Sed consectetur ipsum nec tempus facilisis. Proin gravida est lectus, vel sagittis lorem porta non. Maecenas id tempus ex. Integer ullamcorper, lacus sed interdum imperdiet, purus tellus dapibus ipsum, sed auctor dui dolor at lorem.<br><br>Sed non placerat erat. Nullam diam purus, cursus vitae sapien et, ultrices molestie eros. Aliquam eleifend sem libero, et facilisis tellus sagittis id. Aliquam faucibus, enim ut fermentum aliquam, arcu nunc mollis justo, in pulvinar ante nisl nec ex. Morbi vel eros non tellus tincidunt sagittis. Sed massa felis, finibus non placerat a, pharetra sit amet massa. Proin ornare magna vitae risus accumsan, vel sagittis nisl finibus. Sed sit amet finibus magna. Proin fringilla risus sit amet velit auctor, sit amet faucibus tellus scelerisque.</p>''';
const String termText =
    "<p></p><h2><b>Terms and conditions</b></h2>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce aliquet vulputate tincidunt. Etiam pharetra auctor massa in aliquet. Curabitur a elit ut mauris ullamcorper pulvinar. Phasellus maximus tellus dui, id iaculis lectus fermentum nec. Aliquam odio erat, porttitor vel luctus id, sollicitudin non tortor. Vestibulum neque est, semper vel dui eu, varius aliquam ante. Donec mollis magna sed metus vestibulum consequat. Ut aliquam vulputate ligula, non cursus nibh gravida vitae. Phasellus tellus tellus, accumsan eget tortor laoreet, molestie mollis nisl.<br><br> Donec molestie semper nibh in efficitur. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse dignissim, ex ac iaculis pulvinar, sem nisi scelerisque justo, pulvinar pellentesque ex mi bibendum urna. Quisque ac commodo justo. Integer ut dignissim lectus. Donec a elementum dolor. Vivamus eu nunc vitae mi iaculis imperdiet.<br><br>Ut ullamcorper risus leo, sit amet dictum magna consequat id. Cras eros leo, ullamcorper a vehicula sed, suscipit nec mi. Donec facilisis, urna eu placerat condimentum, nisi quam tincidunt ex, ac auctor nisi metus vel tellus. Curabitur aliquam felis ut ex facilisis eleifend. Mauris dapibus consectetur eros, id venenatis risus pretium eget. Proin sit amet egestas odio. Vivamus interdum, enim nec egestas vulputate, purus dui convallis velit, eu elementum massa nibh at nulla. Morbi ullamcorper accumsan ipsum, id pulvinar purus ultrices vel. In vehicula ultrices diam sit amet dapibus. Integer arcu diam, luctus nec urna eu, iaculis tempor arcu. Sed sit amet pulvinar arcu, eget consequat ante. Curabitur nunc ante, venenatis at tellus eu, euismod vulputate lectus. Vivamus finibus arcu nulla.<br><br>Proin mollis ullamcorper nibh et viverra. Nullam iaculis leo et erat commodo pretium. Phasellus ut sapien vel dui mattis vulputate. Duis non volutpat elit. Nulla vitae mi metus. Donec euismod vulputate risus, ac maximus erat maximus quis. Nullam molestie eget orci ac accumsan. Proin tortor lectus, ultrices id tortor vel, mollis faucibus enim. Proin augue ante, mollis id libero eget, ultrices auctor augue. Nam lacinia dapibus dui, nec bibendum lacus pharetra sit amet. <br><br>Maecenas ut diam urna. Sed consectetur ipsum nec tempus facilisis. Proin gravida est lectus, vel sagittis lorem porta non. Maecenas id tempus ex. Integer ullamcorper, lacus sed interdum imperdiet, purus tellus dapibus ipsum, sed auctor dui dolor at lorem.<br><br>Sed non placerat erat. Nullam diam purus, cursus vitae sapien et, ultrices molestie eros. Aliquam eleifend sem libero, et facilisis tellus sagittis id. Aliquam faucibus, enim ut fermentum aliquam, arcu nunc mollis justo, in pulvinar ante nisl nec ex. Morbi vel eros non tellus tincidunt sagittis. Sed massa felis, finibus non placerat a, pharetra sit amet massa. Proin ornare magna vitae risus accumsan, vel sagittis nisl finibus. Sed sit amet finibus magna. Proin fringilla risus sit amet velit auctor, sit amet faucibus tellus scelerisque.</p>";

const String aboutText =
    "<p>Bienvenue Sur <b>TicTocToe</b><br><br>Made by <b>TBG</b></p>";

const String contactText =
    "<h2><strong>Contactez moi</strong></h2> <p>Pour toute question relative aux produits, aux commandes ou aux services, n'hésitez pas à nous contacter à l'adresse électronique ou au numéro de téléphone officiels indiqués ci-dessous. :</p> <p>&nbsp;</p><p>Call <a href=tel:+237691201946>+237691201946</a></p><p>Email <a href=mailto:tchoukouahaboris@gmail.com>tchoukouahaboris@gmail.com</a></p></p>";

Widget getSvgImage(
    {required String imageName,
    double? height,
    double? width,
    Color? imageColor}) {
  return SvgPicture.asset(
    'assets/svgImages/$imageName.svg',
    height: height ?? 20,
    width: width ?? 20,
    color: imageColor,
  );
}
