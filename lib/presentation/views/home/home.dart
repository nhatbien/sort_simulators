import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sort_simulator/presentation/blocs/sort/sort_bloc.dart';
import 'package:sort_simulator/presentation/widgets/button_submit.dart';
import 'package:sort_simulator/presentation/widgets/input_size.dart';

import '../../../core/routes/app_routes.dart';
import '../sort/sort_view.dart';

class HomeScrren extends StatelessWidget {
  const HomeScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text('123'),
        backgroundColor: Colors.transparent,
      ), */
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var theme = Theme.of(context);

    return BlocListener<SortBloc, SortState>(
      listener: (context, state) {
        if (state.status == SortStatus.loading) {
          AppNavigator.push(Routes.sortPage);
        }
        if (state.status == SortStatus.failure) {
          _showMyDialog(context, message: state.message);
        }
      },
      child: Stack(
        children: [
          const Positioned.fill(
            //
            child: Image(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(1.0),
                decoration: new BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.6), //here i want to add opacity
                ),
                height: 200,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        ('Nhập số lượng số ( ' +
                                BlocProvider.of<SortBloc>(context, listen: true)
                                    .state
                                    .size
                                    .toString() +
                                ' )')
                            .toUpperCase(),
                        style: theme.textTheme.subtitle2?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Expanded(child: InputSize()),
                      const SortSubmit(),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context,
      {required String message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                context.read<SortBloc>().add(ResetStatus());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sort_simulator/presentation/blocs/sort_bloc.dart';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SortBloc sortBloc = BlocProvider.of<SortBloc>(context, listen: true);

    int n = sortBloc.state.numbers.length;
    // bool isSorting = sortBloc.isSorting;

    List<int> numbers = sortBloc.state.numbers;
    List<int> indexArr = sortBloc.state.indexArr;
    /*  String value =
        getSortingTypeString(sortingTypes: sortBloc.selectedSortingType);
   */
    double animationSpeed = 300;
    int swapI = sortBloc.state.swapI;
    int swapJ = sortBloc.state.swapJ;
    bool swapping = swapI != swapJ;

    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();

    double division = width / n;
    double barWidth = division * 0.5;
    double barMargin = division * 0.25;

    List<double> heightArr = numbers
        .map((int value) => ((height - 150) * (value / n) + 10))
        .toList();

    List<double> marginArr =
        List.generate(numbers.length, (i) => (barMargin + (division * i)));

/*     indexArr.map((index) => (barMargin + (division * index))).toList();
 */
    Widget bar({required double height, required double width, Color? color}) {
      return Bar(
        height: height,
        margin: width,
        barWidth: barWidth,
        animationSpeed: 1000,
        color: color,
      );
    }

    /// Generating the bars
    List<Widget> children = List<Widget>.generate(
        n,
        (int index) => bar(
              height: heightArr[index],
              width: marginArr[index],
              color: swapping
                  ? index == swapI
                      ? Colors.red
                      : index == swapJ
                          ? Colors.green
                          : null
                  : null,
            ));

    List<Widget> _buildBody() {
      return children;
    }

    Widget sortButton() {
      return _button(
        text: "Sort",
        onPressed: (() => {sortBloc.add(StartSort())}),
      );
    }

    return BlocBuilder<SortBloc, SortState>(builder: (_, state) {
      return Scaffold(
          appBar: AppBar(title: const Text("MÔ PHỎNG THUẬT TOÁN SẮP XẾP")),
          body: SafeArea(
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: [
                  sortButton(),
                  Expanded(
                    child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: _buildBody()),
                  ),
                ],
              ),
            ),
          ));
    });
  }

  Widget _button({String? text, Function? onPressed}) {
    return TextButton(
      child: Text(text!),
      onPressed: () async {
        await onPressed!();
      },
    );
  }
}

class Bar extends StatelessWidget {
  final double _height;
  final double _margin;
  final double _barWidth;
  final int _animationSpeed;
  final Color? _color;

  const Bar({
    required double height,
    required double margin,
    required double barWidth,
    required int animationSpeed,
    Color? color,
  })  : this._height = height,
        this._margin = margin,
        this._barWidth = barWidth,
        this._animationSpeed = animationSpeed,
        this._color = color,
        assert(height != null),
        assert(margin != null),
        assert(barWidth != null),
        assert(animationSpeed != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: Duration(milliseconds: _animationSpeed),
      padding: EdgeInsets.only(left: _margin),
      child: Container(
        height: _height,
        width: _barWidth,
        decoration: BoxDecoration(
          color: _color ?? Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_barWidth / 2),
            topRight: Radius.circular(_barWidth / 2),
          ),
        ),
      ),
    );
  }
}
 */
