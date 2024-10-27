import 'package:flutter/material.dart';

void main() => runApp(ConversionApp());

class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConversionHomePage(),
    );
  }
}

class ConversionHomePage extends StatefulWidget {
  @override
  _ConversionHomePageState createState() => _ConversionHomePageState();
}

class _ConversionHomePageState extends State<ConversionHomePage> {
  final TextEditingController _valueController = TextEditingController();
  String _fromUnit = 'meters';
  String _toUnit = 'feet';
  double _result = 0.0;

  // Conversion logic
  void _convert() {
    double value = double.tryParse(_valueController.text) ?? 0;
    setState(() {
      if (_fromUnit == 'meters' && _toUnit == 'feet') {
        _result = value * 3.28084;
      } else if (_fromUnit == 'feet' && _toUnit == 'meters') {
        _result = value / 3.28084;
      } else if (_fromUnit == 'kilometers' && _toUnit == 'miles') {
        _result = value * 0.621371;
      } else if (_fromUnit == 'miles' && _toUnit == 'kilometers') {
        _result = value / 0.621371;
      } else {
        _result = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Measures Converter'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Value', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter value',
              ),
            ),
            SizedBox(height: 16),
            Text('From', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _fromUnit,
              items: <String>['meters', 'feet', 'kilometers', 'miles']
                  .map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _fromUnit = value!;
                });
              },
            ),
            SizedBox(height: 16),
            Text('To', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _toUnit,
              items: <String>['meters', 'feet', 'kilometers', 'miles']
                  .map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _toUnit = value!;
                });
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _convert,
                child: Text('Convert'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '${_valueController.text} $_fromUnit are ${_result.toStringAsFixed(3)} $_toUnit',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
