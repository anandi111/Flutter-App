import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { increment, decrement }

int counterReducer(int state, dynamic action) {
  if (action == Actions.increment) {
    return state + 1;
  } else if (action == Actions.decrement) {
    return state - 1;
  }
  return state;
}

class ReduxScreen extends StatelessWidget {
  ReduxScreen({Key? key}) : super(key: key);
  final store = Store<int>(counterReducer, initialState: 0);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: Scaffold(
        appBar: MyAppBar(title: "Redux Counter"),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StoreConnector<int, String>(
                converter: (store) => store.state.toString(),
                builder: (context, count) {
                  return Text(
                    count,
                    style: const TextStyle(fontSize: 100, fontWeight: FontWeight.w600, color: Colors.white),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StoreConnector<int, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(Actions.increment);
                    },
                    builder: (context, callback) {
                      return FloatingActionButton(
                        heroTag: UniqueKey(),
                        backgroundColor: Colors.teal,
                        onPressed: callback,
                        tooltip: 'Increment',
                        child: const Icon(Icons.add, color: Colors.white),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  StoreConnector<int, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(Actions.decrement);
                    },
                    builder: (context, callback) {
                      return FloatingActionButton(
                        heroTag: UniqueKey(),
                        backgroundColor: Colors.teal,
                        onPressed: callback,
                        tooltip: 'Increment',
                        child: const Icon(Icons.remove, color: Colors.white),
                      );
                    },
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
