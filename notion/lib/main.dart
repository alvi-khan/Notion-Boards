import 'package:flutter/material.dart';
import 'package:notion/views/card_list_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: CardListView(),
      backgroundColor: Colors.blueGrey.shade900,
    );
  }
}
