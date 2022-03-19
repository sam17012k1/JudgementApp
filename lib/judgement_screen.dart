import 'package:flutter/material.dart';

class JudgementScreen extends StatefulWidget {
  const JudgementScreen({Key? key}) : super(key: key);

  @override
  _JudgementScreenState createState() => _JudgementScreenState();
}

class _JudgementScreenState extends State<JudgementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Row(
              children: <Widget>[
                Text("Round + ")
              ],
            ),
          )
        ],
      ),
    );
  }
}
