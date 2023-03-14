import 'package:flutter/material.dart';

import '../../../utils/appbar.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double sliderValue = 5;
  RangeValues rangeValues = const RangeValues(2, 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Slider"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Slider value: ${sliderValue.toInt()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Slider(
                min: 1,
                max: 10,
                value: sliderValue,
                onChanged: (val) {
                  setState(() {
                    sliderValue = val.toDouble();
                  });
                }),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Range Slider value: ${rangeValues.start.toInt()} to ${rangeValues.end.toInt()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Difference: ${rangeValues.end.toInt() - rangeValues.start.toInt()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            RangeSlider(
                min: 1,
                max: 10,
                values: rangeValues,
                onChanged: (val) {
                  setState(() {
                    rangeValues = val;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
