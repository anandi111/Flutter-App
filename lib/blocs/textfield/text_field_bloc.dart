import 'package:bloc/bloc.dart';
import 'package:training_app/blocs/textfield/text_field_event.dart';
import 'package:training_app/blocs/textfield/text_field_state.dart';

class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  TextFieldBloc(TextFieldState initState) : super(initState) {
    on<TextFieldEvent>(_onTextFieldEvent);
  }

  void _onTextFieldEvent(TextFieldEvent event, Emitter<TextFieldState> emit) {
    if (event.text != state.text) {
      print("Not Same");
      emit(TextFieldState(text: event.text));
    } else {
      print("Same One");
    }
  }
}
