import 'package:calculator_app/class/constants.dart';
import 'package:calculator_app/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentInput = "";
  bool newLine = true;
  List<Widget> historyList;

  @override
  void initState() {
    super.initState();
    historyList = [];
  }

  void appendInput(String str) {
    if (newLine) {
      currentInput = "";
    }
    setState(() {
      currentInput += str;
      newLine = false;
    });
  }

  void clearAll(String str) {
    setState(() {
      currentInput = "";
      historyList = [];
    });
  }

  void deleteLastInput(String str) {
    setState(() {
      if (currentInput.length > 0) {
        currentInput = currentInput.substring(0, currentInput.length - 1);
      }
    });
  }

  void appendHistory(String str) {
    List<Widget> list = historyList.toList();

    list.add(Align(
      alignment: Alignment.bottomRight,
      child: Container(
        child: Text(str, style: TextStyle(fontSize: 18, color: Colors.grey[400])),
      ),
    ));

    setState(() {
      historyList = list;
    });
  }

  void calculateValue(String str) {
    if (currentInput.isNotEmpty) {
      String res = "";
      try {
        Parser p = Parser();
        Expression exp = p.parse(currentInput);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);

        res = eval.toStringAsFixed(5);
      } catch (_) {
        res = "N/A";
      }

      appendHistory('$currentInput = $res');

      setState(() {
        currentInput = res;
        newLine = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.grey[100],
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.grey[100],
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: ListView(children: historyList),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(currentInput,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      CustomButton(
                        value: 'AC',
                        color: Colors.grey[700],
                        callback: clearAll,
                      ),
                      CustomButton(
                        value: 'DEL',
                        color: Colors.grey[700],
                        callback: deleteLastInput,
                      ),
                      CustomButton(
                        value: '%',
                        color: Colors.grey[700],
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '/',
                        color: Colors.orange,
                        callback: appendInput,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      CustomButton(
                        value: '7',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '8',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '9',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: 'x',
                        color: Colors.orange,
                        callback: appendInput,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      CustomButton(
                        value: '4',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '5',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '6',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '-',
                        color: Colors.orange,
                        callback: appendInput,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      CustomButton(
                        value: '1',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '2',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '3',
                        color: Colors.grey,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '+',
                        color: Colors.orange,
                        callback: appendInput,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      CustomButton(
                        value: '0',
                        color: Colors.grey,
                        flex: 3,
                        callback: appendInput,
                      ),
                      CustomButton(
                        value: '=',
                        color: Colors.orange,
                        callback: calculateValue,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
