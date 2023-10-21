import 'package:flutter/material.dart';

extension EasyBuildContext on BuildContext {
  TextTheme? get textTheme => Theme.of(this).textTheme;
}
