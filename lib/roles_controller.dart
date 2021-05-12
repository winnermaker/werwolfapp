import 'local_db.dart';

import 'roles.dart';
import 'package:flutter/cupertino.dart';

class RolesController {
  static final RolesController _instance = RolesController._internal();
  GlobalKey key;

  factory RolesController() => _instance;

  RolesController._internal();

  List<Roles> _allRoles;
  List<Roles> getAllRoles() {
    _allRoles.sort((a, b) => a.properties.name
        .toLowerCase()
        .compareTo(b.properties.name.toLowerCase()));
    return _allRoles;
  }

  List<String> getAllSelectedRoles() {
    List<String> _selectedRoles = new List<String>();
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.isselected == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _selectedRoles.add(_roles[i].properties.name);
    }
    return _selectedRoles;
  }

  List<String> getAllFirstRoles() {
    List<String> _first = new List<String>();
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.isfirstrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _first.add(_roles[i].properties.name);
    }

    return _first;
  }

  List<String> getAllSecondRoles() {
    List<String> _second = new List<String>();
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.issecondrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _second.add(_roles[i].properties.name);
    }

    return _second;
  }

  List<String> getAllSelectedSecond() {
    List<String> _second = new List<String>();
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.issecondrole == 1)
        .where((test) => test.properties.isselected == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _second.add(_roles[i].properties.name);
    }

    return _second;
  }

  List<int> getAllSecondIds() {
    List<int> _id = new List<int>();
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.issecondrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _id.add(_roles[i].properties.id);
    }
    return _id;
  }

  List<Widget> getAllSecondWidgets() {
    List<Widget> _widgets = new List<Widget>();
    List<Roles> _roles = new List<Roles>();

    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.issecondrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _widgets.add(_roles[i]);
    }
    return _widgets;
  }

  List<Widget> getAllRolesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    List<Roles> _roles = new List<Roles>();

    _roles = RolesController().getAllRoles().toList();

    for (int i = 0; i < _roles.length; i++) {
      _widgets.add(_roles[i]);
    }
    return _widgets;
  }

  void setAllSecondSelected() {
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.issecondrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _roles[i].properties.isselected = 1;
    }
  }

  void setAllRolesSelected() {
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController().getAllRoles().toList();

    for (int i = 0; i < _roles.length; i++) {
      _roles[i].properties.isselected = 1;
    }
  }

  void setAllRolesUnselected() {
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController().getAllRoles().toList();

    for (int i = 0; i < _roles.length; i++) {
      _roles[i].properties.isselected = 0;
    }
  }

  void setAllSecondUnelected() {
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.issecondrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _roles[i].properties.isselected = 0;
    }
  }

  List<String> getAllSelectedFirst() {
    List<String> _first = new List<String>();
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.isfirstrole == 1)
        .where((test) => test.properties.isselected == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _first.add(_roles[i].properties.name);
    }

    return _first;
  }

  List<Widget> getAllFirstWidgets() {
    List<Widget> _widgets = new List<Widget>();
    List<Roles> _roles = new List<Roles>();

    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.isfirstrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _widgets.add(_roles[i]);
    }
    return _widgets;
  }

  void setAllFirstSelected() {
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.isfirstrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _roles[i].properties.isselected = 1;
    }
  }

  void setAllFirstUnselected() {
    List<Roles> _roles = new List<Roles>();
    _roles = RolesController()
        .getAllRoles()
        .where((test) => test.properties.isfirstrole == 1)
        .toList();

    for (int i = 0; i < _roles.length; i++) {
      _roles[i].properties.isselected = 0;
    }
  }

  void setRolesFromDatabase() async {
    _allRoles = await DatabaseProvider.db.readAllRoles();
    //_selectedRoles = await DatabaseProvider.db.readSelectedRoles();
  }

  void updateRoles(Roles _roles) {
    int index = _allRoles
        .indexWhere((roles) => roles.properties.id == _roles.properties.id);
    _allRoles[index] = _roles;
    DatabaseProvider.db.update(_allRoles[index]);
  }

  void removeFromAllRoles(Roles _roles) {
    int index = _allRoles
        .indexWhere((roles) => roles.properties.id == _roles.properties.id);
    _allRoles.removeAt(index);
    DatabaseProvider.db.delete(_roles.properties.id);
  }

  void addToAllRoles(Roles _roles) {
    _allRoles.add(_roles);
    DatabaseProvider.db.createRoles(_roles);
  }
}
