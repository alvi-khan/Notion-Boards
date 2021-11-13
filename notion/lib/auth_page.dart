import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'database.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String clientID = dotenv.env['CLIENT_ID']!;
  String authorizationURL = 'https://api.notion.com/v1/oauth/authorize';
  String redirectURL = 'https://www.google.com/';
  String accessCode = '';

  Future<bool> getAuthCode(String requestURL) async {
    String? code = Uri.parse(requestURL).queryParameters['code'];
    if (code != null) {
      setState(() {
        accessCode = code;
      });
      await Database.getToken(code);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var accessCodeURL =
        "$authorizationURL?owner=user&client_id=$clientID&redirect_uri=$redirectURL&response_type=code";
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: WebView(
          initialUrl: accessCodeURL,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) async {
            if (request.url.startsWith('https://www.google.com')) {
              await getAuthCode(request.url);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
