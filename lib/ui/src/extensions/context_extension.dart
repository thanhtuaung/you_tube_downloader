import 'package:flutter/material.dart';

extension ShortContext<T> on BuildContext {
  Future<T?> pushNamed(String routeName, {Object? arguments}) async {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  void pop([T? result]) async {
    return Navigator.pop(this, result);
  }

  Size get screenSize {
    return MediaQuery.of(this).size;
  }

  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }

  double get screenHeight {
    return MediaQuery.of(this).size.height;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }
}
