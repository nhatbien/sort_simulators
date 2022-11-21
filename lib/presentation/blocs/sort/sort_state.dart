part of 'sort_bloc.dart';

enum SortStatus { initial, loading, stop, success, failure }

enum SortType { SELECTION, BUBBLE, QUICK, INSERTION, MERGE, NONE }

class SortState extends Equatable {
  const SortState({
    this.status = SortStatus.initial,
    this.message = "",
    this.numbers = const [],
    this.numbersCopy = const [],
    this.sortSelected = SortType.SELECTION,
    this.animationSpeed = 0,
    this.stopSort = true,
    this.size = 0,
    this.swapLengthSelection = 0,
    this.swapLengthBubble = 0,
    this.swapLengthQuick = 0,
    this.swapLengthInsertion = 0,
  });

  final SortStatus status;
  final String message;

  final List<SortModel> numbers;
  final SortType sortSelected;
  final List<SortModel> numbersCopy;
  final double animationSpeed;
  final bool stopSort;
  final int size;
  final int swapLengthSelection;
  final int swapLengthQuick;
  final int swapLengthBubble;
  final int swapLengthInsertion;

  SortState copyWith({
    SortStatus? status,
    List<SortModel>? numbers,
    List<SortModel>? numbersCopy,
    SortType? sortSelected,
    double? animationSpeed,
    bool? stopSort,
    String? message,
    int? size,
    int? swapLengthSelection,
    int? swapLengthQuick,
    int? swapLengthBubble,
    int? swapLengthInsertion,
  }) {
    return SortState(
      status: status ?? this.status,
      numbers: numbers ?? this.numbers,
      numbersCopy: numbersCopy ?? this.numbersCopy,
      sortSelected: sortSelected ?? this.sortSelected,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      stopSort: stopSort ?? this.stopSort,
      size: size ?? this.size,
      message: message ?? this.message,
      swapLengthSelection: swapLengthSelection ?? this.swapLengthSelection,
      swapLengthQuick: swapLengthQuick ?? this.swapLengthQuick,
      swapLengthBubble: swapLengthBubble ?? this.swapLengthBubble,
      swapLengthInsertion: swapLengthInsertion ?? this.swapLengthInsertion,
    );
  }

  @override
  List<Object> get props => [
        status,
        numbers,
        numbersCopy,
        sortSelected,
        animationSpeed,
        stopSort,
        size,
        message,
        swapLengthSelection,
        swapLengthQuick,
        swapLengthBubble,
        swapLengthInsertion,
      ];
}












/* 
enum SorttateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
}

abstract class SortState extends Equatable {
  @override
  List<Object> get props => [];
}

class Printed extends SortState {
  final List<Ticket> sort;
  Printed({required this.sort});

  @override
  List<Object> get props => [sort];
}

class Loading extends SortState {}

class Loaded extends SortState {
  final List<Ticket> sort;
  Loaded({required this.sort});

  @override
  List<Object> get props => [sort];
}

class Error extends SortState {
  final DioError error;

  Error({required this.error});

  @override
  List<Object> get props => [error];
}
 */ 