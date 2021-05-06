import 'saved.dart';
import 'welcome.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/Welcome':
        return MaterialPageRoute(builder: (_) => Welcome());
      case '/Saved':
        return MaterialPageRoute(builder: (_) => Saved());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('No matching route found!'),
        ),
      );
    });
  }
}
