import 'package:flutter/material.dart';

import '../painters/circle_ok_painter.dart';

class WidgetPainter extends StatefulWidget {
  List list;
  double duration;
  double height = 50;
  double width = 50;


  WidgetPainter({Key? key, required this.duration,required this.list}) : super(key: key);

  @override
  State<WidgetPainter> createState() => _WidgetPainter();
}

class _WidgetPainter extends State<WidgetPainter>
    with SingleTickerProviderStateMixin {
  double animRadius = 20.0;
  double animRadiusOk = 0;
  double animRadiusBack = 20.0;
  double waveGap = 0.0;
  double animLongLineOkDx = 25.0;
  double animLongLineOkDxB = 37.5;
  double animShortLineOkDx = 25.0;
  double animShortLineOkDxB = 18.75;
  double animLongLineOkDy = 30.0;
  double animLongLineOkDyB = 17.5;
  double animShortLineOkDy = 30.0;
  double animShortLineOkDyB = 23.75;

  late Animation<double> _animationCircles;
  late Animation<double> _animationLongLinesDx;
  late Animation<double> _animationLongLinesDxB;
  late Animation<double> _animationShortLinesDx;
  late Animation<double> _animationShortLinesDxB;
  late Animation<double> _animationLongLinesDy;
  late Animation<double> _animationLongLinesDyB;
  late Animation<double> _animationShortLinesDy;
  late Animation<double> _animationShortLinesDyB;
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
          height: widget.height,
          width: widget.width,
          child: InkWell(
            onTap: (() {
              setState(() {
                var nowColor = widget.list[index]['color'];
                var nowIsFilled = widget.list[index]['isFilled'];

                controller.reset();

                controller.forward();

                _animationCircles = Tween(begin: 20.0, end: 0.0).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animRadius = _animationCircles.value;
                      animRadiusOk = (_animationCircles.value - 20).abs()/10;
                    });
                  });




                _animationLongLinesDx = Tween(begin: 25.0, end: 37.5).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animLongLineOkDx = _animationLongLinesDx.value;
                    });
                  });
                _animationLongLinesDxB = Tween(begin: 37.5, end: 25.0).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animLongLineOkDxB = _animationLongLinesDxB.value;
                    });
                  });


                _animationShortLinesDx = Tween(begin: 25.0, end: 18.75).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animShortLineOkDx = _animationShortLinesDx.value;
                    });
                  });
                _animationShortLinesDxB = Tween(begin: 18.75, end: 25.0).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animShortLineOkDxB = _animationShortLinesDxB.value;
                    });
                  });



                _animationLongLinesDy = Tween(begin: 30.0, end: 17.5).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animLongLineOkDy = _animationLongLinesDy.value;
                    });
                  });
                _animationLongLinesDyB = Tween(begin: 17.5, end: 30.0).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animLongLineOkDyB = _animationLongLinesDyB.value;
                    });
                  });

                _animationShortLinesDy = Tween(begin: 30.0, end: 23.75).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animShortLineOkDy = _animationShortLinesDy.value;
                    });
                  });
                _animationShortLinesDyB = Tween(begin: 23.75, end: 30.0).animate(controller)
                  ..addListener(() {
                    setState(() {
                      animShortLineOkDyB = _animationShortLinesDyB.value;
                    });
                  });





                for (var i in widget.list) {
                  if (i['color'] == nowColor) {
                    i['isFilled'] = !nowIsFilled;
                    i['wasFilled'] = true;
                  } else {
                    i['wasFilled'] = i['isFilled'];
                    i['isFilled'] = false;
                  }
                }
              });
            }),
            child: CustomPaint(
              painter: CircleOkPainter(
                  color: widget.list[index]['color'],
                  isFilled: widget.list[index]['isFilled'],
                  wasFilled: widget.list[index]['wasFilled'],
                  animRadius: animRadius,
                animRadiusOk:animRadiusOk,
              center: Offset(widget.width/2, widget.height/2),
                animLongLineOkDx: animLongLineOkDx, animLongLineOkDxB: animLongLineOkDxB, animLongLineOkDyB: animLongLineOkDyB, animLongLineOkDy: animLongLineOkDy, animShortLineOkDxB: animShortLineOkDxB, animShortLineOkDyB: animShortLineOkDyB, animShortLineOkDx: animShortLineOkDx, animShortLineOkDy: animShortLineOkDy,),
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