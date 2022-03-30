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
  final _myController = TextEditingController();
  final _myController1 = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  String? validPlayerCount(String? count) {
    if (count == null) {
      return "Enter a number";
    } else {
      int? c = int.tryParse(count);
      if (c == null) {
        return "Enter a valid number";
      }
    }
    return null;
  }

  String? validCardCount(String? count) {
    if (count == null) {
      return "Enter a number";
    }
    int? c = int.tryParse(count);
    if (c == null) {
      return "Enter a valid number";
    }
    return null;
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
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: _myController,
                  decoration: const InputDecoration(
                    hintText: "Number of Players",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: validPlayerCount,
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
              TextFormField(
                controller: _myController1,
                decoration: const InputDecoration(
                    label: Text("Number of starting cards(max cards)")),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: validCardCount,
              ),
              ButtonTheme(
                //minWidth: MediaQuery.of(context).size.width-40,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        int value =
                            int.parse(_myController.text.toString().trim());
                        PlayerSingletone().numPlayers = value;
                        int value1 =
                            int.parse(_myController1.text.toString().trim());
                        GameSingletone().maxCards = value1;
                        GameSingletone().gameCards = value1;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NamesScreen()));
                      }
                    },
                    child: const Text("Start game")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
