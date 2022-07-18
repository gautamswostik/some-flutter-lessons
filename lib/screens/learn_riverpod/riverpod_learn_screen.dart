import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/application/learn_riverpod/math_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiverpodMathScreen extends ConsumerStatefulWidget {
  const RiverpodMathScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RiverpodMathScreenState();
}

class _RiverpodMathScreenState extends ConsumerState<RiverpodMathScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(mathController.notifier).add(60, 60);
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              ref.read(mathController.notifier).sub(60, 60);
            },
            child: const Icon(
              Icons.remove,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              ref.read(mathController.notifier).mul(60, 60);
            },
            child: const Icon(
              Icons.clear,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              ref.read(mathController.notifier).div(60, 60);
            },
            child: const Text(
              '÷',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Math Screen'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(mathController);

            return Text(state.toString());
          },
        ),
      ),
    );
  }
}
