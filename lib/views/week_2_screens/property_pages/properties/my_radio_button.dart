import 'package:flutter/material.dart';

class MyRadioButton extends StatefulWidget {
  MyRadioButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.groupValue,
      required this.value,
      required this.callBack})
      : super(key: key);
  String label;
  IconData icon;
  Object groupValue;
  Object value;
  VoidCallback callBack;
  Color? activeColor;
  Color? inactiveColor;
  Color? iconColor;
  Color? textColor;

  @override
  State<MyRadioButton> createState() => _MyRadioButtonState();
}

class _MyRadioButtonState extends State<MyRadioButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: widget.callBack,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipOval(
                child: Container(
                  height: 12,
                  width: 12,
                  color: (widget.value == widget.groupValue)
                      ? widget.activeColor ?? Colors.pink
                      : Colors.grey,
                ),
              ),
            ),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  /*borderRadius: BorderRadius.circular(15),*/
                  border: Border.all(
                      color: (widget.value == widget.groupValue)
                          ? widget.activeColor ?? Colors.pink
                          : Colors.grey)),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    widget.label,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
