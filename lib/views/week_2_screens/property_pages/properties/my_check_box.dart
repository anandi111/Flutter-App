import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  MyCheckBox(
      {Key? key,
      required this.label,
      required this.icon,
      required this.isTap,
      required this.callBack})
      : super(key: key);
  String label;
  IconData icon;
  bool isTap;
  VoidCallback callBack;
  Color? activeColor;
  Color? inactiveColor;
  Color? iconColor;
  Color? textColor;

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
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
              padding: const EdgeInsets.all(8),
              child: Icon(
                  (widget.isTap == true) ? Icons.done : Icons.cancel_outlined,
                  size: 20,
                  color: (widget.isTap == true)
                      ? widget.activeColor ?? Colors.pink
                      : widget.inactiveColor ?? Colors.grey),
            ),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  /*borderRadius: BorderRadius.circular(15),*/
                  border: Border.all(
                      color: (widget.isTap == true)
                          ? widget.activeColor ?? Colors.pink
                          : widget.inactiveColor ?? Colors.grey)),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 30,
                    color: widget.iconColor ?? Colors.white,
                  ),
                  Text(
                    widget.label,
                    style: TextStyle(color: widget.textColor ?? Colors.white),
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
