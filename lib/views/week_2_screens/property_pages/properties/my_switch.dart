import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  MySwitch(
      {Key? key,
      required this.leftGroupValue,
      required this.value,
      required this.rightGroupValue,
      this.activeColor,
      this.inactiveColor,
      this.iconColor,
      this.leftIcon,
      this.rightIcon,
      this.leftCallBack,
      this.rightCallBack})
      : super(key: key);

  IconData? leftIcon;
  IconData? rightIcon;
  Color? iconColor;
  Color? activeColor;
  Color? inactiveColor;
  Object leftGroupValue;
  Object value;
  Object rightGroupValue;
  VoidCallback? leftCallBack;
  VoidCallback? rightCallBack;

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: widget.leftCallBack,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: (widget.value == widget.leftGroupValue)
                    ? widget.activeColor ?? Colors.lightGreenAccent
                    : widget.inactiveColor ?? Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.keyboard_double_arrow_left),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: widget.rightCallBack,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: (widget.value == widget.rightGroupValue)
                    ? widget.activeColor ?? Colors.lightGreenAccent
                    : widget.inactiveColor ?? Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.keyboard_double_arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}
