import 'package:flutter/material.dart';
import 'Constants/strings.dart';
import 'Presentation/screens/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) =>  LoginScreen(),
        );
    }
  }
}
