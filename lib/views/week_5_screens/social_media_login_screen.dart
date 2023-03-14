import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/views/week_5_screens/login_load_screen.dart';

class SocialMediaLogInScreen extends StatefulWidget {
  const SocialMediaLogInScreen({Key? key}) : super(key: key);

  @override
  State<SocialMediaLogInScreen> createState() => _SocialMediaLogInScreenState();
}

class _SocialMediaLogInScreenState extends State<SocialMediaLogInScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Social Media Login"),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Sign In With Google 🔒",
                callback: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginLoadScreen(isFacebook: false),
                      ));
                }),
            MyButton(
                label: "Sign In With Facebook 🔒",
                callback: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginLoadScreen(isFacebook: true),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
