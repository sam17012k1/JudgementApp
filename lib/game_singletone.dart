class GameSingletone {
  GameSingletone._privateConstructor();
  static final GameSingletone _instance = GameSingletone._privateConstructor();

  factory GameSingletone() {
    return _instance;
  }

  int maxCards = 8;
  List<List<int>> scoreData = [];
}
