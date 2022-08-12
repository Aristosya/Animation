import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  List list = [];
  List colorRandom = [Colors.red, Colors.yellow, Colors.green, Colors.blue];
  double value = 200;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    widget.list = List.generate(
        20,
        (index) => {
              'id': index,
              'color': (widget.colorRandom..shuffle()).first,
              'isFilled': false,
              'wasFilled': false,
            }).toList();
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
                        print('added');
                        widget.list += List.generate(
                            20,
                            (index) => {
                                  'id': index,
                                  'color':
                                      (widget.colorRandom..shuffle()).first,
                                  'isFilled': false,
                              'wasFilled':false,
                                }).toList();
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

class WidgetPainter extends StatefulWidget {
  List list;
  double duration;

  WidgetPainter({Key? key, required this.duration,required this.list}) : super(key: key);

  @override
  State<WidgetPainter> createState() => _WidgetPainter();
}

class _WidgetPainter extends State<WidgetPainter>
    with SingleTickerProviderStateMixin {
  double animRadius = 20.0;
  double animRadiusBack = 20.0;
  double waveGap = 0.0;
  late Animation<double> _animation;
  late Animation<double> _animation_back;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: widget.duration.toInt()), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.duration = Duration(milliseconds: widget.duration.toInt());
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          width: 50,
          child: InkWell(
            onTap: (() {
              setState(() {
                var nowColor = widget.list[index]['color'];
                var nowIsFilled = widget.list[index]['isFilled'];

                controller.reset();

                controller.forward();

                _animation = Tween(begin: 20.0, end: 0.0).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animRadius = _animation.value;
                    });
                  });

                _animation_back = Tween(begin: 0.0, end: 20.0).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animRadiusBack = _animation_back.value;
                    });
                  });

                for (var i in widget.list) {
                  if (i['color'] == nowColor) {
                    i['isFilled'] = !nowIsFilled;
                    i['wasFilled'] = false;
                  } else {
                    i['wasFilled'] = i['isFilled'];
                    i['isFilled'] = false;
                  }
                }
              });
            }),
            child: CustomPaint(
              painter: MyPainter(
                  color: widget.list[index]['color'],
                  isFilled: widget.list[index]['isFilled'],
                  wasFilled: widget.list[index]['wasFilled'],
                  animRadius: animRadius,
                  animRadiusBack:animRadiusBack),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}

class MyPainter extends CustomPainter {
  final color;
  final isFilled;
  final wasFilled;
  final double animRadius;
  final double animRadiusBack;

  MyPainter({required this.animRadiusBack, required this.color, required this.isFilled, required this.animRadius, required this.wasFilled});


  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(25, 25);

    var outLineBrush = Paint()..color = color;

    var fillBrush = Paint()..color = Colors.white;

    var okLineBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawCircle(center, 25, outLineBrush);

    canvas.drawLine(Offset(25, 30), Offset(18.75, 18.75 + 5), okLineBrush);
    canvas.drawLine(Offset(25, 30), Offset(37.5, 12.5 + 5), okLineBrush);
    canvas.drawCircle(Offset(25, 30), 2, fillBrush);



    if(wasFilled) {
      canvas.drawCircle(center, animRadiusBack, fillBrush);
    }

    if (!isFilled && !wasFilled) {
      canvas.drawCircle(center, 20, fillBrush);
    }

    if (isFilled) {
      canvas.drawCircle(center, animRadius, fillBrush);
    }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
