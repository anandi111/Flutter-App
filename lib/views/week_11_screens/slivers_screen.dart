import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SliverScreen extends StatefulWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  State<SliverScreen> createState() => _SliverScreenState();
}

class _SliverScreenState extends State<SliverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff091e39),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  "assets/Mountains_Peaks_Wallpaper.jpg",
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 32.0),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Welcome Back!!'),
                        WavyAnimatedText('#Explore free#'),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                )
              ],
            ),
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add_outlined))],
            backgroundColor: const Color(0xfff1f1f1),
            floating: true,
            // pinned: true,
            snap: true,
            expandedHeight: 200,
            automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      height: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xff6f8ba8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                childCount: 10),
          ),
        ],
      ),
    );
  }
}
