import 'roles_controller.dart';
import 'roles.dart';
import 'package:flutter/material.dart';

import 'bottombar.dart';

class SecondChoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondChoiceState();
  }
}

class SecondChoiceState extends State<SecondChoice> {
  TextEditingController textFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Text("Alles auswählen"),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            side: BorderSide(
                                width: 3, color: Colors.blueGrey[300])),
                        onPressed: () {
                          setState(() {
                            RolesController().setAllSecondSelected();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomBar()));
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MaterialButton(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Text("Second hinzufügen"),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              side: BorderSide(
                                  width: 3, color: Colors.blueGrey[300])),
                          onPressed: () async {
                            return showDialog(
                                context: context,
                                child: AlertDialog(
                                    title: Text("Neuer Second!"),
                                    content: SafeArea(
                                        child: TextField(
                                      controller: textFieldController,
                                      decoration: InputDecoration(
                                        helperText: "Hier Second eingeben",
                                      ),
                                    )),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Abbrechen!"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                          child: Text("Hinzufügen!"),
                                          onPressed: () async {
                                            setState(() {
                                              RolesController().addToAllRoles(
                                                  newRole(
                                                      textFieldController.text,
                                                      textFieldController
                                                          .text));
                                              textFieldController.dispose();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          BottomBar()));
                                            });
                                          }),
                                    ]));
                          }),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Text("Auswahl löschen"),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            side: BorderSide(
                                width: 3, color: Colors.blueGrey[300])),
                        onPressed: () {
                          setState(() {
                            RolesController().setAllSecondUnelected();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomBar()));
                          });
                        }),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: RolesController().getAllSecondWidgets(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Roles newRole(String name, String description) {
  RolesProperties properties = new RolesProperties(
      RolesController().getAllRoles().length + 1, name, description, 0, 1, 0);
  Roles newSecond = new Roles(properties);
  return newSecond;
}
