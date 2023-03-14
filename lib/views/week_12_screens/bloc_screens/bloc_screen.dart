import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/blocs/counter_bloc.dart';
import 'package:training_app/utils/appbar.dart';

class BlocScreen extends StatefulWidget {
  const BlocScreen({Key? key}) : super(key: key);

  @override
  State<BlocScreen> createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "BLoC Counter"),
      body: BlocProvider(
        create: (context) => CounterBloc(),
        child: const ShowView(),
      ),
    );
  }
}

class ShowView extends StatelessWidget {
  const ShowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<CounterBloc, int>(
            builder: (context, state) => Text(
              state.toString(),
              style: const TextStyle(fontSize: 100, fontWeight: FontWeight.w600, color: Colors.grey),
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
                  counterBloc.add(CounterEvents.increment);
                },
                heroTag: UniqueKey(),
                backgroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                width: 50,
              ),
              FloatingActionButton(
                onPressed: () {
                  counterBloc.add(CounterEvents.decrement);
                },
                heroTag: UniqueKey(),
                backgroundColor: Colors.black,
                child: const Icon(Icons.remove, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
