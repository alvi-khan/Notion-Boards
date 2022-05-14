import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notion/authentication/AuthPage.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.onSignIn, required this.context}) : super(key: key);
  final Function onSignIn;
  final BuildContext context;

  void getToken() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
    if (Hive.box('NotionBoards').get('TOKEN') != null) {
      onSignIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          const Text(
            "NOTION\nBOARDS",
            style: TextStyle(color: Colors.white, fontSize: 44),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            child: const Text(
              "Sign In",
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () => getToken(),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey.shade600,
              onPrimary: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

}