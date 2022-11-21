import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sort_simulator/presentation/blocs/sort/sort_bloc.dart';

const List<String> list = <String>[
  'Sắp xếp chọn',
  'Sắp xếp chèn',
  'Sắp xếp nổi bọt'
];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortType>(
      icon: const Icon(
        Icons.menu,
        size: 40,
        color: Colors.white,
      ),
      elevation: 16,
      onSelected: (SortType result) {
        context.read<SortBloc>().add(SelectSort(sortType: result));
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SortType>>[
        const PopupMenuItem<SortType>(
          value: SortType.SELECTION,
          child: Text('Sắp xếp chọn'),
        ),
        const PopupMenuItem<SortType>(
          value: SortType.INSERTION,
          child: Text('Sắp xếp xen'),
        ),
        const PopupMenuItem<SortType>(
          value: SortType.BUBBLE,
          child: Text('Sắp xếp nổi bọt'),
        ),
        const PopupMenuItem<SortType>(
          value: SortType.QUICK,
          child: Text('Sắp xếp nhanh'),
        ),
      ],
    );
  }
}
