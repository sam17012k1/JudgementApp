import 'package:fluttertut/players_singleton.dart';

class GameSingletone {
  GameSingletone._privateConstructor();
  static final GameSingletone _instance = GameSingletone._privateConstructor();

  factory GameSingletone() {
    return _instance;
  }

  int maxCards = 8;
  List<List<int>> _scoreData = [];
  List<int> _totalScoreData = [];
  int numRounds = 0;
  List<List<int>> getScoreData() {
    return _instance._scoreData;
  }

  List<int> getTotalScoreData() {
    return _instance._totalScoreData;
  }

  void addScoreData(List<int> score) {
    if (_totalScoreData.isEmpty) {
      for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
        _totalScoreData.add(0);
      }
    }
    for (var i = 0; i < PlayerSingletone().numPlayers; i++) {
      _totalScoreData[i] += score[i];
    }
    _instance._scoreData.add(score);
    _instance.numRounds++;
  }
}
