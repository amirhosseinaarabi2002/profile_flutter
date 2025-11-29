// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get profileTitle => 'Curriculum Vitae';

  @override
  String get name => 'Amirhossein Aarabi';

  @override
  String get job => 'Product & Print Designer';

  @override
  String get location => 'Tehran, Iran';

  @override
  String get summary =>
      'HTTP fetching at runtime, ideal for development. Can also be used in production to reduce app size Font file caching, on device file systemFont bundling in assets. Matching font files found in assets are prioritized over HTTP fetching. Useful for offline-first apps.';

  @override
  String get skills => 'Skills';

  @override
  String get info => 'Personal Information';

  @override
  String get label => 'Save';

  @override
  String get selectedLang => 'Selected Language';

  @override
  String get enLang => 'English';

  @override
  String get faLang => 'Persian';
}
