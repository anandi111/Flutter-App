import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/views/week_5_screens/user_detail_shown_screen.dart';

class Week5Page extends StatefulWidget {
  const Week5Page({Key? key}) : super(key: key);

  @override
  State<Week5Page> createState() => _Week5PageState();
}

class _Week5PageState extends State<Week5Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 5"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Sound Recorder",
                callback: () {
                  Navigator.of(context).pushNamed("sound_recording_screen");
                }),
            MyButton(
                label: "Sound Player",
                callback: () {
                  Navigator.of(context).pushNamed("sound_display_screen");
                }),
            /* MyButton(
                label: "On Audio Query",
                callback: () {
                  Navigator.of(context).pushNamed("on_audio_query_screen");
                }),*/
            MyButton(
                label: "Video Player",
                callback: () {
                  Navigator.of(context).pushNamed("video_player_screen");
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DemoVideoPlayerScreen(),
                      ));*/
                }),
            MyButton(
                label: "Social Media LogIn",
                callback: () async {
                  final prefs = await SharedPreferences.getInstance();

                  bool? isLogged = prefs.getBool('isLogged');

                  if (isLogged == true) {
                    String? name = prefs.getString('name');
                    String? photo = prefs.getString('photo');
                    String? email = prefs.getString('email');

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailShownScreen(name: name!, photo: photo!, email: email!),
                        ));
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed("social_media_login_screen");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
