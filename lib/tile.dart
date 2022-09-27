import 'package:flutter/material.dart';

class StatefulColorfulTile extends StatefulWidget {
  StatefulColorfulTile(this.value, {super.key});

  int value;

  @override
  ColorfulTileState createState() => ColorfulTileState(value);
}

class ColorfulTileState extends State<StatefulColorfulTile> {
  ColorfulTileState(this.value)
      : color = value > 0
            ? Color.fromARGB(255 - value, 3, 168, 244)
            : const Color.fromRGBO(204, 192, 179, 1);

  Color color;
  int value;

  @override
  void initState() {
    super.initState();
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
                  fontSize: 50,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = const Color.fromRGBO(119, 110, 101, 47),
                ))));
  }

  void merge(ColorfulTileState mergedTile) {
    value += mergedTile.value;
  }
}
