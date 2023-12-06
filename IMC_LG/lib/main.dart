import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BMICalculator(),
        '/result': (context) => BMIResult(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Coloque a sua altura em metros, por favor:',
              ),
              controller: heightController,
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Coloque o seu peso em quilogramas(kg), por favor:',
              ),
              controller: weightController,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calculateBMI(context);
              },
              child: const Text('Calcule o IMC'),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  void calculateBMI(BuildContext context) {
    if (heightController.text.isNotEmpty && weightController.text.isNotEmpty) {
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);
      double bmiResult = weight / (height * height);
      Navigator.pushNamed(context, '/result', arguments: bmiResult);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro'),
            content:
                const Text('Por favor, preencha tanto altura quanto o peso.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class BMIResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bmiResult = ModalRoute.of(context)!.settings.arguments as double;
    String resultText;
    String interpretation;

    if (bmiResult < 18.5) {
      resultText = 'Abaixo do peso';
      interpretation = 'Você está abaixo do peso recomendável. :(';
    } else if (bmiResult >= 18.5 && bmiResult < 25) {
      resultText = 'Normal';
      interpretation = 'O seu peso está normal. :)';
    } else if (bmiResult >= 25 && bmiResult < 30) {
      resultText = 'Acima do peso';
      interpretation = 'Você está acima do peso recomendável. :(';
    } else {
      resultText = 'Obeso';
      interpretation = 'Você está em estado de obesidade. :<';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado do IMC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'IMC Resultado: ${bmiResult.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Resultado: $resultText',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              '$interpretation',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
