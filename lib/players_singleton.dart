class PlayerSingletone {
  PlayerSingletone._privateConstructor();
  static final PlayerSingletone _instance =
      PlayerSingletone._privateConstructor();

  factory PlayerSingletone() {
    return _instance;
  }

  int numPlayers = 0;
  List<String> playerNames = [];
}
