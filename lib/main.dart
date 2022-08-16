import 'package:anim/common/colors.dart';
import 'package:anim/widgets/widget_painter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  List list = [];
  double value = 200;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    widget.list = colorGenerate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Expanded(child: WidgetPainter(list: widget.list, duration: widget.value)),
                SizedBox(
                  height: 40,
                ),
                Text('${widget.value.floor().toString()}ms'),
                Slider(value: widget.value,
                    min: 200,
                    max: 2000,
                    onChanged: (double newValue){setState((){
                      widget.value = newValue;
                    });},),
                ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        widget.list += colorGenerate();
                      });
                    }),
                    child: Text('Add elements')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List colorGenerate() {
  return List.generate(
      20,
          (index) => {
        'id': index,
        'color': (AppColors.allColors..shuffle()).first,
        'isFilled': false,
        'wasFilled': false,
      }).toList();
}



