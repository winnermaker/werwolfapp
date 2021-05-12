import 'package:flutter/material.dart';
import 'package:werwolfapp/werwolf_icons.dart';

import 'home.dart';
import 'roles_choice.dart';
import 'players_choice.dart';
import 'matches.dart';

class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

int _currentIndex = 0;

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCorrectPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange,
        currentIndex: _currentIndex,
        onTap: (_index) {
          setState(() {
            _currentIndex = _index;
          });
        },
        items: getBottomNavigationBarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 30),
        title: Text("Home "),
      ),
      BottomNavigationBarItem(
        icon: Icon(Werwolf.users, size: 30),
        title: Text("Player"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Werwolf.wolf_howl, size: 30),
        title: Text("Roles"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Werwolf.shuffle_1, size: 30),
        title: Text("Match"),
      ),
    ];
  }

  Widget getCorrectPage(int _index) {
    switch (_index) {
      case 0:
        return Home();
      case 1:
        return PlayersChoice();
      case 2:
        return RolesChoice();
      case 3:
        return Matches();
      default:
        return Home();
    }
  }
}
