import 'package:flutter/material.dart';
import 'package:fluttertut/game_singletone.dart';
import 'package:fluttertut/names_screen.dart';
import 'package:fluttertut/players_singleton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final myController1 = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Judgement Scorer",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                  hintText: "Number of Players",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Starting Cards",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: myController1,
              decoration: const InputDecoration(
                  label: Text("Number of starting cards(max cards")),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
            ),
            ButtonTheme(
              //minWidth: MediaQuery.of(context).size.width-40,
              child: ElevatedButton(
                  onPressed: () {
                    int value = int.parse(myController.text.toString().trim());
                    PlayerSingletone().numPlayers = value;
                    int value1 =
                        int.parse(myController1.text.toString().trim());
                    GameSingletone().maxCards = value1;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NamesScreen()));
                  },
                  child: const Text("Start game")),
            ),
          ],
        ),
      ),
    );
  }
}
