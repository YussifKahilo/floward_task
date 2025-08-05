import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../features/layout/main_layout_screen.dart';
import '../features/layout/splash_screen.dart';

class RoutesManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    late Widget screen;

    switch (settings.name) {
      case SplashScreen.route:
        screen = const SplashScreen();
        break;
      case MainLayoutScreen.routeName:
        screen = const MainLayoutScreen();
        break;

      default:
        screen = _undefinedRouteScreen();
        break;
    }

    if (Platform.isIOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (_) => screen,
      );
    } else {
      return PageRouteBuilder(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    }
  }

  static Widget _undefinedRouteScreen() {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text('Undefined Route'),
      ),
    );
  }
}
