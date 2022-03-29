// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertut/judgement_screen.dart';
import 'package:fluttertut/players_singleton.dart';

class NamesScreen extends StatefulWidget {
  // final int numPlayers;

  const NamesScreen({Key? key}) : super(key: key);
  @override
  _NamesScreenState createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  late List controllers;
  final GlobalKey<FormState> _formkey = GlobalKey();
  @override
  initState() {
    super.initState();
    // print(PlayerSingletone().numPlayers);
    controllers = [];
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      controllers.insert(i, TextEditingController());
      // print(i);
    }
  }

  String? validName(String? name) {
    if (name == null) {
      return "Enter a valid name";
    }
    name = name.trim();
    if (name.isEmpty) {
      return "Enter a valid name";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player Names"),
      ),
      body: SingleChildScrollView(
        // physics: AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: PlayerSingletone().numPlayers,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Text("Player " + (index + 1).toString()),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controllers[index],
                          validator: validName,
                          textInputAction:
                              (index < PlayerSingletone().numPlayers)
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  );
                },
              ),
              ButtonTheme(
                  child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    List<String> names = [];
                    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
                      names.insert(i, controllers[i].text.toString().trim());
                    }
                    PlayerSingletone().playerNames = names;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JudgementScreen(),
                        ));
                  }
                },
                child: const Text("Start Round"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
