import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/sort/sort_bloc.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SortBloc sortBloc = BlocProvider.of<SortBloc>(context, listen: true);

    // return Selector<BubbleSortProvider, bool>(
    // selector: (_, bubble) => bubble.isSorting,
    // builder: (_, data, child) {
    //   return RaisedButton(
    //       onPressed: data
    //           ? null
    //           : () {
    //               Provider.of<BubbleSortProvider>(context, listen: false)
    //                   .sort();
    //             },
    //       child: child);
    // },
    // child: const Text('Sort'));
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 100,
              color: Colors.red.withOpacity(0.7),
              child: TextButton(
                  onPressed: (() =>
                      {context.read<SortBloc>().add(ResetSort())}),
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Container(
              width: 100,
              color: Colors.white.withOpacity(0.7),
              child: TextButton(
                  onPressed: (() => {context.read<SortBloc>().add(StopSort())}),
                  child: Text(
                    'Dừng',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            Container(
                width: 100,
                color: Colors.green.withOpacity(0.7),
                child: TextButton(
                    onPressed: (() => {sortBloc.add(StartSort())}),
                    child: Text(
                      'Bắt đầu',
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ) /* Selector<T, bool>(
        selector: (_, provider) => provider.isSorting,
        builder: (_, isSorting, child) {
          return ElevatedButton(
            child: child,
            /*  color: Colors.blue,
            disabledColor: Colors.blueGrey, */
            onPressed: isSorting
                ? null
                : () {
                    Provider.of<T>(context, listen: false).sort();
                  },
          );
        },
        child: const Text('Sort', style: TextStyle(color: Colors.white)),
      ), */
        );
  }
}
