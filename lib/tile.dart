import 'package:flutter/material.dart';

class StatefulColorfulTile extends StatefulWidget {
  StatefulColorfulTile(this.value, {super.key});

  int value;

  @override
  ColorfulTileState createState() => ColorfulTileState(value);
}

class ColorfulTileState extends State<StatefulColorfulTile> {
  ColorfulTileState(this.value);

  Color? color;
  int value;

  @override
  void initState() {
    super.initState();
    color = value > 0
        ? Colors.lightBlue[2048 - value]
        : const Color.fromRGBO(204, 192, 179, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        height: 100,
        width: 100,
        child: Center(
            child: Text(value > 0 ? '$value' : "",
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = const Color.fromRGBO(119, 110, 101, 47),
                ))));
    /*child: Padding(
          padding: EdgeInsets.all(70.0),
        ));*/
  }

  void merge(ColorfulTileState mergedTile) {
    value += mergedTile.value;
  }
}
