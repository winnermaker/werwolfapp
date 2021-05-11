import 'local_db.dart';

import 'player.dart';
import 'package:flutter/cupertino.dart';

class PlayersController {
  static final PlayersController _instance = PlayersController._internal();
  GlobalKey key;

  factory PlayersController() => _instance;

  PlayersController._internal();

  List<Players> _allPlayers;
  List<Players> getAllPlayers() {
    _allPlayers.sort((a, b) => a.properties.name
        .toLowerCase()
        .compareTo(b.properties.name.toLowerCase()));
    return _allPlayers;
  }

  List<String> getAllSelectedPlayers() {
    List<String> _selectedPlayers = new List<String>();
    List<Players> _players = new List<Players>();
    _players = PlayersController()
        .getAllPlayers()
        .where((test) => test.properties.isselected == 1)
        .toList();

    for (int i = 0; i < _players.length; i++) {
      _selectedPlayers.add(_players[i].properties.name);
    }
    return _selectedPlayers;
  }

  List<Widget> getAllPlayersWidgets() {
    List<Widget> _widgets = new List<Widget>();
    List<Players> _players = new List<Players>();

    _players = PlayersController().getAllPlayers().toList();

    for (int i = 0; i < _players.length; i++) {
      _widgets.add(_players[i]);
    }
    return _widgets;
  }

  void setAllPlayersSelected() {
    List<Players> _players = new List<Players>();
    _players = PlayersController().getAllPlayers().toList();

    for (int i = 0; i < _players.length; i++) {
      _players[i].properties.isselected = 1;
    }
  }

  void setAllPlayersUnelected() {
    List<Players> _players = new List<Players>();
    _players = PlayersController().getAllPlayers().toList();

    for (int i = 0; i < _players.length; i++) {
      _players[i].properties.isselected = 0;
    }
  }

  void setPlayersFromDatabase() async {
    _allPlayers = await DatabaseProvider.db.readAllPlayers();
    //_selectedPlayers = await DatabaseProvider.db.readSelectedPlayers();
  }

  void updatePlayers(Players _players) {
    int index = _allPlayers.indexWhere(
        (players) => players.properties.id == _players.properties.id);
    _allPlayers[index] = _players;
    DatabaseProvider.db.updatePlayer(_allPlayers[index]);
  }

  void removeFromAllPlayers(Players _players) {
    int index = _allPlayers.indexWhere(
        (players) => players.properties.id == _players.properties.id);
    _allPlayers.removeAt(index);
    DatabaseProvider.db.deletePlayer(_players.properties.id);
  }

  void addToAllPlayers(Players _players) {
    _allPlayers.add(_players);
    DatabaseProvider.db.createPlayers(_players);
  }
}
