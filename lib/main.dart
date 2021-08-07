import 'package:flutter/material.dart';

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _controller = TextEditingController();
  List<bool> selection = [false, true, false];
  String? tip;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (tip != null)
                Text(
                  tip.toString(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Text("Total Amount"),
              SizedBox(
                width: 80,
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "\$100.00",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ToggleButtons(
                  children: [Text('10%'), Text('15%'), Text('20%')],
                  isSelected: selection,
                  onPressed: selected,
                ),
              ),
              TextButton(
                onPressed: calculateTip,
                child: Text("Calaculate Tip"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selected(int selectedindex) {
    setState(() {
      for (int i = 0; i < selection.length; i++) {
        selection[i] = selectedindex == i;
      }
    });
  }

  calculateTip() {
    final total = double.parse(_controller.text);
    final selected = selection.indexWhere((element) => element);
    final percent = [0.1, 0.15, 0.2][selected];
    final totalTip = (percent * total).toStringAsFixed(2);
    setState(() {
      tip = '\$$totalTip';
    });
  }
}
