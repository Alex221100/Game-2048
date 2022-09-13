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
    return Container(color: color, child: Text(value.toString()));
    /*child: Padding(
          padding: EdgeInsets.all(70.0),
        ));*/
  }

  void merge(ColorfulTileState mergedTile) {
    value += mergedTile.value;
  }
}
