import 'package:werwolfapp/werwolf_icons.dart';

import 'roles_controller.dart';
import 'package:flutter/material.dart';
import "dart:math";
import 'home.dart';

class Matches extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MatchesState();
  }
}

List<String> savedRoles = new List<String>();

class MatchesState extends State<Matches> {
  Text temp;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey[300],
            onPressed: () {
              Navigator.pushNamed(context, '/Matches');
            },
            child: Icon(Icons.list)),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.matrix(<double>[
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                0.8,
                0,
              ]),
              image: AssetImage("assets/images/welcome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      0.3,
                      0.6,
                      1
                    ],
                    colors: [
                      Colors.yellow[50],
                      Colors.yellow[100],
                      Colors.yellow,
                      Colors.yellow[700]
                    ])),
            child: RawMaterialButton(
              onPressed: () async {
                return showDialog(
                    context: context,
                    child: (boolList[0] == true)
                        ? (((RolesController().getAllSelectedFirst().isEmpty))
                            ? AlertDialog(
                                title: Text("Achtung!"),
                                content:
                                    Text("Erst Alkohol für Shots auswählen!"),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Ok"))
                                ],
                              )
                            : AlertDialog(
                                title: Text("Dein neues Lieblingsgetränk!"),
                                content: temp = roleDialog(),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Nope!")),
                                  FlatButton(
                                      disabledColor: Colors.grey,
                                      onPressed: roleDialog().data.isEmpty
                                          ? null
                                          : () {
                                              savedRoles.add(temp.data);
                                              Navigator.pop(context);
                                            },
                                      child: Text("Klingt gut !"))
                                ],
                              ))
                        : ((RolesController().getAllSelectedSecond().isEmpty ||
                                RolesController()
                                    .getAllSelectedFirst()
                                    .isEmpty))
                            ? AlertDialog(
                                title: Text("Achtung!"),
                                content:
                                    Text("Erst Alkohol und Second auswählen!"),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Ok"))
                                ],
                              )
                            : AlertDialog(
                                title: Text("Dein neues Lieblingsgetränk!"),
                                content: temp = roleDialog(),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Nope!")),
                                  FlatButton(
                                      onPressed: () {
                                        savedRoles.add(temp.data);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Klingt gut !"))
                                ],
                              ));
              },
              child: Container(
                  child: Icon(
                Werwolf.gitlab,
                size: 150,
                color: Colors.black87,
              )),
              elevation: 15.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360),
                  side: BorderSide(width: 10)),
              constraints: BoxConstraints(minWidth: 250, minHeight: 250),
            ),
          )),
        ),
      ),
    );
  }
}

String randomFirst() {
  final _random = new Random();
  List<String> allSelectedFirst = RolesController().getAllSelectedFirst();
  var yourFirst = allSelectedFirst[_random.nextInt(allSelectedFirst.length)];

  return yourFirst;
}

String randomSecond() {
  final _random = new Random();
  List<String> allSelectedSecond = RolesController().getAllSelectedSecond();

  var yourSecond = allSelectedSecond[_random.nextInt(allSelectedSecond.length)];
  return yourSecond;
}

String randomDrink() {
  final _random = new Random();
  List<String> allSelectedRoles = RolesController().getAllSelectedRoles();

  var yourDrink = allSelectedRoles[_random.nextInt(allSelectedRoles.length)];
  return yourDrink;
}

Text roleDialog() {
  String save;
  if (boolList[0] == true) {
    return Text(randomFirst());
  } else if (boolList[1] == true) {
    return Text(randomFirst() + " und " + randomSecond());
  } else if (boolList[2] == true) {
    save = randomFirst() + " und " + randomSecond();
    if (!savedRoles.contains(save)) {
      return Text(save);
    }
  } else if (boolList[3] == true) {
    return Text(randomFirst() +
        ", " +
        randomSecond() +
        ", " +
        randomFirst() +
        " und " +
        randomDrink());
  } else {
    return Text(randomFirst() + " und " + randomSecond());
  }
}
