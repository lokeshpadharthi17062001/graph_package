library graph_package;

import 'package:flutter/material.dart';

class Graphcls extends CustomPainter {
  Map<String, dynamic> myData;

  Graphcls(this.myData);

  @override
  void paint(Canvas canvas, Size size) {
    var x = [];
    var points = [];
    var n = (size.width - 100);
    for (int i = 0; i < myData['x'].length; i++) {
      DateTime dt = DateTime.parse(myData['x'][i]);
      x.add(dt.hour * 3600 + dt.minute * 60 + dt.second);
    }

    var x11 = [];
    for (int i = 0; i < x.length; i++) {
      x11.add(x[i]);
    }
    x11.sort();
    for (int i = 0; i < x.length; i++) {
      x[i] = (x[i] - x11[0]) *
              (size.width - 50 - 50) /
              (x11[x11.length - 1] - x11[0]) +
          50;
    }

    var l1 = [0], r1 = [0];
    for (int i = 0; i < myData['y1'].length; i++) {
      l1.add(myData['y1'][i]);
      r1.add(myData['y2'][i]);
    }
    for (int i = 0; i < x.length; i++) {
      points.add(Offset(
          (x[i]),
          size.height -
              50 -
              myData['y'][i] *
                  (size.height + 50 - l1[l1.length - 1]) /
                  l1[l1.length - 1]));
    }
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    var l = [], r = [];

    for (int i = 0; i <= myData['y1'].length; i++) {
      l.add(l1[i] * (size.height + 50 - l1[l1.length - 1]) / l1[l1.length - 1]);
      r.add(r1[i] * (size.height + 50 - l1[l1.length - 1]) / l1[l1.length - 1]);
    }
    Offset p1 = Offset(50, size.height - 80 - (l[l.length - 1]));
    Offset p3 = Offset(size.width - 50, size.height - 50);
    Offset p2 = Offset(50, size.height - 50);
    Offset p4 = Offset(size.width - 50, size.height - 50);
    Offset p5 = Offset(size.width - 50, size.height - 80 - (l[l.length - 1]));
    canvas.drawLine(p4, p5, paint);
    canvas.drawLine(p1, p2, paint);
    canvas.drawLine(p3, p2, paint);
    var color = [
      Colors.lightGreen,
      Colors.orange,
      Colors.grey,
      Colors.blueGrey,
      Colors.blue,
      Colors.orangeAccent
    ];
    for (int i = 0; i < l.length - 1; i++) {
      Offset point1 =
          Offset(50 + 1.5, size.height - 50 - (l[i] + l[i + 1]) / 2);
      Offset point2 = Offset(
          size.width - 50 - 1.5, size.height - 50 - (l[i] + l[i + 1]) / 2);
      canvas.drawLine(
          point1,
          point2,
          Paint()
            ..color = color[i]
            ..strokeWidth = (l[i + 1] - l[i]) * (size.height + 1) / size.height
            ..style = PaintingStyle.stroke);
    } //colors
    for (int i = 0; i < l.length - 1; i++) {
      Offset point =
          Offset(size.width / 2, size.height - 50 - (l[i] + l[i + 1]) / 2);
      TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.black87),
          text: "Zone " + ((i + 1).toString()));
      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, point);
    } //Zones
    for (int i = 0; i < l.length; i++) {
      Offset point1 = Offset(50 - 25, size.height - 50 - l[i]);
      Offset point2 = Offset(size.width - 25, size.height - 50 - l[i]);
      canvas.drawLine(point1, point2, paint);
    } //region lines
    for (int i = 0; i < l.length - 1; i++) {
      TextSpan span1 = TextSpan(
          style: const TextStyle(color: Colors.black),
          text: (l1[i + 1]).toString());
      TextPainter tp =
          TextPainter(text: span1, textDirection: TextDirection.ltr);
      tp.layout();
      Offset point3 = Offset(50 / 2 - 5, size.height - 50 - (l[i + 1]));
      tp.paint(canvas, point3);
      //left points
      TextSpan span2 = TextSpan(
          style: const TextStyle(color: Colors.black),
          text: (r1[i + 1]).toString());
      TextPainter tp2 =
          TextPainter(text: span2, textDirection: TextDirection.ltr);
      tp2.layout();
      Offset point4 =
          Offset(size.width - 50 + 5, size.height - 50 - (l[i + 1]));
      tp2.paint(canvas, point4);
      //right points
    }
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].dx <= n + 50) {
        canvas.drawLine(
            points[i],
            points[i + 1],
            Paint()
              ..color = Colors.red
              ..strokeWidth = 3.0
              ..strokeCap = StrokeCap.round);
      }
    } //graph
    var pl = [], b = [], a = [], x1 = [];
    var numOfPoints = 0;
    for (var i = 25; i <= n + 50; i += 50) {
      numOfPoints += 1;
    }
    var count = 0;
    for (var i = 25;
        i < n + 50 && count <= numOfPoints + 1;
        i += 50, count += 1) {
      x1.add(i);
      a.add((((count) * (x.length - 1) / (numOfPoints - 1))).round());
    } //x-points
    for (int i = 0; i < a.length; i++) {
      pl.insert(i, Offset(double.parse(x1[i].toString()), size.height - 50));
      b.add(myData['x'][a[i]].substring(11, 16));
      TextSpan span =
          TextSpan(style: const TextStyle(color: Colors.black), text: b[i]);
      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();
      Offset point = pl[i];
      tp.paint(canvas, point);
    } //x-labels
    var text = [
      myData['y1label'],
      myData['y2label'],
      myData['xlabel'] + '--->',
      myData['xlabel'] + '--->'
    ];
    var plots = [
      Offset(50 / 2 - 5, size.height - 80 - (l[l.length - 1])),
      Offset(size.width - 45, size.height - 80 - (l[l.length - 1])),
      Offset(size.width - 50 - text[3].length * 8, size.height - 25),
      Offset(50, size.height - 25)
    ];

    for (int i = 0; i < text.length; i++) {
      TextSpan span = TextSpan(
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          text: text[i]);
      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();
      Offset point = plots[i];
      tp.paint(canvas, point);
    }
    TextSpan span = TextSpan(
        style: const TextStyle(
            color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30),
        text: myData['title']);
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    Offset point = Offset(
        (size.width - 50 - 50) / 2, size.height - 80 - (l[l.length - 1]) - 25);
    tp.paint(canvas, point);
  }

  @override
  bool shouldRepaint(covariant oldDelegate) {
    return true;
  }
}
