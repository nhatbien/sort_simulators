import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/models/sort_model.dart';

part 'sort_event.dart';
part 'sort_state.dart';

class SortBloc extends Bloc<SortsEvent, SortState> {
  SortBloc() : super(SortState()) {
    on<StartSort>(
      start,
      transformer: (events, mapper) => events.switchMap(mapper),

/*       transformer: (events, mapper) => events.switchMap(mapper),
 */
    );
    on<Loading>(_loading,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<RequestInputSort>(_input,
        transformer: (events, mapper) => events.switchMap(mapper));

    on<SubmitInput>(_submitInput);
    on<ResetStatus>(_resetStatus);
    on<StopSort>(_stop);
    on<SelectSort>(_selectSort);
    on<ResetSort>(_resetSort);
  }

  Future start(SortsEvent event, Emitter<SortState> emit) async {
    emit(state.copyWith(status: SortStatus.initial));

    switch (state.sortSelected) {
      case SortType.SELECTION:
        await _selectionSort(event, emit);
        break;
      case SortType.BUBBLE:
        await _bubbleSort(emit);
        break;
      case SortType.QUICK:
        await _quickSort(emit);
        break;
      case SortType.INSERTION:
        await _insertSort(emit);
        break;
      case SortType.MERGE:
        // await _mergeSort(emit);
        break;
      case SortType.NONE:
        break;
    }
    emit(state.copyWith(status: SortStatus.stop));
  }

  Future _resetStatus(ResetStatus event, Emitter<SortState> emit) async {
    emit(state.copyWith(message: "", status: SortStatus.initial));
  }

  Future _submitInput(SortsEvent event, Emitter<SortState> emit) async {
    var rng = Random();
    List<SortModel> numbers = [];
    if (state.size < 2 || state.size > 1000) {
      emit(state.copyWith(
        message: "Lỗi, chỉ  có thể nhập từ 2 => 1000",
        animationSpeed: state.animationSpeed + 1,
        status: SortStatus.failure,
      ));
      return;
    }
    for (var i = 0; i < state.size; i++) {
      int randomInt = rng.nextInt(100);
      numbers.add(SortModel(randomInt));
    }

    emit(state.copyWith(
        numbers: numbers, numbersCopy: numbers, status: SortStatus.loading));
  }

  //////////////////////
  Future _selectSort(SelectSort event, Emitter<SortState> emit) async {
    emit(state.copyWith(status: SortStatus.stop));
    await _resetAll(emit);
    emit(state.copyWith(
      numbers: List.of(state.numbersCopy),
      sortSelected: event.sortType,
      animationSpeed: state.animationSpeed + 1,
    ));
  } /* 
  void numberToSorted(int index,Emitter<SortState> emit) {

    numbers[index].sorted();

     emit(state.copyWith(
      numbers: numberPivot,
      animationSpeed: state.animationSpeed + 1,
    ));
  } */

///////////////////////
  Future _resetSort(ResetSort event, Emitter<SortState> emit) async {
    emit(state.copyWith(status: SortStatus.stop));
    await _resetAll(emit);
    emit(state.copyWith(
      numbers: List.of(state.numbersCopy),
      animationSpeed: state.animationSpeed + 1,
    ));
  }

  Future _input(RequestInputSort event, Emitter<SortState> emit) async {
    if (event.size <= 1 || event.size > 1000) {
      return;
    }

    emit(state.copyWith(size: event.size));
  }

  Future _loading(SortsEvent event, Emitter<SortState> emit) async {
    await _delay;
    add(StartSort());
  }

  Future _stop(StopSort event, Emitter<SortState> emit) async {
/*     _resetAll(emit);
 */
    emit(state.copyWith(status: SortStatus.stop, size: 0));
  }

  Future<void> _swap(
      int i, int j, List<SortModel> arr, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    var temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;

    emit(state.copyWith(
      numbers: arr,
      animationSpeed: state.animationSpeed + 1,
    ));

    switch (state.sortSelected) {
      case SortType.SELECTION:
        emit(state.copyWith(
          swapLengthSelection: state.swapLengthSelection + 1,
        ));
        break;
      case SortType.BUBBLE:
        emit(state.copyWith(
          swapLengthBubble: state.swapLengthBubble + 1,
        ));
        break;
      case SortType.QUICK:
        emit(state.copyWith(
          swapLengthQuick: state.swapLengthQuick + 1,
        ));
        break;
      case SortType.INSERTION:
        emit(state.copyWith(
          swapLengthInsertion: state.swapLengthInsertion + 1,
        ));
        break;
      case SortType.MERGE:
        break;
      case SortType.NONE:
        break;
    }
  }

  Future _makeSmallest(int index, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    var numberPivot = List.of(state.numbers);
    numberPivot[index].pivot();

    emit(state.copyWith(
      numbers: numberPivot,
      animationSpeed: state.animationSpeed + 1,
    ));
    await _delay;
  }

  Future _makeSorting(int index, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    var numberPivot = List.of(state.numbers);
    numberPivot[index].sort();

    emit(state.copyWith(
      numbers: numberPivot,
      animationSpeed: state.animationSpeed + 1,
    ));
    await _delay;
  }

  Future _makeResetSort(
      int index, List<SortModel> arr, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    if (index < 0 || index >= arr.length) {
      return;
    }
    arr[index].sort();
    emit(state.copyWith(
      numbers: arr,
      animationSpeed: state.animationSpeed + 1,
    ));
    await _delay;
  }

  Future _makeSorted(
      int left, int right, List<SortModel> arr, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    for (var i = left; i <= right; i++) {
      arr[i].sorted();
    }
    emit(state.copyWith(
      numbers: arr,
      animationSpeed: state.animationSpeed + 1,
    ));
  }

  Future _markNodesAsNotSorted(
      int left, int right, List<SortModel> arr, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    if (left < 0 || right > arr.length - 1 || left > right) {
      print('left: $left, right: $right');
      return;
    }
    for (var index = left; index <= right; index++) {
      arr[index].reset();
    }
    emit(state.copyWith(
      numbers: arr,
      animationSpeed: state.animationSpeed + 1,
    ));
  }

  Future _resetAll(Emitter<SortState> emit) async {
    var arr = List.of(state.numbers);
    for (int i = 0; i < arr.length; i++) {
      arr[i].reset();
    }
    emit(state.copyWith(
      numbers: arr,
      animationSpeed: state.animationSpeed + 1,
    ));
  }

  Future _resetStateAndRender(
      int index, List<SortModel> arr, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    arr[index].reset();
    emit(state.copyWith(
      numbers: arr,
      animationSpeed: state.animationSpeed + 1,
    ));
    await _delay;
  }

  Future _makeSortedDelay(int index, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    var num = List.of(state.numbers);
    num[index].sorted();
    emit(state.copyWith(
      numbers: num,
      animationSpeed: state.animationSpeed + 1,
    ));

    await _delay;
  }

  Future<void> _selectionSort(SortsEvent event, Emitter<SortState> emit) async {
    List<SortModel> list = List.of(state.numbers);
    for (var currentIndex = 0;
        currentIndex <= list.length - 1;
        currentIndex++) {
      if (state.status == SortStatus.stop) {
        return;
      }
      var smallestIndex = currentIndex;
      await _makeSmallest(smallestIndex, emit);

      for (var i = currentIndex + 1; i < list.length; i++) {
        if (state.status == SortStatus.stop) {
          return;
        }

        await _makeResetSort(i, list, emit);
        if (list[i].value < list[smallestIndex].value) {
          _resetStateAndRender(smallestIndex, list, emit);
          smallestIndex = i;
          await _makeSmallest(i, emit);
        } else {
          await _resetStateAndRender(i, list, emit);
        }
      }
      await _makeSortedDelay(smallestIndex, emit);
      await _swap(currentIndex, smallestIndex, list, emit);
    }

    return emit(state.copyWith(
      numbers: list,
      animationSpeed: state.animationSpeed + 1,
    ));
  }

  Future<void> _quickSort(Emitter<SortState> emit) async {
    List<SortModel> list = List.of(state.numbers);
    if (state.status == SortStatus.stop) {
      return;
    }
    await _helper(0, list.length - 1, emit);
    await _delay;
  }

  Future<void> _heaps(Emitter<SortState> emit) async {
    List<SortModel> list = List.of(state.numbers);
    if (state.status == SortStatus.stop) {
      return;
    }
    await _helper(0, list.length - 1, emit);
    await _delay;
  }

  Future<void> _helper(int start, int end, Emitter<SortState> emit) async {
    if (state.status == SortStatus.stop) {
      return;
    }
    List<SortModel> list = List.of(state.numbers);

    if (start >= end) {
      if (start == end) {
        await _makeSortedDelay(start, emit);
        await _delay;
      }
      return emit(state.copyWith(
        numbers: list,
        animationSpeed: state.animationSpeed + 1,
      ));
    }

    final pivot = start; // pivot pointer
    var leftP = start + 1; // left pointer
    var rightP = end; // right pointer

    while (rightP >= leftP) {
      if (state.status == SortStatus.stop) {
        return;
      }

      /// find Pivot
      await _makeSmallest(pivot, emit);
      await _makeSorting(leftP, emit);
      await _makeSorting(rightP, emit);
      await _delay;

      if (list[leftP].value > list[pivot].value &&
          list[rightP].value < list[pivot].value) {
        await _swap(leftP, rightP, list, emit);
      }
      if (list[leftP].value <= list[pivot].value) {
        await _resetStateAndRender(leftP, list, emit);

        leftP++;
      }
      if (list[rightP].value >= list[pivot].value) {
        await _resetStateAndRender(rightP, list, emit);

        rightP--;
      }
    }
    await _makeSorting(rightP, emit);
    await _delay;
    await _swap(pivot, rightP, list, emit);

    _makeSortedDelay(rightP, emit);
    await _delay;

    if (rightP - 1 - start < end - (rightP + 1)) {
      await _helper(start, rightP - 1, emit);
      await _helper(rightP + 1, end, emit);
    } else {
      await _helper(rightP + 1, end, emit);
      await _helper(start, rightP - 1, emit);
    }
  }

  Future<void> _insertSort(Emitter<SortState> emit) async {
    List<SortModel> arr = List.of(state.numbers);

    for (int i = 0; i < arr.length; ++i) {
      if (state.status == SortStatus.stop) {
        return;
      }
      int j = i;

      await _markNodesAsNotSorted(0, i - 2, arr, emit);
      while (j > 0 && arr[j].value < arr[j - 1].value) {
        if (state.status == SortStatus.stop) {
          return;
        }

        await _makeResetSort(j - 1, arr, emit);
        await _makeResetSort(j, arr, emit);
        await _swap(j, j - 1, arr, emit);
        await _resetStateAndRender(j, arr, emit);

        j--;
      }
    }
    await _makeSorted(0, arr.length - 1, arr, emit);
  }

  Future<void> _bubbleSort(Emitter<SortState> emit) async {
    List<SortModel> arr = List.of(state.numbers);
    var sorted = false;

    var counter = 0;
    while (!sorted) {
      if (state.status == SortStatus.stop) {
        return;
      }
      sorted = true;
      for (var i = 0; i < arr.length - 1 - counter; i++) {
        await _makeResetSort(i, arr, emit);
        await _makeResetSort(i + 1, arr, emit);

        if (arr[i].value > arr[i + 1].value) {
          await _swap(i, i + 1, arr, emit);
          sorted = false;
        }
        await _delay;
        _markNodesAsNotSorted(0, i, arr, emit);
      }
      _makeSortedDelay(arr.length - 1 - counter, emit);
      counter++;
    }
    await _makeSorted(0, arr.length - 1 - counter, arr, emit);
  }

  Future<dynamic> get _delay => Future.delayed(const Duration(
        milliseconds: 100,
      ));
}
