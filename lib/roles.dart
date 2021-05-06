import 'bottombar.dart';
import 'roles_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'local_db.dart';

class RolesProperties {
  int id;
  String name;
  String description;
  int isfirstrole;
  int issecondrole;
  int isselected;

  RolesProperties(this.id, this.name, this.description, this.isfirstrole,
      this.issecondrole, this.isselected);
}

class Roles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RolesState();

  final RolesProperties properties;
  Roles(this.properties);
  static const String TABLE_Roles = 'roles';
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_DESCRIPTION = 'description';
  static const String COLUMN_ISFIRSTROLE = 'isFirstRole';
  static const String COLUMN_ISSECONDROLE = 'isSecondRole';
  static const String COLUMN_ISSELECTED = 'isselected';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: properties.name,
      DatabaseProvider.COLUMN_DESCRIPTION: properties.description,
      DatabaseProvider.COLUMN_ISFIRSTROLE: properties.isfirstrole,
      DatabaseProvider.COLUMN_ISSECONDROLE: properties.issecondrole,
      DatabaseProvider.COLUMN_ISSELECTED: properties.isselected
    };

    if (properties.id != null) {
      map[DatabaseProvider.COLUMN_ID] = properties.id;
    }

    return map;
  }

// Roles.fromMap(Map<String, dynamic> map, this.properties) {
//     properties.id = map[DatabaseProvider.COLUMN_ID];
//     properties.name = map[DatabaseProvider.COLUMN_NAME];
//     properties.isalcohol = map[DatabaseProvider.COLUMN_ISALCOHOL];
//     properties.ismixer = map[DatabaseProvider.COLUMN_ISMIXER] ;
//     properties.isselected = map[DatabaseProvider.COLUMN_ISSELECTED] ;

//   }
  factory Roles.fromMap(Map<String, dynamic> map) {
    return Roles(RolesProperties(
      map["id"],
      map["name"],
      map['description'],
      map["isFirstRole"],
      map["isSecondRole"],
      map["isselected"],
    ));
  }
}

class RolesState extends State<Roles> {
  @override
  Widget build(BuildContext context) {
    return Roles();
  }

  Widget Roles() {
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
                                RolesController().removeFromAllRoles(widget);

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
