import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SortNumberState {
  open,
  sort,
  sorted,
  pivot,
}

class SortModel extends Equatable {
  SortModel(this.value) : key = GlobalKey() {
    state = SortNumberState.open;
    color = Colors.black54;
  }

  final int value;
  final GlobalKey key;
  SortNumberState? state;
  Color? color;

  void reset() {
    state = SortNumberState.open;
    color = Colors.black54;
  }

  void sort() {
    state = SortNumberState.sort;
    color = Colors.blue;
  }

  void sorted() {
    state = SortNumberState.sorted;
    color = Colors.green;
  }

  void pivot() {
    state = SortNumberState.pivot;
    color = Colors.pink;
  }

  @override
  List<Object?> get props => [value, key, state, color];
}
