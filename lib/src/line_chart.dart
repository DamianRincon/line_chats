import 'package:line_charts/line_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LineCharts extends StatelessWidget {
  
  LineCharts({
    Key key,
    @required this.data,
    this.showLabel = false,
    this.lineWidth = 3.5,
    this.height = 100.0,
    this.width = 300.0,
  }): assert(data != null),
  assert(lineWidth != null),
  assert(height != null),
  assert(width != null),
  super(key: key);
  
  final List<LineChartData> data;
  final double lineWidth;
  final double width;
  final double height;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: width,
      maxHeight: height,
      child: Column(
        children: <Widget>[
          showLabel ? labels(data) : Padding(padding: EdgeInsets.all(0.1)),
          CustomPaint(
            size: Size.fromHeight(height),
            painter: new _LineChartPainter(
              data,
              lineWidth: lineWidth,
            ),
          )
        ],
      ),
    );
  }
}

Widget labels(data){
  List<Widget> dots = List<Widget>();

  for (var item in data) {
    dots.add(
      Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child:Container(
              height: 7,
              width: 15,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 2.0
                  )
                ]
              ),
            ),
          ),
          Text(item.label)
        ],
      )
    );
  }
  return Row( mainAxisAlignment: MainAxisAlignment.center, children: dots);
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter(this.dataPoints, { @required this.lineWidth, this.gridLineWidth });

  final List<LineChartData> dataPoints;
  final double lineWidth;
  double min = 1000000;
  double max = 0;
  final double gridLineWidth;
    
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width - lineWidth;
    final double height = size.height - lineWidth;
    dataPoints.forEach((b) {
      max = max.compareTo(b.data.reduce((curr, next) => curr > next? curr: next))
       >= 0 ? max : b.data.reduce((curr, next) => curr > next? curr: next);
      min = min.compareTo(b.data.reduce((curr, next) => curr < next? curr: next))
       >= 0 ? b.data.reduce((curr, next) => curr < next? curr: next) : min;
    });

    final double heightNormalizer = height / (max - min);
       
    for (var point in dataPoints) {
      final Path path = new Path();
      final double widthNormalizer = width / point.data.length;
      for (int i = 0; i < point.data.length; i++) {
        double x = i * widthNormalizer + lineWidth / 2;
        double y = height - (point.data[i] - min) * heightNormalizer + lineWidth / 2;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      
      Paint paint = new Paint()
      ..strokeWidth = lineWidth
      ..color = point.color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_LineChartPainter old) {
    return dataPoints != old.dataPoints ||
      lineWidth != old.lineWidth ||        
      gridLineWidth != old.gridLineWidth;
  }
}