import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? locale = const Locale("en");

  void changeLanguage({required String code}) {
    if (code == locale!.countryCode) {
      locale = const Locale("code");
      return;
    }

    locale = Locale(code);
    notifyListeners();
  }
}
