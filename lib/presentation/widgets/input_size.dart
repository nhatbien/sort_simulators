import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sort_simulator/presentation/blocs/sort/sort_bloc.dart';

import 'drop_down.dart';

class InputSize extends StatefulWidget {
  const InputSize({super.key});

  @override
  State<InputSize> createState() => _InputSizeState();
}

class _InputSizeState extends State<InputSize> {
  List<String> sizeList = [
    "Chọn nhanh",
    "10",
    "20",
    "50",
    "100",
    "200",
    "300",
    "1000"
  ];
  late String _selectedSize;
  void initState() {
    super.initState();
    _selectedSize = sizeList[0];
  }

  bool isDisabled = true;
  int maxArraySize = 1000;

  String errorMessage = "Invalid Size";

  updateSelectedSize(String value) {
    try {
      context.read<SortBloc>().add(RequestInputSort(size: int.parse(value)));
    } catch (e) {}
    setState(() {
      _selectedSize = value;
      isDisabled = false;
      if (_selectedSize == sizeList[0]) isDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Ex: 100',
                    hintStyle: TextStyle(color: Color(0xff9B9B9B)),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none),
                onChanged: (value) => {
                  context
                      .read<SortBloc>()
                      .add(RequestInputSort(size: int.parse(value)))
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            "or",
            style: theme.textTheme.caption
                ?.copyWith(color: Colors.grey[300], fontFamily: 'Arial'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: DropDownWidget(
                  key: UniqueKey(),
                  menuItemsList: sizeList,
                  selectedType: _selectedSize,
                  onTap: updateSelectedSize,
                )),
          ),
        ],
      ),
    );
  }
}
