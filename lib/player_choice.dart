import 'players_controller.dart';
import 'player.dart';
import 'package:flutter/material.dart';

import 'bottombar.dart';

class PlayersChoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlayersChoiceState();
  }
}

class PlayersChoiceState extends State<PlayersChoice> {
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
                            PlayersController().setAllPlayersSelected();
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
                            child: Text("Players hinzufügen"),
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
                                    title: Text("Neuer Players!"),
                                    content: SafeArea(
                                        child: TextField(
                                      controller: textFieldController,
                                      decoration: InputDecoration(
                                        helperText: "Hier Players eingeben",
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
                                              PlayersController()
                                                  .addToAllPlayers(newRole(
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
                            PlayersController().setAllPlayersUnselected();
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
                    children: PlayersController().getAllPlayersWidgets(),
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

Players newRole(String name, String description) {
  PlayersProperties properties = new PlayersProperties(
      PlayersController().getAllPlayers().length + 1, name, 0);
  Players newPlayers = new Players(properties);
  return newPlayers;
}
