import 'package:flutter/material.dart';
import 'package:fluttertut/game_singletone.dart';
import 'package:fluttertut/judgement_screen.dart';
import 'package:fluttertut/players_singleton.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [];
    List<Widget> tempRow = [
      Container(
        padding: const EdgeInsets.all(3),
        child: const Text(
          "Round",
          textAlign: TextAlign.center,
        ),
      )
    ];
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      tempRow.add(Container(
        padding: const EdgeInsets.all(3),
        child: Text(
          PlayerSingletone().playerNames[i],
          textAlign: TextAlign.center,
        ),
      ));
    }
    rows.add(TableRow(children: tempRow));
    List<List<int>> scores = GameSingletone().getScoreData();
    List<int> totalScores = GameSingletone().getTotalScoreData();
    for (var i = 0; i < GameSingletone().numRounds; i++) {
      tempRow = [];
      tempRow.add(Container(
        padding: const EdgeInsets.all(3),
        child: Text(
          (i + 1).toString(),
          textAlign: TextAlign.center,
        ),
      ));
      for (var j = 0; j < PlayerSingletone().numPlayers; j++) {
        tempRow.add(Container(
          padding: const EdgeInsets.all(3),
          child: Text(
            scores[i][j].toString(),
            textAlign: TextAlign.center,
          ),
        ));
      }
      rows.add(TableRow(children: tempRow));
    }
    tempRow = [];
    tempRow.add(Container(
      padding: const EdgeInsets.all(3),
      child: const Text(
        "Total",
        textAlign: TextAlign.center,
      ),
    ));
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      tempRow.add(Container(
        padding: const EdgeInsets.all(3),
        child: Text(
          totalScores[i].toString(),
          textAlign: TextAlign.center,
        ),
      ));
    }
    rows.add(TableRow(children: tempRow));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scores"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
            ),
            Table(
              defaultColumnWidth: const FlexColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: rows,
            ),
            ButtonTheme(
                child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JudgementScreen()));
              },
              child: const Text("Start Next Round"),
            ))
          ],
        ),
      ),
    );
  }
}
