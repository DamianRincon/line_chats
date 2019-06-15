import 'package:flutter/material.dart';

class LineChartData{
  final Color color;
  final String label;
  final List<double> data;
  LineChartData(this.label, this.data, this.color);
}