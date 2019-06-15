import 'package:flutter/material.dart';
import 'package:line_charts/line_charts.dart';
import 'package:line_charts/line_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<LineChartData> datos = new List<LineChartData>();

  @override
  void initState() {
    datos.add(new LineChartData(
      "Ganancias",
      [10,4,6,8,10,20,14,16,18,20],
      Colors.red
    ));
    datos.add(new LineChartData(
      "Gastos",
      [3,6,9,12,30,8,21,24,27,15],
      Colors.blue
    ));
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body:Center(child: Container(
          height: 200,
          child: Padding(
          padding: EdgeInsets.all(10),
          child: LineCharts(
            data: datos,
            showLabel: true,
            lineWidth: 4.0,
          ),
          )
        ),
      )
      ),
    );
  }
}
