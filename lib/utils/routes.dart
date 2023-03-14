import 'package:flutter/material.dart';
import 'package:training_app/views/home_page.dart';
import 'package:training_app/views/week_11_screens/connection_screen.dart';
import 'package:training_app/views/week_11_screens/file_operation/add_file_screen.dart';
import 'package:training_app/views/week_11_screens/file_operation/file_screen.dart';
import 'package:training_app/views/week_11_screens/method_channel_screen.dart';
import 'package:training_app/views/week_11_screens/slivers_screen.dart';
import 'package:training_app/views/week_12_screens/bloc_screens/bloc_screen.dart';
import 'package:training_app/views/week_12_screens/bloc_screens/simple_bloc_screen.dart';
import 'package:training_app/views/week_12_screens/get_screens/getx_screen.dart';
import 'package:training_app/views/week_12_screens/provider_screens/provider_screen.dart';
import 'package:training_app/views/week_12_screens/redux_screens/redux_screen.dart';
import 'package:training_app/views/week_12_screens/week_12_page.dart';
import 'package:training_app/views/week_1_screens/dart_programming_screen.dart';
import 'package:training_app/views/week_1_screens/flutter_intro_screen.dart';
import 'package:training_app/views/week_1_screens/life_cycle_screen.dart';
import 'package:training_app/views/week_1_screens/navigation_screen.dart';
import 'package:training_app/views/week_1_screens/pages_for_navigation/page_1.dart';
import 'package:training_app/views/week_1_screens/pages_for_navigation/page_2.dart';
import 'package:training_app/views/week_1_screens/pass_data_bet_views_screen.dart';
import 'package:training_app/views/week_1_screens/week_1_page.dart';
import 'package:training_app/views/week_2_screens/property_pages/custom_control_screen.dart';
import 'package:training_app/views/week_2_screens/property_pages/inbuilt_properties_screen.dart';
import 'package:training_app/views/week_2_screens/layout_control_pages/bottom_navigationbar.dart';
import 'package:training_app/views/week_2_screens/layout_control_pages/custom_screen.dart';
import 'package:training_app/views/week_2_screens/layout_control_pages/drawer.dart';
import 'package:training_app/views/week_2_screens/layout_control_pages/tabbar.dart';
import 'package:training_app/views/week_2_screens/layout_control_screen.dart';
import 'package:training_app/views/week_2_screens/properties_screen.dart';
import 'package:training_app/views/week_2_screens/week_2_page.dart';
import 'package:training_app/views/week_2_screens/widget_screen.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/alert_dialog.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/date_picker.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/dropdown_button.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/gridview.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/image.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/listview.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/popupmenu_button.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/slider.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/snackbar.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/stack.dart';
import 'package:training_app/views/week_2_screens/widgets_pages/time_picker.dart';
import 'package:training_app/views/week_3_screens/add_database_screen.dart';
import 'package:training_app/views/week_3_screens/api_calling_screen.dart';
import 'package:training_app/views/week_3_screens/crud_api_calling_pages/add_edit_user_screen.dart';
import 'package:training_app/views/week_3_screens/crud_api_calling_screen.dart';
import 'package:training_app/views/week_3_screens/darg_and_drop_functionality_screen.dart';
import 'package:training_app/views/week_3_screens/database_screen.dart';
import 'package:training_app/views/week_3_screens/gesture_screen.dart';
import 'package:training_app/views/week_3_screens/image_picker_screen.dart';
import 'package:training_app/views/week_3_screens/test.dart';
import 'package:training_app/views/week_3_screens/week_3_page.dart';
import 'package:training_app/views/week_4_screens/inapp_webview_screen.dart';
import 'package:training_app/views/week_4_screens/lazy_loading_screen.dart';
import 'package:training_app/views/week_4_screens/sent_call_sms_email_screen.dart';
import 'package:training_app/views/week_4_screens/sent_pages/call_screen.dart';
import 'package:training_app/views/week_4_screens/sent_pages/email_screen.dart';
import 'package:training_app/views/week_4_screens/sent_pages/sms_screen.dart';
import 'package:training_app/views/week_4_screens/week_4_page.dart';
import 'package:training_app/views/week_5_screens/on_audio_query_screen.dart';
import 'package:training_app/views/week_5_screens/record_display_screen.dart';
import 'package:training_app/views/week_5_screens/social_media_login_screen.dart';
import 'package:training_app/views/week_5_screens/sound_disply_screen.dart';
import 'package:training_app/views/week_5_screens/sound_recording_screen.dart';
import 'package:training_app/views/week_5_screens/video_player_screen.dart';
import 'package:training_app/views/week_5_screens/week_5_page.dart';
import 'package:training_app/views/week_6_screens/facebook_ads_screen.dart';
import 'package:training_app/views/week_6_screens/google_ads_screen.dart';
import 'package:training_app/views/week_6_screens/share_screen.dart';
import 'package:training_app/views/week_6_screens/week_6_page.dart';
import 'package:training_app/views/week_7_screens/in_app_purchase_screen.dart';
import 'package:training_app/views/week_7_screens/in_app_screen.dart';
import 'package:training_app/views/week_8_screens/icon_density_screen.dart';
import 'package:training_app/views/week_7_screens/payment_gateway_screen.dart';
import 'package:training_app/views/week_7_screens/pull_to_refresh_screen.dart';
import 'package:training_app/views/week_7_screens/stripe_payment_gateways_screen.dart';
import 'package:training_app/views/week_8_screens/action_sheet_and_popover_screen.dart';
import 'package:training_app/views/week_8_screens/animation_screen.dart';
import 'package:training_app/views/week_8_screens/localization_screen.dart';
import 'package:training_app/views/week_8_screens/responsive_screen.dart';
import 'package:training_app/views/week_8_screens/week_8_page.dart';
import 'package:training_app/views/week_9&10_screens/analytics_screen.dart';
import 'package:training_app/views/week_9&10_screens/authentication/change_password_page.dart';
import 'package:training_app/views/week_9&10_screens/authentication/login_page.dart';
import 'package:training_app/views/week_9&10_screens/authentication/sign_up_page.dart';
import 'package:training_app/views/week_9&10_screens/authentication/welcome_page.dart';
import 'package:training_app/views/week_9&10_screens/crashlytics_screen.dart';
import 'package:training_app/views/week_9&10_screens/dynamic_link_screen.dart';
import 'package:training_app/views/week_9&10_screens/firebase%20database/add_data.dart';
import 'package:training_app/views/week_9&10_screens/firebase%20database/firebase_database_screen.dart';
import 'package:training_app/views/week_9&10_screens/notification_screen.dart';
import 'package:training_app/views/week_9&10_screens/realtime%20database/read_data_screen.dart';
import 'package:training_app/views/week_9&10_screens/realtime%20database/realtime_database_screen.dart';
import 'package:training_app/views/week_9&10_screens/week_9_page.dart';
import '../views/week_11_screens/week_11_page.dart';
import '../views/week_1_screens/pages_for_navigation/page_3.dart';
import '../views/week_1_screens/pages_for_navigation/page_4.dart';
import '../views/week_3_screens/video_picker_screen.dart';
import '../views/week_4_screens/map_integration_screen.dart';
import '../views/week_7_screens/custom_camera_screen.dart';
import '../views/week_7_screens/week_7_page.dart';

