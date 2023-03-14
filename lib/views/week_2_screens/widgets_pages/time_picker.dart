import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class TimePickerScreen extends StatefulWidget {
  const TimePickerScreen({Key? key}) : super(key: key);

  @override
  State<TimePickerScreen> createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  //current time..
  TimeOfDay now = TimeOfDay.now();

  //android time controllers...
  TimeOfDay pickedTime = TimeOfDay.now();
  TimeOfDay? andTimeOfDay = TimeOfDay.now();

  //ios time controllers...
  DateTime? iosTimeOfDay = DateTime.now();
  TimeOfDay? periodPicker = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Time Picker"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              "Time: ${andTimeOfDay!.hour}:${andTimeOfDay!.minute} ${andTimeOfDay!.period.name}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                label: "Android Style Time Picker",
                callback: () async {
                  andTimeOfDay = await showTimePicker(
                      context: context, initialTime: pickedTime);

                  if (andTimeOfDay != null) {
                    setState(() {
                      pickedTime = andTimeOfDay!;
                    });
                  }
                }),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Time: ${iosTimeOfDay!.hour}:${iosTimeOfDay!.minute} ${periodPicker!.period.name}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                label: "IOS Style Time Picker",
                callback: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                            height: 250,
                            child: CupertinoDatePicker(
                              backgroundColor: Colors.white,
                              mode: CupertinoDatePickerMode.time,
                              onDateTimeChanged: (value) {
                                setState(() {
                                  iosTimeOfDay = value;
                                  periodPicker = TimeOfDay(
                                      hour: value.hour, minute: value.minute);
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
