import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String result = '';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(input.replaceAll('x', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result = 'Erro';
        }
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String text, {Color? backgroundColor, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: textColor ?? Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: const TextStyle(fontSize: 36, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result,
                      style: const TextStyle(fontSize: 32, color: Colors.greenAccent),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton('C', backgroundColor: Colors.red, textColor: const Color.fromARGB(255, 0, 0, 0)),
                    buildButton('()', backgroundColor: Colors.grey[850], textColor: Colors.greenAccent),
                    buildButton('%', backgroundColor: Colors.grey[850], textColor: Colors.greenAccent),
                    buildButton('÷', backgroundColor: Colors.grey[850], textColor: Colors.greenAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('x', backgroundColor: Colors.grey[850], textColor: Colors.greenAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('-', backgroundColor: Colors.grey[850], textColor: Colors.greenAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('+', backgroundColor: Colors.grey[850], textColor: Colors.greenAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton('+/-'),
                    buildButton('0'),
                    buildButton('.'),
                    buildButton('=', backgroundColor: Colors.green, textColor: Colors.white),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}