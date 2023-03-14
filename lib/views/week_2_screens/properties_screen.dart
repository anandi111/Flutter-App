import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({Key? key}) : super(key: key);

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Properties"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
              label: "Inbuilt Properties",
              callback: () {
                Navigator.pushNamed(context, "inbuilt_properties_screen");
              },
            ),
            MyButton(
              label: "Custom Control Properties",
              callback: () {
                Navigator.pushNamed(
                    context, "custom_control_properties_screen");
              },
            )
          ],
        ),
      ),
    );
  }
}
