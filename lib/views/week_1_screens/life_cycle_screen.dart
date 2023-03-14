import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class LifeCycleScreen extends StatefulWidget {
  const LifeCycleScreen({Key? key}) : super(key: key);

  @override
  State<LifeCycleScreen> createState() => _LifeCycleScreenState();
}

class _LifeCycleScreenState extends State<LifeCycleScreen>
    with WidgetsBindingObserver {
  activeSnackbar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Inactive")));
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.resumed:
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Resumed")));
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Life cycle"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Inactive")));
            },
            icon: const Icon(
              Icons.keyboard_double_arrow_left,
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Image.asset(
          "assets/process.png",
          width: 700,
          height: 700,
          color: Colors.indigo,
        )),
      ),
    );
  }
}
