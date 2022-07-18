part of 'learn_bloc_bloc.dart';

abstract class LearnBlocState extends Equatable {
  const LearnBlocState();

  @override
  List<Object> get props => [];
}

class LearnBlocInitial extends LearnBlocState {}

class BlocLoading extends LearnBlocState {}

class BlocSuccess extends LearnBlocState {
  final num result;
  const BlocSuccess({required this.result});

  @override
  List<Object> get props => [result];
}

class BlocError extends LearnBlocState {
  final String error;
  const BlocError({required this.error});

  @override
  List<Object> get props => [error];
}
