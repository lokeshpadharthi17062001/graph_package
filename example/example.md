## Example

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/graph.dart';

void main() => runApp(const MaterialApp(
  home: Mygraph(),
  debugShowCheckedModeBanner: false,
));

class Mygraph extends StatefulWidget {
  const Mygraph({Key? key}) : super(key: key);

  @override
  State<Mygraph> createState() => _MygraphState();
}

class _MygraphState extends State<Mygraph> {
  Map<String, dynamic>? myData;

  @override
  void initState() {
    readjs();
    super.initState();
  }

  Future<void> readjs() async {
    final String response  = await rootBundle.loadString('assets/chart_data.json');
    final data = await json.decode(response);
    setState((){
      myData=data;
    });

  }

  @override
  Widget build(BuildContext context) {
    var scrsize = MediaQuery.of(context).size;
    if (myData != null) {
      return Scaffold(
        body: CustomPaint(
          painter: Graphcls(myData!),
          child: SizedBox(width: scrsize.width, height: scrsize.height),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}
```