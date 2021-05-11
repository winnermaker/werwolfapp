import 'package:flutter/material.dart';
import 'package:werwolfapp/werwolf_icons.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

List<bool> boolList = [true, false, false];

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/welcome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: options.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return SizedBox(height: 15.0);
                    } else if (index == options.length + 1) {
                      return SizedBox(height: 100.0);
                    }
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: boolList[index - 1]
                            ? Border.all(color: Colors.black26)
                            : null,
                      ),
                      child: ListTile(
                        leading: boolList[index - 1]
                            ? options[index - 1].iconSelected
                            : options[index - 1].icon,
                        title: Text(
                          options[index - 1].title,
                          style: TextStyle(
                            color: boolList[index - 1]
                                ? Colors.black
                                : Colors.grey[600],
                          ),
                        ),
                        subtitle: Text(
                          options[index - 1].subtitle,
                          style: TextStyle(
                            color: boolList[index - 1]
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        onTap: () {
                          for (int i = 0; i <= 2; i++) {
                            boolList[i] = false;
                          }
                          boolList[index - 1] = !boolList[index - 1];

                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Option {
  Icon icon;
  Icon iconSelected;
  String title;
  String subtitle;

  Option({this.icon, this.iconSelected, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.check_box_outline_blank, size: 60.0),
    iconSelected: Icon(
      Werwolf.wolf_howl,
      size: 60,
      color: Colors.orange,
    ),
    title: 'Rolle',
    subtitle: 'Gibt eine zufällige Rolle aus',
  ),
  Option(
    icon: Icon(Icons.check_box_outline_blank, size: 60.0),
    iconSelected: Icon(Werwolf.looks_one, size: 60, color: Colors.yellow),
    title: 'Standart!',
    subtitle: 'Pro Person eine ROlle!',
  ),
  Option(
    icon: Icon(Icons.check_box_outline_blank, size: 60.0),
    iconSelected: Icon(Werwolf.looks_two, size: 60, color: Colors.green),
    title: 'Double Trouble!',
    subtitle: 'Pro Person zwei Rollen',
  ),
];
