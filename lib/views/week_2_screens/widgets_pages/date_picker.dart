import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({Key? key}) : super(key: key);

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  //current date..
  DateTime now = DateTime.now();

  //ios date controllers..
  DateTime? iosDateTime = DateTime.now();

  //android date controllers..
  DateTime? andDateTime = DateTime.now();
  DateTime selectedAndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Date Picker"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              "Date: ${andDateTime!.day}-${andDateTime!.month}-${andDateTime!.year}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                label: "Android Style Date Picker",
                callback: () async {
                  andDateTime = await showDatePicker(
                    context: context,
                    initialDate: selectedAndDate,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2030),
                  );

                  if (andDateTime != null) {
                    setState(() {
                      selectedAndDate = andDateTime!;
                    });
                  }

                  print(andDateTime);
                }),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Date: ${iosDateTime!.day}-${iosDateTime!.month}-${iosDateTime!.year}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                label: "IOS Style Date Picker",
                callback: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                            height: 250,
                            child: CupertinoDatePicker(
                              backgroundColor: Colors.white,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (date) {
                                setState(() {
                                  iosDateTime = date;
                                });
                              },
                            ),
                          ));
                }),
          ],
        ),
      ),
    );
  }
}
