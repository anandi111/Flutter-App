import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/helpers/firebase_messaging_helper.dart';
import 'package:training_app/providers/language_provider.dart';
import 'package:training_app/utils/routes.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:redux/redux.dart';
import 'package:training_app/views/week_12_screens/redux_screens/redux_screen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();

  RequestConfiguration configuration = RequestConfiguration(testDeviceIds: ["33BE2250B43518CCDA7DE426D04EE231"]);
  MobileAds.instance.updateRequestConfiguration(configuration);

  // final prefs = await SharedPreferences.getInstance();
  // final String? lng = prefs.getString('lng');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  // AdSettings.addTestDevice("72e67b53-d927-4eb2-86b2-d378c76683b7");

  cameras = await availableCameras();

  await GetStorage.init();
  final store = Store<int>(counterReducer, initialState: 0);

  Stripe.publishableKey =
      "pk_test_51MMpGRSHBtlcEYALA8hrrQpnf0a7y4gT22hELS8J1p1ZrTp60sDmo11hWxqBsjUamgcQVfdNu0jSTgYHWQ7N1oef00anVmLPB4";

  await FireBaseMessagingHelper.fireBaseMessagingHelper.initializeNotification();

  // you can use Provider instead of ChangeNotifierProvider...
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    lazy: true,
    child: Consumer<LanguageProvider>(
      builder: (context, value, child) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        //change this line to change language...
        locale: value.locale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('hi', ''),
          Locale('gu', ''),
        ],
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        initialRoute: "/",
        routes: Routes.routes.routesMap,
      ),
    ),
  ));
}