class Routes {
  Routes._();

  static Routes routes = Routes._();

  Map<String, Widget Function(BuildContext)> routesMap = {
    "/": (context) => const HomePage(),

    //week 1...
    "week_1_page": (context) => const Week1Page(),
    "flutter_intro_screen": (context) => const FlutterIntroScreen(),
    "life_cycle_screen": (context) => const LifeCycleScreen(),
    "navigation_screen": (context) => const NavigationScreen(),
    "page_1": (context) => const Page1(),
    "page_2": (context) => const Page2(),
    "page_3": (context) => const Page3(),
    "page_4": (context) => const Page4(),
    "dart_programming_screen": (context) => const DartProScreen(),
    "pass_data_screen": (context) => const PassDataScreen(),

    //week 2...
    "week_2_page": (context) => const Week2Page(),
    "widget_screen": (context) => const WidgetScreen(),
    "image_screen": (context) => const ImageScreen(),
    "stack_screen": (context) => const StackScreen(),
    "listview_screen": (context) => const ListViewScreen(),
    "gridview_screen": (context) => const GridViewScreen(),
    "slider_screen": (context) => const SliderScreen(),
    "dropdown_button_screen": (context) => const DropDownButtonScreen(),
    "popupmenu_button_screen": (context) => const PopupMenuButtonScreen(),
    "date_picker_screen": (context) => const DatePickerScreen(),
    "time_picker_screen": (context) => const TimePickerScreen(),
    "dialog_screen": (context) => const DialogScreen(),
    "snackbar_screen": (context) => const SnackBarScreen(),
    "layout_control_screen": (context) => const LayoutControlScreen(),
    "tabbar_screen": (context) => const TabBarScreen(),
    "drawer_screen": (context) => const DrawerScreen(),
    "bottom_navigationbar_screen": (context) => const BottomNavigationBarScreen(),
    "custom_screen": (context) => const CustomScreen(),
    "properties_screen": (context) => const PropertiesScreen(),
    "inbuilt_properties_screen": (context) => const InbuiltProprtiesScreen(),
    "custom_control_properties_screen": (context) => const CustomControlProprtiesScreen(),

    //week 3...
    "week_3_page": (context) => const Week3Page(),
    "gesture_screen": (context) => const GestureScreen(),
    "image_picker_screen": (context) => const ImagePickerScreen(),
    "video_picker_screen": (context) => const VideoPickerScreen(),
    "drag_drop_functionality_screen": (context) => const DargAndDropScreen(),
    "database_screen": (context) => const DataBaseScreen(),
    "add_database_screen": (context) => const AddDataBaseScreen(),
    "api_calling_screen": (context) => const ApiCallingScreen(),
    "crud_api_calling_screen": (context) => const CRUDAPICallingScreen(),
    // "add_edit_user_screen": (context) => const AddEditUserScreen(),
    "test_screen": (context) => const TestScreen(),

    //week 4...
    "week_4_page": (context) => const Week4Page(),
    "lazy_loading_screen": (context) => LazyLoadingScreen(),
    "map_integration_screen": (context) => const MapItegrationScreen(),
    "inapp_webview_screen": (context) => const InAppWebViewScreen(),
    "sent_call_sms_email_screen": (context) => const SentCallSMSEmailScreen(),
    "call_screen": (context) => const CallScreen(),
    "sms_screen": (context) => const SMSScreen(),
    "email_screen": (context) => const EmailScreen(),

    //week 5...
    "week_5_page": (context) => const Week5Page(),
    "sound_recording_screen": (context) => const SoundRecordingScreen(),
    "record_display_screen": (context) => const RecordDisplayScreen(),
    "sound_display_screen": (context) => const SoundDisplayScreen(),
    "on_audio_query_screen": (context) => OnAudioQueryScreen(title: "On Audio Query"),
    "video_player_screen": (context) => const VideoPlayerScreen(),
    "social_media_login_screen": (context) => const SocialMediaLogInScreen(),

    //week 6.....
    "week_6_page": (context) => const Week6Page(),
    "share_screen": (context) => const ShareScreen(),
    "google_ads_screen": (context) => const GoogleAdsScreen(),
    "facebook_ads_screen": (context) => const FacebookAdsScreen(),

    //week 7...
    "week_7_page": (context) => const Week7Page(),
    "custom_camera_screen": (context) => const CustomCameraScreen(),
    "pull_to_refresh_screen": (context) => const PullToRefreshScreen(),
    "in_app_purchase_screen": (context) => const InAppPurchaseScreen(),
    "in_app_screen": (context) => const InAppScreen(),
    "payment_gateway_screen": (context) => const PaymentGatewayScreen(),
    "stripe_payment_gateway_screen": (context) => const StripePaymentGatewayScreen(),

    //week 8...
    "week_8_page": (context) => const Week8Page(),
    "animation_screen": (context) => const AnimationScreen(),
    "icon_density_screen": (context) => const IconDensityScreen(),
    "responsive_screen": (context) => const ResponsiveScreen(),
    "localization_screen": (context) => const LocalizationScreen(),
    "action_sheet_and_popover_screen": (context) => const ActionSheetANDPopoverScreen(),

    //week 9&10...
    "week_9_page": (context) => const Week9Page(),
    "login_page": (context) => LoginPage(),
    "sign_up_page": (context) => const SignUpPage(),
    "change_password_page": (context) => const ChangePasswordPage(),
    "welcome_page": (context) => const WelcomePage(),
    "realtime_database_screen": (context) => const RealTimeDataBaseScreen(),
    "read_data_screen": (context) => const ReadDataScreen(),
    "firebase_database_screen": (context) => const FireBaseDataBaseScreen(),
    "add_data_screen": (context) => const AddDataScreen(),
    "crashlytics_screen": (context) => const CrashlyticsScreen(),
    "analytics_screen": (context) => const AnalyticsScreen(),
    "dynamic_link_screen": (context) => const DynamicLinkScreen(),
    "notification_screen": (context) => const NotificationScreen(),

    //week 11...
    "week_11_page": (context) => const Week11Page(),
    "sliver_screen": (context) => const SliverScreen(),
    "file_screen": (context) => const FileScreen(),
    "add_file_screen": (context) => const AddFileScreen(),
    "method_channel_screen": (context) => const MethodChannelScreen(),
    "connection_screen": (context) => const ConnectionScreen(),

    //week 12...
    "week_12_page": (context) => const Week12Page(),
    "provider_screen": (context) => const ProviderScreen(),
    "getx_screen": (context) => GetXScreen(),
    "bloc_screen": (context) => const BlocScreen(),
    "simple_bloc_screen": (context) => const SimpleBlocScreen(),
    "redux_screen": (context) => ReduxScreen(),
  };
}
