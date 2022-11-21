import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sort_simulator/app.dart';
import 'package:sort_simulator/presentation/blocs/sort/sort_bloc.dart';

void main() {
/*   WidgetsFlutterBinding.ensureInitialized();
 */
  runApp(MultiBlocProvider(
    providers: [BlocProvider<SortBloc>(create: (context) => SortBloc())],
    child: const SortApp(),
  ));
}
