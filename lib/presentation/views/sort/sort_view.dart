import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sort_simulator/core/routes/app_routes.dart';
import 'package:sort_simulator/presentation/widgets/drop_down_menu.dart';

import '../../blocs/sort/sort_bloc.dart';
import '../../widgets/box.dart';
import '../../widgets/button.dart';

class SortPage extends StatelessWidget {
  SortPage({Key? key, this.blockSize = 100}) : super(key: key);

  final double blockSize;

  double _getHeight(double width, int numOfWidgets) {
    var horizontalFit = width ~/ blockSize;
    var rows = (numOfWidgets / horizontalFit).ceil();
    return rows * blockSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: AppBar(
        title: Text("Sắp xếp"),
      ), */
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var sortType = BlocProvider.of<SortBloc>(context, listen: true);
    String getTitle = sortType.state.sortSelected == SortType.SELECTION
        ? "Sắp xếp chọn"
        : sortType.state.sortSelected == SortType.INSERTION
            ? "Sắp xếp chèn"
            : sortType.state.sortSelected == SortType.QUICK
                ? "Sắp xếp nhanh"
                : "Sắp xếp nổi bọt";
    return Stack(children: [
      const Positioned.fill(
        //
        child: Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      LayoutBuilder(builder: (_, constraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: Colors.white,
                        iconSize: 40,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          context.read<SortBloc>().add(StopSort());
                          AppNavigator.pop();
                        },
                      ),
                      Text(getTitle.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white)),
                      const DropdownButtonExample(),
                      /*  IconButton(
                        color: Colors.white,
                        iconSize: 40,
                        icon: const Icon(Icons.menu),
                        onPressed: () {},
                      ), */
                    ],
                  )),
              //Cannot be const
              Container(
                width: 100,
                color: Colors.white.withOpacity(0.7),
                child: TextButton(
                    onPressed: (() => {_showMyDialog(context)}),
                    child: const Text(
                      'Thống kê',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              Expanded(
                child: Container(
                  width: constraints.maxWidth,
                  child: Center(child:
                      BlocBuilder<SortBloc, SortState>(builder: (_, state) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: _getHeight(
                          constraints.maxWidth,
                          state.numbers.length,
                        ),
                        child: Stack(
                          children: <Widget>[
                            for (var i = 0; i < state.numbers.length; i++)
                              SortWidget(
                                key: state.numbers[i].key,
                                number: state.numbers[i],
                                index: i,
                                widgetSize: blockSize,
                                containerWidth: constraints.maxWidth,
                              )
                          ],
                        ),
                      ),
                    );
                  })),
                ),
              ),
              /*             SortSpeed<T>(),
     */
              const SortButton()
            ],
          ),
        );
      }),
    ]);
    // return
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thống kê'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    const Text('Chọn:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(context
                        .watch<SortBloc>()
                        .state
                        .swapLengthSelection
                        .toString()),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    const Text('Xen:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(context
                        .watch<SortBloc>()
                        .state
                        .swapLengthInsertion
                        .toString()),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    const Text('Nổi bọt:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(context
                        .watch<SortBloc>()
                        .state
                        .swapLengthBubble
                        .toString()),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    const Text('Nhanh:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(context
                        .watch<SortBloc>()
                        .state
                        .swapLengthQuick
                        .toString()),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
