import 'package:flutter/material.dart';

class FormMatrix extends ChangeNotifier {

  List<List<int>> _grid = [];
  Map<int, List<int>> gridSecond = {};
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController rowController = TextEditingController();
  TextEditingController columnController = TextEditingController();
  int _counterIslands = 0;
  bool _isGenerated = false;


  set isGenerated(bool isGenerated)  {
    _isGenerated = isGenerated;
    notifyListeners();
  }

  bool get isGenerated => _isGenerated;


  set counterIslands(int counterIslands)  {
    _counterIslands = counterIslands;
    notifyListeners();
  }

  int get counterIslands => _counterIslands;

  set grid(List<List<int>> grid)  {
    _grid = grid;
    gridSecond = grid.asMap();
    notifyListeners();
  }

  List<List<int>> get grid => _grid;

}