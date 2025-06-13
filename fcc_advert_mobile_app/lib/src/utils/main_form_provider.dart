import 'package:flutter/cupertino.dart';

class MainformProvider extends ChangeNotifier{
  late String _area;

  String get area => _area;

  set area(String value) {
    _area = value;
    notifyListeners();
  }
}