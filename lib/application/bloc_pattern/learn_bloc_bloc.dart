import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'learn_bloc_event.dart';
part 'learn_bloc_state.dart';

class LearnBlocBloc extends Bloc<LearnBlocEvent, LearnBlocState> {
  LearnBlocBloc() : super(LearnBlocInitial()) {
    on<LearnBlocEvent>((event, emit) {});
    on<TriggerAddEvent>((event, emit) {
      emit(BlocLoading());
      num result = event.number1 + event.number2;
      emit(BlocSuccess(result: result));
    });

    on<TriggerSubEvent>((event, emit) {
      emit(BlocLoading());
      num result = event.number1 - event.number2;
      emit(BlocSuccess(result: result));
    });

    on<TriggerMulEvent>((event, emit) {
      emit(BlocLoading());
      num result = event.number1 * event.number2;
      emit(BlocSuccess(result: result));
    });

    on<TriggerDivEvent>((event, emit) {
      emit(BlocLoading());
      try {
        num result = event.number1 / event.number2;
        emit(BlocSuccess(result: result));
      } on UnsupportedError catch (e) {
        emit(BlocError(error: e.message ?? 'Something went wrong'));
      }
    });
  }
}
