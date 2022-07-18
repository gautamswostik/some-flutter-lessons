import 'package:fluuter_boilerplate/application/learn_riverpod/math_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mathController =
    StateNotifierProvider.autoDispose<MathController, int>((ref) {
  return MathController(ref.read);
});

class MathController extends StateNotifier<int> {
  MathController(this._reader) : super(0);
  final Reader _reader;

  IMathRepository get mathRepository => _reader(mathRepoProvider);

  void add(int a, int b) {
    int sum = mathRepository.add(a: a, b: b);
    state = sum;
  }

  void sub(int a, int b) {
    state = mathRepository.sub(a: a, b: b);
  }

  void mul(int a, int b) {
    state = mathRepository.mul(a: a, b: b);
  }

  void div(int a, int b) {
    try {
      int div = mathRepository.div(a: a, b: b);
      state = div;
    } catch (e) {
      state = 10010011011;
    }
  }
}
