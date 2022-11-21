part of 'input_bloc.dart';

enum InputStatus { initial, loading, success, failure }

class InputState extends Equatable {
  const InputState({
    this.status = InputStatus.initial,
    this.completedInput = 0,
  });

  final InputStatus status;
  final int completedInput;

  @override
  List<Object> get props => [
        status,
        completedInput,
      ];

  InputState copyWith({
    InputStatus? status,
    int? completedInput,
  }) {
    return InputState(
      status: status ?? this.status,
      completedInput: completedInput ?? this.completedInput,
    );
  }
}
