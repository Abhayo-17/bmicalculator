import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0;
  String _resultText = "";

  List<String> height = ['cm', 'm', 'ft'];
  String hdrop = 'm';
  List<String> weight = ['kg', 'lbs'];
  String wdrop = 'kg';
  String witem = 'kg', hitem = 'm';

  double bmi = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Title(color: Colors.white, child: Text("BMI Calculator")),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 200,
                child: TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Height'),
                ),
              ),
              DropdownButton<String>(
                value: hdrop,
                items: height.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    hdrop = newValue ?? '';
                    hitem = newValue!;
                  });
                },
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 200,
                child: TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight'),
                ),
              ),
              DropdownButton<String>(
                value: wdrop,
                items: weight.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    wdrop = newValue ?? '';
                    witem = newValue!;
                  });
                },
              )
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // print(heightv);
                      // print(weightv);
                      // print(witem);
                      calculatebmi();
                      // catagory();
                    },
                    child: Text("Calculate")),
              ],
            ),
            // SizedBox(height: 20),
            Column(
              children: [
                Text('BMI Result: ${bmi.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20)),
                Text(cat, style: TextStyle(fontSize: 20))
              ],
            )
          ],
        ),
      )),
    );
  }

  late double heightv, weightv;
  late String cat = 'Null';
  void calculatebmi() {
    // print('Hello');
    heightv = double.parse(_heightController.text);
    weightv = double.parse(_weightController.text);

    // print(heightv);
    // print(weightv);

    convert();
    double bmi = weightv / (heightv * heightv);
    if (bmi < 18.5) {
      cat = 'Underweight';
    } else if (bmi < 24.9) {
      cat = 'Normal Weight';
    } else if (bmi < 29.9) {
      cat = 'overweight';
    } else
      cat = 'Obese';
    // print('Hello');
    // print(bmi);
    setState(() {
      this.bmi = bmi;
    });
  }

  void convert() {
    // print(witem);
    if (witem != 'kg' || hitem != 'm') {
      print("YES");
      if (witem == 'lbs') {
        weightv = weightv * 0.453592;
      }
      if (hitem == 'cm') {
        heightv = heightv * 0.01;
      }

      if (hitem == 'ft') {
        heightv = heightv * 0.3048;
      }
    }
  }
}
