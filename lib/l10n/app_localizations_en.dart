// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'StreetBite';

  @override
  String get welcomeText => 'Discover Best Street Food Nearby';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get email => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get cart => 'Cart';

  @override
  String get checkout => 'Checkout';
}
