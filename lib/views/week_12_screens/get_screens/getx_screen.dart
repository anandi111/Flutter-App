import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:training_app/controllers/counter_controller.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_12_screens/get_screens/getx_services_screen.dart';

class GetXScreen extends StatefulWidget {
  GetXScreen({Key? key}) : super(key: key);

  @override
  State<GetXScreen> createState() => _GetXScreenState();
}

class _GetXScreenState extends State<GetXScreen> {
  final CounterController controller = Get.put(CounterController());

  @override
  void initState() {
    Get.changeTheme(ThemeData.dark());
    super.initState();
  }

  @override
  void dispose() {
    controller.count.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: MyAppBar(title: "GetX Counter"),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Text(
                    controller.count.value.toString(),
                    style: const TextStyle(fontSize: 100, fontWeight: FontWeight.w600, color: Colors.white),
                  )),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.deepPurple,
                    heroTag: UniqueKey(),
                    onPressed: () {
                      controller.increase();
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.deepPurple,
                    heroTag: UniqueKey(),
                    onPressed: () {
                      controller.decrease();
                    },
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.deepPurpleAccent.withOpacity(0.5)),
                  onPressed: () {
                    Get.to(() => GetXServicesScreen());
                  },
                  child: const Text(
                    "more",
                    style: TextStyle(decoration: TextDecoration.underline, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'greeting': '안녕하세요',
        },
        'ja_JP': {
          'greeting': 'こんにちは',
        },
        'en_US': {
          'greeting': 'Hello',
        },
      };
}
