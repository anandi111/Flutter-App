import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app/utils/appbar.dart';

class MethodChannelScreen extends StatefulWidget {
  const MethodChannelScreen({Key? key}) : super(key: key);

  @override
  State<MethodChannelScreen> createState() => _MethodChannelScreenState();
}

class _MethodChannelScreenState extends State<MethodChannelScreen> {
  static const platform = MethodChannel('changeBoolean');
  bool boolean = true;

  Future<void> changeBoolean() async {
    bool receivedBoolean = true;
    try {
      receivedBoolean = await platform.invokeMethod('changeBooleanFunction', {'res': boolean});
      print(receivedBoolean.toString());
    } on PlatformException catch (e) {
      receivedBoolean = true;
      print(e);
    }
    setState(() {
      boolean = receivedBoolean;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Method Channel"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.limeAccent,
        onPressed: () {
          changeBoolean();
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Text(boolean.toString().toUpperCase(),
            style: const TextStyle(fontSize: 30, color: Colors.lime, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
