import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/providers/view_mode_provider.dart';

void main() {
  group('ViewModeProvider', () {
    test('initial view mode should be list', () {
      final provider = ViewModeProvider();
      expect(provider.viewMode, ViewMode.list);
    });

    test('toggleViewMode should change from list to grid', () {
      final provider = ViewModeProvider();
      provider.toggleViewMode();
      expect(provider.viewMode, ViewMode.grid);
    });

    test('toggleViewMode twice should revert to list', () {
      final provider = ViewModeProvider();
      provider.toggleViewMode();
      provider.toggleViewMode();
      expect(provider.viewMode, ViewMode.list);
    });
  });
}