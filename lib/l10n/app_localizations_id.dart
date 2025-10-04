// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get errorGeneral => 'Gagal memuat data. Silakan coba lagi nanti.';

  @override
  String get errorNotFound =>
      'Sumber daya yang diminta tidak dapat ditemukan (Error 404).';

  @override
  String get errorInternalServer =>
      'Terjadi masalah pada server. Silakan coba lagi nanti (Error 500).';

  @override
  String get errorNoInternet =>
      'Tidak ada koneksi internet. Silakan periksa koneksi Anda dan coba lagi.';
}
