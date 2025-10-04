// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorGeneral => 'Failed to load data. Please try again later.';

  @override
  String get errorNotFound =>
      'The requested resource could not be found (Error 404).';

  @override
  String get errorInternalServer =>
      'There was a problem with the server. Please try again later (Error 500).';

  @override
  String get errorNoInternet =>
      'No internet connection. Please check your connection and try again.';
}
