import 'package:bloc/bloc.dart';

enum CounterEvents { increment, decrement }

class CounterBloc extends Bloc<CounterEvents, int> {
  CounterBloc() : super(0) {
    on((event, emit) {
      // use `emit` to update the state.
      if (event == CounterEvents.increment) {
        emit(state + 1);
      } else if (event == CounterEvents.decrement) {
        emit(state - 1);
      }
    });
  }

  @override
  void onChange(Change<int> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onEvent(CounterEvents event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    super.onError(error, stackTrace);
  }

  @override
  void onTransition(Transition<CounterEvents, int> transition) {
    print(transition);
    super.onTransition(transition);
  }
  // CounterBloc() : super(0);
  //
  // void eventHandler({required CounterEvents event}) {
  //   print("Entered.....");
  //   if (event == CounterEvents.increment) {
  //     emit(state + 1);
  //   } else if (event == CounterEvents.decrement) {
  //     print(state);
  //     emit(state - 1);
  //   }
  // }
}
