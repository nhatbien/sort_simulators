List<int> selectionSort(List<int> list) {
  for (int i = 0; i <= list.length - 1; i++) {
    var smallestIndex = i;
    for (int j = i + 1; j < list.length; j++) {
      if (list[j] < list[smallestIndex]) {
        smallestIndex = j;
      }
    }
    final tmp = list[i];
    list[i] = list[smallestIndex];
    list[smallestIndex] = tmp;
  }
  return list;
}
