import 'package:flutter/material.dart';

class StatefulColorfulTile extends StatefulWidget {
  const StatefulColorfulTile({Key? key}) : super(key: key);

  @override
  ColorfulTileState createState() => ColorfulTileState();
}

class ColorfulTileState extends State<StatefulColorfulTile> {
  ColorfulTileState({int? value}) : this.value = value ?? 2;

  Color? color;
  int value;

  @override
  void initState() {
    super.initState();
    color = Colors.lightBlue[2048 - value];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        height: 100,
        width: 100,
        child: Center(
            child: Text(value.toString(),
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Color.fromRGBO(119, 110, 101, 47),
                ))));
    /*child: Padding(
          padding: EdgeInsets.all(70.0),
        ));*/
  }

  void merge(ColorfulTileState mergedTile) {
    value += mergedTile.value;
  }
}
