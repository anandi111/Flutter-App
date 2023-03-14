import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class GetXServicesScreen extends StatefulWidget {
  GetXServicesScreen({Key? key}) : super(key: key);

  @override
  State<GetXServicesScreen> createState() => _GetXServicesScreenState();
}

class _GetXServicesScreenState extends State<GetXServicesScreen> {
  TextEditingController storageController = TextEditingController();

  @override
  void initState() {
    final box = GetStorage();
    storageController.text = box.read('val');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Getx Services"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              MyButton(
                  label: "Snack Bar",
                  callback: () {
                    Get.snackbar("SnackBar", "This is GetX Fast");
                  }),
              MyButton(
                  label: "Dialog",
                  callback: () async {
                    await Get.dialog(Center(
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff303030),
                                    border: Border.all(width: 0.5, color: Colors.white.withOpacity(0.5))),
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Material(
                                        child: Text(
                                          "Flutter",
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Material(
                                        child: Text(
                                          "You are in getx dialogbox via flutter and it's really easy and convienant",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            left: 85,
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                              alignment: Alignment.center,
                              child: const FlutterLogo(
                                size: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
                  }),
              MyButton(
                  label: "Change Theme",
                  callback: () {
                    if (Get.isDarkMode) {
                      Get.changeTheme(ThemeData.light());
                    } else {
                      Get.changeTheme(ThemeData.dark());
                    }
                  }),
              const Divider(color: Colors.grey),
              const Text(
                "GetX Storage",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: storageController,
                onChanged: (val) {
                  final box = GetStorage();
                  box.write("val", val);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(color: Colors.grey),
              const Text(
                "GetX Localization",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 30,
              ),
              Text(
                'greeting'.tr,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  label: "English",
                  callback: () {
                    Get.updateLocale(const Locale('en', 'US'));
                  }),
              MyButton(
                  label: "Korean",
                  callback: () {
                    Get.updateLocale(const Locale('ko', 'KR'));
                  }),
              MyButton(
                  label: "Japanese",
                  callback: () {
                    Get.updateLocale(const Locale('ja', 'JP'));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
