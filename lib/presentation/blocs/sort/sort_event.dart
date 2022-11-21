part of 'sort_bloc.dart';

abstract class SortsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartSort extends SortsEvent {}

class StopSort extends SortsEvent {}

class Loading extends SortsEvent {}

class ResetStatus extends SortsEvent {}

class ResetSort extends SortsEvent {}

class SelectSort extends SortsEvent {
  final SortType sortType;
  SelectSort({required this.sortType});
}

class SubmitInput extends SortsEvent {}

class RequestInputSort extends SortsEvent {
  final int size;
  RequestInputSort({required this.size});
}
