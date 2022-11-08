import 'package:tictactoe/screens/login.dart';
import 'package:tictactoe/screens/gamehistory.dart';
import 'package:tictactoe/screens/home_screen.dart';
import 'package:tictactoe/screens/leaderboard.dart';
import 'package:tictactoe/screens/profile.dart';
import 'package:tictactoe/screens/shop.dart';
import 'package:tictactoe/screens/skins.dart';
import 'package:tictactoe/screens/splash.dart';

class Routes {
  static final data = {
    "/authscreen": (context) => Login(),
    "/home": (context) => HomeScreenActivity(),
    "/splash": (context) => SplashScreen(),
    "/leaderboard": (context) => LeaderBoardScreen(),
    "/profile": (context) => Profile(),
    "/shop": (context) => ShopScreen(),
    "/skin": (context) => Skins(),
    "/gamehistory": (context) => GameHistory(),
  };
}
