import 'package:flutter/material.dart';

Map<int, Color> tileColors = {
  0: const Color(0xffccc0b3),
  2: const Color(0xffeee4da),
  4: const Color(0xffeee1c9),
  8: const Color(0xfff3b27a),
  16: const Color(0xfff69664),
  32: const Color(0xfff77c5f),
  64: const Color(0xfff75f3b),
  128: const Color(0xffedd073),
  256: const Color(0xffedcc62),
  512: const Color(0xffedc950),
  1024: const Color(0xffedc53f),
  2048: const Color(0xffedc22e),
};

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
    return Padding(
      padding: const EdgeInsets.all(8.8),
      child: Container(
        decoration: BoxDecoration(
          color: tileColors[value],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
  ),
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
                )))));
  }

  void merge(ColorfulTileState mergedTile) {
    value += mergedTile.value;
  }
}
