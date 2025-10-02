import 'package:flutter/foundation.dart';

enum ViewMode { list, grid }

class ViewModeProvider extends ChangeNotifier {
  ViewMode _viewMode = ViewMode.list;

  ViewMode get viewMode => _viewMode;

  void toggleViewMode() {
    _viewMode = _viewMode == ViewMode.list ? ViewMode.grid : ViewMode.list;
    notifyListeners();
  }
}
