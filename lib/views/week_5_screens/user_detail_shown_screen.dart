import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/utils/appbar.dart';

import '../../helpers/firebase_helper.dart';

class UserDetailShownScreen extends StatefulWidget {
  String name;
  String photo;
  String email;
  UserDetailShownScreen({Key? key, required this.name, required this.photo, required this.email}) : super(key: key);

  @override
  State<UserDetailShownScreen> createState() => _UserDetailShownScreenState();
}

class _UserDetailShownScreenState extends State<UserDetailShownScreen> {
  @override
  void initState() {
    setBool();
    super.initState();
  }

  setBool() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogged', true);
    await prefs.setString('name', widget.name);
    await prefs.setString('photo', widget.photo);
    await prefs.setString('email', widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "User Detail"),
      body: Center(
        child: Container(
          height: 450,
          width: 330,
          decoration: BoxDecoration(
              color: const Color(0xff3a3b3c),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 2, blurRadius: 20)]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                  child: Image.network(
                widget.photo,
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              )),
              Text(
                widget.name,
                style: const TextStyle(color: Colors.amber, fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Text(
                widget.email,
                style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();

                  bool? isFacebook = prefs.getBool('isFacebook');

                  if (isFacebook == true) {
                    await FirebaseHelper.firebaseHelper.signOutFromFacebook();
                    print("Facebook Logout....................");
                  } else {
                    await FirebaseHelper.firebaseHelper.signOutFromGoogle();
                    print("Google Logout....................");
                  }

                  await prefs.setBool('isLogged', false);
                  await prefs.setString('name', '');
                  await prefs.setString('photo', '');
                  await prefs.setString('email', '');

                  Navigator.pushReplacementNamed(
                    context,
                    "social_media_login_screen",
                  );
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration:
                      BoxDecoration(color: Colors.amber.withOpacity(0.8), borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
