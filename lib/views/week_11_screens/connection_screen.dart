import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app/utils/appbar.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  static const platform = MethodChannel('changeBoolean');
  bool? bluetooth;
  bool? wifi;
  bool? mobileData;

  checkBlueToothConnection() async {
    dynamic val = await platform.invokeMethod('bluetoothConnection');

    setState(() {
      bluetooth = val;
    });

    if (mounted) {
      checkBlueToothConnection();
    }
  }

  checkWiFiConnection() async {
    dynamic val = await platform.invokeMethod('wifiConnection');

    setState(() {
      wifi = val;
    });

    if (mounted) {
      checkWiFiConnection();
    }
  }

  checkMobileDataConnection() async {
    dynamic val = await platform.invokeMethod('mobileDataConnection');

    print("mobile data");
    print(val);

    setState(() {
      mobileData = val;
    });

    if (mounted) {
      checkMobileDataConnection();
    }
  }

  @override
  void initState() {
    checkBlueToothConnection();
    checkWiFiConnection();
    checkMobileDataConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Connection"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: (bluetooth!) ? Colors.limeAccent : Colors.grey,
            onPressed: () async {},
            child: const Icon(Icons.bluetooth),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: (wifi!) ? Colors.limeAccent : Colors.grey,
            onPressed: () async {},
            child: const Icon(Icons.wifi),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: (mobileData!) ? Colors.limeAccent : Colors.grey,
            onPressed: () async {},
            child: const Icon(Icons.signal_cellular_alt_rounded),
          ),
        ],
      ),
      body: Center(
        child: Text(
            "BlueTooth Connection: $bluetooth \n\nWiFi Connection: $wifi\n\nMobile Data Connection: $mobileData",
            style: const TextStyle(fontSize: 25, color: Colors.lime, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
