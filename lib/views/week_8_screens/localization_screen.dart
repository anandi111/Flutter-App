import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/providers/language_provider.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationScreen extends StatefulWidget {
  const LocalizationScreen({Key? key}) : super(key: key);

  @override
  State<LocalizationScreen> createState() => _LocalizationScreenState();
}

class _LocalizationScreenState extends State<LocalizationScreen> {
  initLocalization() async {
    final prefs = await SharedPreferences.getInstance();
    final String? lng = prefs.getString('lng');
    final String? settedLng = prefs.getString('set_language');
    print(settedLng);

    if (settedLng == PlatformDispatcher.instance.locale.languageCode) {
      Provider.of<LanguageProvider>(context, listen: false).changeLanguage(code: lng.toString());
    } else {
      Provider.of<LanguageProvider>(context, listen: false)
          .changeLanguage(code: PlatformDispatcher.instance.locale.languageCode);
      await prefs.setString('set_language', PlatformDispatcher.instance.locale.languageCode.toString());
    }
  }

  @override
  void initState() {
    initLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.localization,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Text(AppLocalizations.of(context)!.welcome,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              )),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setString('lng', 'en');

                    Provider.of<LanguageProvider>(context, listen: false).changeLanguage(code: "en");
                  },
                  iconSize: 80,
                  color: Colors.blue,
                  icon: const Icon(Icons.e_mobiledata)),
              IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setString('lng', 'hi');

                    Provider.of<LanguageProvider>(context, listen: false).changeLanguage(code: "hi");
                  },
                  iconSize: 80,
                  color: Colors.green,
                  icon: const Icon(Icons.h_mobiledata)),
              IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setString('lng', 'gu');

                    Provider.of<LanguageProvider>(context, listen: false).changeLanguage(code: "gu");
                  },
                  iconSize: 80,
                  color: Colors.orange,
                  icon: const Icon(Icons.g_mobiledata))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
