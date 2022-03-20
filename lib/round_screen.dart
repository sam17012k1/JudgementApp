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
  @override
  void initState() {
    super.initState();
    _controllers = [];
    _rows = [];
    _playerScores = [];
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
        TextFormField(
          controller: _controllers[i],
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        )
      ]));
      _playerScores.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Round Scores"),
      ),
      body: SingleChildScrollView(
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
            ButtonTheme(
                child: ElevatedButton(
              onPressed: () {
                for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
                  _playerScores[i] =
                      (int.parse(_controllers[i].text.toString().trim()));
                  int dif = (widget.playerChoices[i] - _playerScores[i]).abs();
                  if (dif == 0) {
                    _playerScores[i] = 10 + _playerScores[i];
                  } else {
                    _playerScores[i] = -dif;
                  }
                }
                GameSingletone().addScoreData(_playerScores);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScoreScreen(),
                    ));
              },
              child: const Text("See results"),
            ))
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       ListView.builder(
      //         physics: const NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         padding: const EdgeInsets.all(8),
      //         itemCount: PlayerSingletone().numPlayers,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Text(PlayerSingletone().playerNames[index]),
      //               Container(
      //                 width: 10,
      //               ),
      //               Expanded(
      //                 child: TextFormField(
      //                   controller: _controllers[index],
      //                   textInputAction: TextInputAction.next,
      //                 ),
      //               )
      //             ],
      //           );
      //         },
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
