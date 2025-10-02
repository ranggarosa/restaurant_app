import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/providers/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('initial theme mode should be system', () {
      final provider = ThemeProvider();
      expect(provider.themeMode, ThemeMode.system);
    });

    test('toggleTheme should change theme mode and notify listeners', () {
      // Arrange
      final provider = ThemeProvider();
      bool listenerNotified = false;
      provider.addListener(() {
        listenerNotified = true;
      });

      // Act
      provider.toggleTheme();

      // Assert
      expect(provider.themeMode, isNot(ThemeMode.system));
      expect(listenerNotified, isTrue);
    });
  });
}