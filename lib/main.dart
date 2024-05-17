import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _BMIHomePage(),
    );
  }
}

class _BMIHomePage extends StatefulWidget {
  const _BMIHomePage();

  @override
  _BMIHomePageState createState() => _BMIHomePageState();
}

class _BMIHomePageState extends State<_BMIHomePage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String result = '';
  Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Container(
        color: bgColor ?? Colors.indigo.shade200,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'BMI',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Enter your weight (in kgs)',
                  prefixIcon: Icon(Icons.line_weight),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: heightController,
                decoration: const InputDecoration(
                  labelText: 'Enter your height (in meters)',
                  prefixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateBMI,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 10),
              Text(
                result,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    final String weightText = weightController.text.trim();
    final String heightText = heightController.text.trim();

    if (weightText.isEmpty || heightText.isEmpty) {
      setState(() {
        result = 'Please fill all the required fields!';
        bgColor = null; // Reset background color
      });
      return;
    }

    final double weight = double.tryParse(weightText) ?? 0;
    final double height = double.tryParse(heightText) ?? 0;

    if (weight <= 0 || height <= 0) {
      setState(() {
        result = 'Invalid input. Please enter valid weight and height.';
        bgColor = null; // Reset background color
      });
      return;
    }

    final double bmi = weight / pow(height, 2);
    String bmiResult;

    if (bmi < 18.5) {
      bmiResult = 'Underweight';
      bgColor = Colors.red.shade200;
    } else if (bmi >= 18.5 && bmi < 25) {
      bmiResult = 'Normal weight';
      bgColor = Colors.green.shade200;
    } else if (bmi >= 25 && bmi < 30) {
      bmiResult = 'Overweight';
      bgColor = Colors.orange.shade200;
    } else {
      bmiResult = 'Obese';
      bgColor = Colors.red.shade900;
    }

    setState(() {
      result = 'Your BMI: ${bmi.toStringAsFixed(2)}\n($bmiResult)';
    });

    // Clear text fields after calculation
    weightController.clear();
    heightController.clear();
  }
}
