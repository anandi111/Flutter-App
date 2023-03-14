import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  MyButton({Key? key, required this.label, required this.callback})
      : super(key: key);
  String label;
  VoidCallback callback;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.callback,
            child: Container(
              height: 60,
              width: 350,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff1be3de), Color(0xff357af6)])),
              child: Center(
                  child: Text(
                widget.label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
