import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/blocs/textfield/text_field_bloc.dart';
import 'package:training_app/blocs/textfield/text_field_event.dart';
import 'package:training_app/blocs/textfield/text_field_state.dart';
import 'package:training_app/utils/appbar.dart';

class SimpleBlocScreen extends StatelessWidget {
  const SimpleBlocScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Bloc 2"),
      body: BlocProvider(
        create: (context) => TextFieldBloc(const TextFieldState(text: "")),
        child: Preview(),
      ),
    );
  }
}

class Preview extends StatelessWidget {
  Preview({Key? key}) : super(key: key);
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: "Enter Test Text"),
            controller: textController,
            onSubmitted: (val) {
              BlocProvider.of<TextFieldBloc>(context).add(TextFieldEvent(text: val));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Result:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Expanded(
            child: BlocBuilder<TextFieldBloc, TextFieldState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.text.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                        alignment: Alignment.center,
                        child: Text(state.text[index].toUpperCase(),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
