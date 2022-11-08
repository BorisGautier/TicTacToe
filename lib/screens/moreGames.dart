import 'package:tictactoe/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayGame extends StatefulWidget {
  String gameURL;

  PlayGame({Key? key, required this.gameURL}) : super(key: key);

  @override
  State<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebView(
              zoomEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.gameURL,
              onWebViewCreated: (WebViewController webViewController) {},
              onProgress: (progress) {},
              javascriptChannels: <JavascriptChannel>{
                utils.toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}
