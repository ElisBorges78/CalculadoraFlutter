import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '0';
  double _firstNumber = 0.0;
  String _operation = '';
  bool _shouldResetDisplay = false;

  void _calculate(String key) {
    setState(() {
      if (key == 'AC') {
        _display = '0';
        _firstNumber = 0.0;
        _operation = '';
        _shouldResetDisplay = false;
      } else if (key == '<x') {
        _display = _display.substring(0, _display.length - 1);
        if (_display.isEmpty) _display = '0';
      } else if (key == '+' || key == '-' || key == 'x' || key == '/') {
        if (_operation.isNotEmpty) {
          // Se já houver uma operação pendente, calculamos ela primeiro
          _performOperation();
        }
        _operation = key;
        _firstNumber = double.parse(_display.replaceAll(',', '.'));
        _display = '0';
        _shouldResetDisplay = false;
      } else if (key == '=') {
        // Se houver uma operação pendente, calculamos ela primeiro
        if (_operation.isNotEmpty) {
          _performOperation();
        }
      } else {
        if (_shouldResetDisplay) {
          _display = '0';
          _shouldResetDisplay = false;
        }
        if (_display == '0' && key != ',') {
          _display = key;
        } else {
          _display += key;
        }
      }
    });
  }

  void _performOperation() {
    double secondNumber = double.parse(_display.replaceAll(',', '.'));
    double result = 0.0;
    switch (_operation) {
      case '+':
        result = _firstNumber + secondNumber;
        break;
      case '-':
        result = _firstNumber - secondNumber;
        break;
      case 'x':
        result = _firstNumber * secondNumber;
        break;
      case '/':
        if (secondNumber != 0) {
          result = _firstNumber / secondNumber;
        } else {
          print('Error: Division by zero!');
          _display = 'Error';
          return;
        }
        break;
      default:
        return;
    }
    _display = result.toString().replaceAll('.', ',');
    _shouldResetDisplay = true;
    _operation = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Calculator'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(_display, style: TextStyle(fontSize: 72)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _calculate('AC'),
                child: Text('AC'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('<x'),
                child: Text('<x'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('#'),
                child: Text('#'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('%'),
                child: Text('%'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _calculate('7'),
                child: Text('7'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('8'),
                child: Text('8'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('9'),
                child: Text('9'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('/'),
                child: Text('/'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _calculate('4'),
                child: Text('4'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('5'),
                child: Text('5'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('6'),
                child: Text('6'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('x'),
                child: Text('x'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _calculate('1'),
                child: Text('1'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('2'),
                child: Text('2'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('3'),
                child: Text('3'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('-'),
                child: Text('-'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _calculate('0'),
                child: Text('0'),
              ),
              ElevatedButton(
                onPressed: () => _calculate(','),
                child: Text(','),
              ),
              ElevatedButton(
                onPressed: () => _calculate('='),
                child: Text('='),
              ),
              ElevatedButton(
                onPressed: () => _calculate('+'),
                child: Text('+'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          'Elisvanilton Borges Lopes',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
