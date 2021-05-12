import 'bottombar.dart';
import 'players_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'local_db.dart';

class PlayersProperties {
  int id;
  String name;
  int isselected;

  PlayersProperties(this.id, this.name, this.isselected);
}

class Players extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlayersState();

  final PlayersProperties properties;
  Players(this.properties);
  static const String TABLE_Players = 'players';
  static const String COLUMN_ID_Players = "id";
  static const String COLUMN_NAME_Players = "name";
  static const String COLUMN_ISSELECTED_Players = 'isselected';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME_Players: properties.name,
      DatabaseProvider.COLUMN_ISSELECTED_Players: properties.isselected
    };

    if (properties.id != null) {
      map[DatabaseProvider.COLUMN_ID_Players] = properties.id;
    }

    return map;
  }

// Players.fromMap(Map<String, dynamic> map, this.properties) {
//     properties.id = map[DatabaseProvider.COLUMN_ID];
//     properties.name = map[DatabaseProvider.COLUMN_NAME];
//     properties.isalcohol = map[DatabaseProvider.COLUMN_ISALCOHOL];
//     properties.ismixer = map[DatabaseProvider.COLUMN_ISMIXER] ;
//     properties.isselected = map[DatabaseProvider.COLUMN_ISSELECTED] ;

//   }
  factory Players.fromMap(Map<String, dynamic> map) {
    return Players(PlayersProperties(
      map["id"],
      map["name"],
      map["isselected"],
    ));
  }
}

class PlayersState extends State<Players> {
  @override
  Widget build(BuildContext context) {
    return Players();
  }

  Widget Players() {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.blueGrey[100]),
            ),
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              onTap: () async {
                if (widget.properties.isselected == 0) {
                  widget.properties.isselected = 1;
                } else
                  widget.properties.isselected = 0;
                setState(() {});
              },
              leading: Text(widget.properties.name),
              onLongPress: () async {
                return showDialog(
                    context: context,
                    child: AlertDialog(
                        title: Text("Getränk aus der Liste entfernen!"),
                        content: Text(
                            "Hiermit wird das Getränk für immer aus der Liste entfernt !"),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Niemals!")),
                          FlatButton(
                              onPressed: () async {
                                PlayersController()
                                    .removeFromAllPlayers(widget);

                                setState(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              BottomBar()));
                                });
                              },
                              child: Text("Weg damit!"))
                        ]));
              },
              trailing: widget.properties.isselected == 1
                  ? Icon(Icons.favorite, color: Colors.redAccent[700])
                  : Icon(
                      Icons.favorite,
                      color: Color.fromRGBO(189, 195, 199, 1),
                    ),
            )));
  }
}
