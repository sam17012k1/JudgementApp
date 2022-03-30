import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertut/game_singletone.dart';
import 'package:fluttertut/players_singleton.dart';
import 'package:fluttertut/round_screen.dart';

class JudgementScreen extends StatefulWidget {
  const JudgementScreen({Key? key}) : super(key: key);

  @override
  _JudgementScreenState createState() => _JudgementScreenState();
}

class _JudgementScreenState extends State<JudgementScreen> {
  late List<TextEditingController> _controllers;
  late List<int> _playerChoices;
  late List<TableRow> _rows;
  final GlobalKey<FormState> _formkey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _controllers = [];
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      _controllers.insert(i, TextEditingController());
    }
    _rows = [];
    _playerChoices = [];
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      _rows.add(TableRow(children: [
        Text(
          PlayerSingletone().playerNames[i],
          textAlign: TextAlign.center,
        ),
        Container(),
        Container(
          child: TextFormField(
            controller: _controllers[i],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.all(15.0),
        ),
        Container(),
      ]));
      _playerChoices.add(0);
    }
  }

  bool roundScoreSumValid = true;

  String? validRoundScore(String? scoreString) {
    if (scoreString == null || scoreString.isEmpty) {
      return "Enter Valid Number";
    }
    int? score = int.tryParse(scoreString);
    if (score == null) {
      return "Enter Valid Number";
    }
    if (score > GameSingletone().gameCards) {
      return "Cannot enter more than number of game cards";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Judge Your cards"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FractionColumnWidth(0.6),
                  1: FractionColumnWidth(0.0),
                  2: FractionColumnWidth(0.2),
                  3: FractionColumnWidth(0.2)
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: _rows,
              ),
              Container(
                  child: Text("Cards Distributed : " +
                      GameSingletone().gameCards.toString()),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5.0))),
              ButtonTheme(
                  child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    int judgmentSum = 0;
                    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
                      _playerChoices[i] =
                          int.parse(_controllers[i].text.toString().trim());
                      judgmentSum += _playerChoices[i];
                    }
                    if (judgmentSum == GameSingletone().gameCards) {
                      setState(() {
                        roundScoreSumValid = false;
                        _formkey.currentState!.save();
                      });
                      return;
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RoundScreen(playerChoices: _playerChoices),
                        ));
                  }
                },
                child: const Text("Start Game"),
              )),
              roundScoreSumValid
                  ? Container()
                  : Text(
                      "Sum of judgments should not be " +
                          GameSingletone().gameCards.toString(),
                      style: const TextStyle(color: Colors.red),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
