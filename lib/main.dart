import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Tip Calculator'),
          leading: Icon(Icons.money_sharp),
        ),
        body: homeColumn(),
      ),
    );
  }
}

// ignore: camel_case_types
class homeColumn extends StatefulWidget {
  const homeColumn({
    Key? key,
  }) : super(key: key);

  @override
  _homeColumnState createState() => _homeColumnState();
}

// ignore: camel_case_types
class _homeColumnState extends State<homeColumn> {
  String? tip;
  final controller = TextEditingController();
  List<bool> _selected = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (tip != null)
            Text(
              tip.toString(),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          Text("Total Amount"),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              controller: controller,
              decoration: InputDecoration(
                hintText: '\$100.00',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ToggleButtons(
              children: [
                Text("10%"),
                Text("15%"),
                Text("20%"),
              ],
              isSelected: _selected,
              onPressed: selectonFun,
            ),
          ),
          TextButton(
            onPressed: calcuateTip,
            child: Text(
              "Calculate Tip",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
          )
        ],
      ),
    );
  }

  void selectonFun(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selected.length; i++) {
        _selected[i] = selectedIndex == i;
      }
    });
  }

  calcuateTip() {
    final amount = double.parse(controller.text);
    final selectedIndex = _selected.indexWhere((element) => element);
    final tipPercent = [0.1, 0.15, 0.2][selectedIndex];
    final tiptotal = (tipPercent * amount).toStringAsFixed(2);
    setState(() {
      tip = "\$$tiptotal";
    });
  }
}
