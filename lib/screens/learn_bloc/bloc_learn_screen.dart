import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/bloc_pattern/learn_bloc_bloc.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class LearnBlocScreen extends StatefulWidget {
  const LearnBlocScreen({Key? key}) : super(key: key);

  @override
  State<LearnBlocScreen> createState() => _LearnBlocScreenState();
}

class _LearnBlocScreenState extends State<LearnBlocScreen> {
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.learnBlocPatten.translateTo(context)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<LearnBlocBloc>(context).add(
                TriggerAddEvent(
                  number1: int.parse(num1.text),
                  number2: int.parse(num2.text),
                ),
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<LearnBlocBloc>(context).add(
                TriggerSubEvent(
                  number1: int.parse(num1.text),
                  number2: int.parse(num2.text),
                ),
              );
            },
            child: const Icon(
              Icons.remove,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<LearnBlocBloc>(context).add(
                TriggerMulEvent(
                  number1: int.parse(num1.text),
                  number2: int.parse(num2.text),
                ),
              );
            },
            child: const Icon(
              Icons.clear,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<LearnBlocBloc>(context).add(
                TriggerDivEvent(
                  number1: int.parse(num1.text),
                  number2: int.parse(num2.text),
                ),
              );
            },
            child: const Text(
              '÷',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: num1,
              maxLines: null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: AppTexts.number.translateTo(context),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppTexts.numberRequired.translateTo(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: num2,
              maxLines: null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: AppTexts.number.translateTo(context),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppTexts.numberRequired.translateTo(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 50),
            Center(
              child: BlocBuilder<LearnBlocBloc, LearnBlocState>(
                builder: (context, state) {
                  if (state is BlocLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is BlocSuccess) {
                    return Text(state.result.toString());
                  }
                  if (state is BlocError) {
                    return Text(state.error.toString());
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
