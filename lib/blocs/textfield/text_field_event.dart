import 'package:equatable/equatable.dart';

class TextFieldEvent extends Equatable {
  final String text;

  const TextFieldEvent({required this.text});

  @override
  List<Object?> get props => [text];
}
