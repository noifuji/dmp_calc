import 'dart:math';

import 'package:flutter/material.dart';

import '../assets/constants.dart' as constants;

class ManaSymbolIcon extends StatelessWidget {
  final String color;
  final int cost;

  const ManaSymbolIcon({Key? key, required this.cost, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
/*    List<Color> symbolColor;
    List<double> symbolAngle;*/

    List<String> COLORS = [
      constants.MANA_COLOR_WHITE,
      constants.MANA_COLOR_BLUE,
      constants.MANA_COLOR_BLACK,
      constants.MANA_COLOR_RED,
      constants.MANA_COLOR_GREEN,
    ];

    Map<String, Color> COLOR_MAP = {
      constants.MANA_COLOR_WHITE: Colors.yellow,
      constants.MANA_COLOR_BLUE: Colors.blue,
      constants.MANA_COLOR_BLACK: Colors.grey,
      constants.MANA_COLOR_RED: Colors.red,
      constants.MANA_COLOR_GREEN: Colors.green
    };

    List<Color> colorList =
    COLORS.where((element) => color.contains(element)).toList().map((e) => COLOR_MAP[e]?? Colors.white).toList();

    return Container(
        child: CustomPaint(
          painter: CirclePainter(colorList),
          child:Text(
            cost > 0 ? cost.toString() : '0',
            style: const TextStyle(
                inherit: true,
                fontSize: 25.0,
                color: Colors.white,
                fontFamily: constants.appFont,
                shadows: [
                  Shadow(
                    // bottomLeft
                      offset: Offset(-1.5, -1.5),
                      color: Colors.black),
                  Shadow(
                    // bottomRight
                      offset: Offset(1.5, -1.5),
                      color: Colors.black),
                  Shadow(
                    // topRight
                      offset: Offset(1.5, 1.5),
                      color: Colors.black),
                  Shadow(
                    // topLeft
                      offset: Offset(-1.5, 1.5),
                      color: Colors.black),
                ]),
          ),
        ));


  }
}


class CirclePainter extends CustomPainter {
  final Paint bluePaint = Paint()..color = Colors.blue;
  final Paint redPaint = Paint()..color = Colors.red;
  final Paint greenPaint = Paint()..color = Colors.green;

  List<Color> colorList;


  CirclePainter(this.colorList);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromLTRB(
        -((size.height- size.width).abs())/2, 0, size.height-((size.height- size.width).abs())/2, size.height);

    Offset center = Offset(size.height/2-((size.height- size.width).abs())/2, size.height/2);


    if(colorList.length == 1) {
      canvas.drawCircle(center, size.height/2, Paint()..color = colorList[0]);

    } else if(colorList.length == 2) {
      canvas.drawPath(Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, 0, pi / 2, false), Paint()..color = colorList[0]);
      canvas.drawPath(Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, pi / 2, pi, false), Paint()..color = colorList[1]);
      canvas.drawPath(Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, pi * 3 / 2, pi / 2, false), Paint()..color = colorList[0]);

    } else if(colorList.length == 3) {
      //3色
      canvas.drawPath(Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, 0, pi * 2 / 3, false), Paint()..color = colorList[0]);
      canvas.drawPath(Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, pi * 2 / 3, pi * 2 / 3, false), Paint()..color = colorList[1]);
      canvas.drawPath(Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, pi * 4 / 3, pi * 2 / 3, false), Paint()..color = colorList[2]);

    } else if(colorList.length == 4) {
      for(int i = 0; i < colorList.length; i ++) {
    Paint p = Paint()..color = colorList[i];
    canvas.drawPath(Path()
    ..moveTo(center.dx, center.dy)
    ..arcTo(rect, pi * 1 / 2 * i, pi * 1 / 2, false), p);
    }

    } else if(colorList.length == 5) {
      for(int i = 0; i < colorList.length; i ++) {
        Paint p = Paint()..color = colorList[i];
        canvas.drawPath(Path()
          ..moveTo(center.dx, center.dy)
          ..arcTo(rect, pi * 2 / 5 * i, pi * 2 / 5, false), p);
      }

    } else {
      canvas.drawCircle(center, size.height/2, Paint()..color = Colors.white);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}