part of 'learn_bloc_bloc.dart';

abstract class LearnBlocEvent extends Equatable {
  const LearnBlocEvent();

  @override
  List<Object> get props => [];
}

class TriggerAddEvent extends LearnBlocEvent {
  final num number1, number2;
  const TriggerAddEvent({required this.number1, required this.number2});

  @override
  List<Object> get props => [number1, number2];
}

class TriggerSubEvent extends LearnBlocEvent {
  final num number1, number2;
  const TriggerSubEvent({required this.number1, required this.number2});

  @override
  List<Object> get props => [number1, number2];
}

class TriggerMulEvent extends LearnBlocEvent {
  final num number1, number2;
  const TriggerMulEvent({required this.number1, required this.number2});

  @override
  List<Object> get props => [number1, number2];
}

class TriggerDivEvent extends LearnBlocEvent {
  final num number1, number2;
  const TriggerDivEvent({required this.number1, required this.number2});

  @override
  List<Object> get props => [number1, number2];
}
