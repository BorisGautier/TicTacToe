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
    "/authscreen": (context) => const Login(),
    "/home": (context) => const HomeScreenActivity(),
    "/splash": (context) => const SplashScreen(),
    "/leaderboard": (context) => const LeaderBoardScreen(),
    "/profile": (context) => const Profile(),
    "/shop": (context) => const ShopScreen(),
    "/skin": (context) => const Skins(),
    "/gamehistory": (context) => GameHistory(),
  };
}
