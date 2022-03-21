import 'package:flutter/material.dart';
import 'package:fluttertut/game_singletone.dart';
import 'package:fluttertut/judgement_screen.dart';
import 'package:fluttertut/players_singleton.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [];
    List<Text> tempRow = [
      const Text(
        "Round",
        textAlign: TextAlign.center,
      )
    ];
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      tempRow.add(Text(
        PlayerSingletone().playerNames[i],
        textAlign: TextAlign.center,
      ));
    }
    rows.add(TableRow(children: tempRow));
    List<List<int>> scores = GameSingletone().getScoreData();
    List<int> totalScores = GameSingletone().getTotalScoreData();
    for (var i = 0; i < GameSingletone().numRounds; i++) {
      tempRow = [];
      tempRow.add(Text(
        (i + 1).toString(),
        textAlign: TextAlign.center,
      ));
      for (var j = 0; j < PlayerSingletone().numPlayers; j++) {
        tempRow.add(Text(
          scores[i][j].toString(),
          textAlign: TextAlign.center,
        ));
      }
      rows.add(TableRow(children: tempRow));
    }
    tempRow = [];
    tempRow.add(const Text("Total"));
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      tempRow.add(Text(
        totalScores[i].toString(),
        textAlign: TextAlign.center,
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
