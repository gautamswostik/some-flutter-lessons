import 'package:hooks_riverpod/hooks_riverpod.dart';

final mathRepoProvider = Provider<IMathRepository>((ref) {
  return MathRepository();
});

abstract class IMathRepository {
  int add({required int a, required int b});
  int sub({required int a, required int b});
  int mul({required int a, required int b});
  int div({required int a, required int b});
}

class MathRepository extends IMathRepository {
  MathRepository();

  @override
  int add({required int a, required int b}) {
    return a + b;
  }

  @override
  int div({required int a, required int b}) {
    return a ~/ b;
  }

  @override
  int mul({required int a, required int b}) {
    return a * b;
  }

  @override
  int sub({required int a, required int b}) {
    return a - b;
  }
}
