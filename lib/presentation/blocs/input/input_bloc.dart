import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'input_event.dart';
part 'input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  InputBloc() : super(const InputState()) {
    on<InputRequested>(_onSubscriptionRequested);
  }

  Future<void> _onSubscriptionRequested(
    InputRequested event,
    Emitter<InputState> emit,
  ) async {
    emit(state.copyWith(status: InputStatus.loading));
  }
}
