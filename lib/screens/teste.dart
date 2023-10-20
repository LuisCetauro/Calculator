import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String listA = '';
  String listB = '';
  double result = 0.0; 
  String selectedOperation = '';
  List<String> availableOperations = ['+', '-', '*', '/']; 
  bool addToA = true; 
  void addToSelectedList(String value) {
    setState(() {
      
      if (value == '.' && (addToA ? listA.contains('.') : listB.contains('.'))) {
        return; 
      }

      if (addToA) {
        listA += value;
      } else {
        listB += value;
      }
    });
  }

  void clearA() {
    setState(() {
      listA = '';
    });
  }

  void clearB() {
    setState(() {
      listB = '';
    });
  }

  void performOperation(String operator) {
    
    double? doubleValueA = double.tryParse(listA);
    double? doubleValueB = double.tryParse(listB);

    if (operator == '=') {
      if (doubleValueA != null && doubleValueB != null) {
        
        double resultValue;
        switch (selectedOperation) {
          case '+':
            resultValue = doubleValueA + doubleValueB;
            break;
          case '-':
            resultValue = doubleValueA - doubleValueB;
            break;
          case '*':
            resultValue = doubleValueA * doubleValueB;
            break;
          case '/':
            resultValue = doubleValueA / doubleValueB;
            break;
          default:
            resultValue = 0.0;
            break;
        }

        setState(() {
          result = resultValue;
          listA = '';
          listB = '';
          selectedOperation = ''; 
        });
      } else {
        setState(() {
          result = 0.0;
        });
      }
    } else {
      
      if (availableOperations.contains(operator)) {
        
        setState(() {
          selectedOperation = operator;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    String formattedResult = result.toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          Text("A: $listA", style: const TextStyle(fontSize: 24)),
          Text("B: $listB", style: const TextStyle(fontSize: 24)),
          if (selectedOperation.isNotEmpty)
            Text("Operation: $selectedOperation", style: const TextStyle(fontSize: 24)),
          Text("Result: $formattedResult", style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 150.0),
          const Divider(color: Colors.purple),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 450,
                width: 400,
                child: GridView.count(
                  crossAxisCount: 5,
                  children: <Widget>[
                    for (int i = 0; i <= 9; i++)
                      ElevatedButton(
                        onPressed: () {
                          addToSelectedList(i.toString());
                        },
                        child: Text(' $i '),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        addToSelectedList('.');
                      },
                      child: Text('.'),
                    ),
                    for (String operation in availableOperations)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            addToA = !addToA;
                          });
                          performOperation(operation);
                        },
                        child: Text(operation),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        performOperation('=');
                      },
                      child: const Text('='),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        clearA();
                      },
                      child: const Text('Clear A'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        clearB();
                      },
                      child: const Text('Clear B'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
