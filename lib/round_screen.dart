import 'package:flutter/material.dart';
import 'package:fluttertut/game_singletone.dart';
import 'package:fluttertut/players_singleton.dart';
import 'package:fluttertut/score_screen.dart';

class RoundScreen extends StatefulWidget {
  // final int numPlayers;
  final List<int> playerChoices;
  const RoundScreen({Key? key, required this.playerChoices}) : super(key: key);

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  late List<TextEditingController> _controllers;
  late List<int> _playerScores;
  late List<TableRow> _rows;
  final GlobalKey<FormState> _formkey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _playerScores = [];
    _controllers = [];
    _rows = [];
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      _controllers.insert(i, TextEditingController());
      _rows.add(TableRow(children: [
        Text(
          PlayerSingletone().playerNames[i],
          textAlign: TextAlign.center,
        ),
        Text(
          widget.playerChoices[i].toString(),
          textAlign: TextAlign.center,
        ),
        Container(
          child: TextFormField(
            controller: _controllers[i],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: validScores,
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.all(15.0),
        )
      ]));
      _playerScores.add(0);
    }
  }

  String? validScores(String? scoreString) {
    if (scoreString == null) {
      return "Enter Valid Number";
    }
    int? score = int.tryParse(scoreString);
    if (score == null) {
      return "Enter Valid Number";
    }
    if (score > GameSingletone().gameCards || score < 0) {
      return "Enter number from valid range";
    }
    return null;
  }

  bool scoresCorrect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Round Scores"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FractionColumnWidth(0.5),
                  1: FractionColumnWidth(0.25),
                  2: FractionColumnWidth(0.25),
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
                    int totalScore = 0;
                    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
                      _playerScores[i] =
                          (int.parse(_controllers[i].text.toString().trim()));
                      totalScore += _playerScores[i];
                      int dif =
                          (widget.playerChoices[i] - _playerScores[i]).abs();
                      if (dif == 0) {
                        _playerScores[i] = 10 + _playerScores[i];
                      } else {
                        _playerScores[i] = -dif;
                      }
                    }
                    if (totalScore != GameSingletone().gameCards) {
                      setState(() {
                        scoresCorrect = false;
                        _formkey.currentState!.save();
                      });
                      return;
                    }
                    GameSingletone().addScoreData(_playerScores);
                    if (GameSingletone().gameCards == 3) {
                      GameSingletone().cardDirection = 1;
                    } else if (GameSingletone().gameCards ==
                        GameSingletone().maxCards) {
                      GameSingletone().cardDirection = -1;
                    }
                    GameSingletone().gameCards +=
                        GameSingletone().cardDirection;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScoreScreen(),
                        ));
                  }
                },
                child: const Text("See results"),
              )),
              scoresCorrect
                  ? Container()
                  : Text(
                      "Sum of scores should be " +
                          GameSingletone().gameCards.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
