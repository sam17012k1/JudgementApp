import 'dart:html';

import 'package:flutter/material.dart';

class NamesScreen extends StatefulWidget {
  final int numPlayers;

  const NamesScreen({Key? key, required this.numPlayers}) : super(key: key);
  @override
  _NamesScreenState createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  late List controllers;
  @override
  initState() {
    super.initState();
    print(widget.numPlayers);
    controllers = [];
    for (var i = 0; i < widget.numPlayers; i++) {
      controllers.insert(i, TextEditingController());
      print(i);
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
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: widget.numPlayers,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Text("Player " + (index + 1).toString()),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: controllers[index],
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
              List names = [];
              for (var i = 0; i < widget.numPlayers; i++) {
                names.insert(i, controllers[i].text.toString().trim());
              }
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Container();
                },
              ));
            },
            child: const Text("Start Round"),
          ))
        ],
      ),
    );
  }
}
