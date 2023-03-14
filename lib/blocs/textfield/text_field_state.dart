import 'package:equatable/equatable.dart';

class TextFieldState extends Equatable {
  final String text;

  const TextFieldState({required this.text});

  @override
  List<Object?> get props => [text];
}
