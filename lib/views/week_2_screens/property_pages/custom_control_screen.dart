import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_2_screens/property_pages/properties/my_check_box.dart';
import 'package:training_app/views/week_2_screens/property_pages/properties/my_radio_button.dart';
import 'package:training_app/views/week_2_screens/property_pages/properties/my_switch.dart';

class CustomControlProprtiesScreen extends StatefulWidget {
  const CustomControlProprtiesScreen({Key? key}) : super(key: key);

  @override
  State<CustomControlProprtiesScreen> createState() => _CustomControlProprtiesScreenState();
}

enum Mode { System, Dark, Light }

enum Direction { Left, Right }

class _CustomControlProprtiesScreenState extends State<CustomControlProprtiesScreen> {
  bool isTest = false;
  bool isEnglishSelected = false;
  bool isHindiSelected = false;
  bool isGujaratiSelected = false;

  Mode mode = Mode.System;
  Direction direction = Direction.Left;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Custom Control Properties"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Check Box",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyCheckBox(
                        label: "English",
                        icon: Icons.e_mobiledata,
                        isTap: isEnglishSelected,
                        callBack: () {
                          setState(() {
                            isEnglishSelected = !isEnglishSelected;
                          });
                        }),
                    MyCheckBox(
                        label: "Hindi",
                        icon: Icons.h_mobiledata,
                        isTap: isHindiSelected,
                        callBack: () {
                          setState(() {
                            isHindiSelected = !isHindiSelected;
                          });
                        }),
                    MyCheckBox(
                        label: "Gujarati",
                        icon: Icons.g_mobiledata,
                        isTap: isGujaratiSelected,
                        callBack: () {
                          setState(() {
                            isGujaratiSelected = !isGujaratiSelected;
                          });
                        }),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Radio Button",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyRadioButton(
                      icon: Icons.system_update_alt,
                      groupValue: Mode.System,
                      value: mode,
                      callBack: () {
                        setState(() {
                          mode = Mode.System;
                        });
                      },
                      label: "System",
                    ),
                    MyRadioButton(
                      icon: Icons.light_mode,
                      groupValue: Mode.Light,
                      value: mode,
                      callBack: () {
                        setState(() {
                          mode = Mode.Light;
                        });
                      },
                      label: "Light",
                    ),
                    MyRadioButton(
                      icon: Icons.light_mode_outlined,
                      groupValue: Mode.Dark,
                      value: mode,
                      callBack: () {
                        setState(() {
                          mode = Mode.Dark;
                        });
                      },
                      label: "Dark",
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  "Switch",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                MySwitch(
                    leftCallBack: () {
                      setState(() {
                        direction = Direction.Left;
                      });
                    },
                    rightCallBack: () {
                      setState(() {
                        direction = Direction.Right;
                      });
                    },
                    leftGroupValue: Direction.Left,
                    value: direction,
                    rightGroupValue: Direction.Right)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
