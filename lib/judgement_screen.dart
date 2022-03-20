import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    _controllers = [];
    _rows = [];
    _playerChoices = [];
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      _controllers.insert(i, TextEditingController());
      _rows.add(TableRow(children: [
        Text(PlayerSingletone().playerNames[i]),
        TextFormField(
          controller: _controllers[i],
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        )
      ]));
      _playerChoices.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.75),
              1: FractionColumnWidth(0.25),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: _rows,
          ),
          ButtonTheme(
              child: ElevatedButton(
            onPressed: () {
              for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
                _playerChoices[i] =
                    int.parse(_controllers[i].text.toString().trim());
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RoundScreen(playerChoices: _playerChoices),
                  ));
            },
            child: const Text("Start Round"),
          ))
        ],
      ),
    );
  }
}
