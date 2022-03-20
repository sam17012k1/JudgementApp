import 'package:flutter/material.dart';
import 'package:fluttertut/game_singletone.dart';
import 'package:fluttertut/players_singleton.dart';

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
        Text(PlayerSingletone().playerNames[i]),
        Text(widget.playerChoices[i].toString()),
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
      body: Column(
        children: [
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.75),
              1: FractionColumnWidth(0.125),
              2: FractionColumnWidth(0.125),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: _rows,
          ),
          ButtonTheme(
              child: ElevatedButton(
            onPressed: () {
              for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
                _playerScores
                    .add(int.parse(_controllers[i].text.toString().trim()));
              }
              GameSingletone().scoreData.add(_playerScores);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ));
            },
            child: const Text("Start Round"),
          ))
        ],
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
