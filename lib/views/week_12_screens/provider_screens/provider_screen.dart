import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/providers/counter_provider.dart';
import 'package:training_app/utils/appbar.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      builder: (context, child) => Scaffold(
        appBar: MyAppBar(title: "Provider Counter"),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<CounterProvider>(
                builder: (context, counterProvider, child) => Text(
                  counterProvider.counter.toString(),
                  style: const TextStyle(fontSize: 100, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Provider.of<CounterProvider>(context, listen: false).increment();
                    },
                    heroTag: UniqueKey(),
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Provider.of<CounterProvider>(context, listen: false).decrement();
                    },
                    heroTag: UniqueKey(),
                    backgroundColor: Colors.orange,
                    child: const Icon(Icons.remove),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
