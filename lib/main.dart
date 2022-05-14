import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notion/auth_page.dart';
import 'package:notion/views/card_list_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  await Hive.openBox('NotionBoards');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: ChangeNotifierProvider<UIChangeNotifier>(
        create: (context) => UIChangeNotifier(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool haveToken = false;

  @override
  void initState() {
    super.initState();
    if (Hive.box('NotionBoards').get('TOKEN') != null) {
      haveToken = true;
    }
  }

  void getToken() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
    if (Hive.box('NotionBoards').get('TOKEN') != null) {
      setState(() {
        haveToken = true;
      });
    }
  }

  AppBar? appBar() {
    if (Provider.of<UIChangeNotifier>(context).loading) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        title: const Text(
          "Notion Boards",
          style: TextStyle(fontSize: 20),
        ),
      );
    }
  }

  Container signInPage() {
    return Container(
      color: Colors.blueGrey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Container(
            child: Text(
              "NOTION\nBOARDS",
              style: TextStyle(color: Colors.white, fontSize: 44),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            child: Text(
              "Sign In",
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () => getToken(),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey.shade600,
              onPrimary: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (haveToken) {
      return Scaffold(
        appBar: appBar(),
        body: CardListView(),
        backgroundColor: Colors.blueGrey.shade900,
      );
    } else {
      return Scaffold(
        appBar: appBar(),
        body: signInPage(),
        backgroundColor: Colors.blueGrey.shade900,
      );
    }
  }
}
