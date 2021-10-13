import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/common/theme.dart';
import 'package:ad_book_2/screens/test.dart';

class TestModel extends ChangeNotifier {
  int triggerfliters = 0;

  void increaseValue2() {
    triggerfliters++;
    notifyListeners();
  }

  void increaseValue1() {
    triggerfliters--;
    notifyListeners();
  }
}
