import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sort_simulator/core/routes/app_routes.dart';

import '../blocs/sort/sort_bloc.dart';

class SortSubmit extends StatelessWidget {
  const SortSubmit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SortBloc sortBloc = BlocProvider.of<SortBloc>(context, listen: true);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                return Colors.green;
              }
              return Colors.black;
            }),
            textStyle: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return size 40, otherwise 20
              if (states.contains(MaterialState.pressed)) {
                return TextStyle(fontSize: 40);
              }
              return TextStyle(fontSize: 20);
            }),
          ),
          child: Text("SORT"),
          onPressed: () {
            context.read<SortBloc>().add(SubmitInput());
            AppNavigator.push(Routes.sortPage);
          },
        ));
  }
}
