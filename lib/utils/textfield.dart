import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  MyTextField(
      {Key? key,
      required this.hintText,
      required this.validateType,
      required this.textInputType,
      required this.controller,
      required this.onSubmit})
      : super(key: key);
  String hintText;
  String validateType;
  TextEditingController controller;
  Function onSubmit;
  TextInputType textInputType;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  inputFormatters() {
    switch (widget.validateType) {
      case "email":
        return <TextInputFormatter>[
          FilteringTextInputFormatter.deny(RegExp("[ ]")),
          FilteringTextInputFormatter.allow(RegExp("[a-zá-ú0-9.,-_@]")),
          LengthLimitingTextInputFormatter(50),
        ];
      case "number":
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(10),
        ];
      case "designation":
        return <TextInputFormatter>[
          LengthLimitingTextInputFormatter(50),
        ];
      case "salary":
        return <TextInputFormatter>[
          LengthLimitingTextInputFormatter(7),
        ];
      case "fileName":
        return <TextInputFormatter>[
          FilteringTextInputFormatter.deny("."),
          FilteringTextInputFormatter.deny(" "),
          LengthLimitingTextInputFormatter(30),
        ];
      default:
        return <TextInputFormatter>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: widget.hintText,
      ),
      keyboardType: widget.textInputType,
      inputFormatters: inputFormatters(),
      validator: (val) {
        print("validation start.........");
        switch (widget.validateType) {
          case "email":
            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val.toString())) {
              return null;
            } else {
              return "Please enter valid email address..";
            }
          case "number":
            if (RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$").hasMatch(val.toString())) {
              return null;
            } else {
              return "Please enter valid number..";
            }

          default:
            if (val!.isEmpty) {
              return "Please fill it first...";
            } else {
              return null;
            }
        }
      },
      onChanged: (val) {
        widget.onSubmit;
        print("onChange........");
      },
    );
  }
}
