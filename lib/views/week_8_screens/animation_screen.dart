import 'dart:math';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TweenAnimationBuilder(
            tween: Tween<double>(end: 1, begin: 1.5),
            duration: const Duration(seconds: 2),
            builder: (context, double value, widget) {
              return Transform.scale(
                scale: value,
                child: const Text("Animation"),
              );
            }),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 8,
              ),
              TweenAnimationBuilder(
                  curve: Curves.bounceOut,
                  tween: Tween<Offset>(begin: const Offset(0, -570), end: const Offset(0, 570)),
                  duration: const Duration(seconds: 4),
                  builder: (context, dynamic value, widget) {
                    return Transform.translate(
                      offset: value,
                      child: TweenAnimationBuilder(
                          tween: ColorTween(begin: Colors.tealAccent, end: Colors.amber),
                          duration: const Duration(seconds: 4),
                          builder: (context, dynamic value, widget) {
                            return ColorFiltered(
                              colorFilter: ColorFilter.mode(value, BlendMode.dstATop),
                              child: TweenAnimationBuilder(
                                  curve: Curves.easeInBack,
                                  tween: Tween<double>(begin: 0, end: pi),
                                  duration: const Duration(seconds: 2),
                                  builder: (context, dynamic value, widget) {
                                    return Transform.rotate(
                                      angle: value,
                                      child: const SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                            "To",
                                            style: TextStyle(color: Colors.black, fontSize: 25, letterSpacing: 1),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }),
                    );
                  }),
              TweenAnimationBuilder(
                  curve: Curves.bounceOut,
                  tween: Tween<Offset>(begin: const Offset(0, -450), end: const Offset(0, 450)),
                  duration: const Duration(seconds: 5),
                  builder: (context, dynamic value, widget) {
                    return Transform.translate(
                      offset: value,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.lightGreen),
                        child: const Center(
                          child: Text(
                            "Welcome",
                            style: TextStyle(color: Colors.black, fontSize: 25, letterSpacing: 1),
                          ),
                        ),
                      ),
                    );
                  }),
              TweenAnimationBuilder(
                  curve: Curves.bounceInOut,
                  tween: Tween<Offset>(begin: const Offset(0, -550), end: const Offset(0, 550)),
                  duration: const Duration(seconds: 5),
                  builder: (context, dynamic value, widget) {
                    return Transform.translate(
                      offset: value,
                      child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: pi * 2),
                          duration: const Duration(seconds: 5),
                          builder: (context, dynamic value, widget) {
                            return Transform.rotate(
                              angle: value,
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blueAccent),
                                child: const Center(
                                    child: Text(
                                  "Flutter",
                                  style: TextStyle(
                                      fontSize: 30, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.white),
                                )),
                              ),
                            );
                          }),
                    );
                  })
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 110,
                width: 107,
                color: Colors.brown,
              ),
              Container(
                height: 174,
                width: 150,
                color: Colors.brown,
              ),
              Container(
                height: 90,
                width: 135,
                color: Colors.brown,
              ),
            ],
          )
        ],
      ),
    );
  }
}
