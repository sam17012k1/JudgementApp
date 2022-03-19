import 'package:flutter/material.dart';

class NamesScreen extends StatefulWidget {
  final int numPlayers;
  const NamesScreen({Key? key, required this.numPlayers}) : super(key: key);

  @override
  _NamesScreenState createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  late List controllers;
  _NamesScreenState() {
    controllers = [];
    for (var i = 0; i < widget.numPlayers; i++) {
      controllers.insert(i, TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player Names"),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: widget.numPlayers,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Player" + index.toString()),
                  TextFormField(
                    controller: controllers[index],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
