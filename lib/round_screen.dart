import 'package:flutter/material.dart';

class RoundScreen extends StatefulWidget {
  final int numPlayers;
  List playerChoices;
  RoundScreen({Key? key, required this.numPlayers, required this.playerChoices})
      : super(key: key);

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
