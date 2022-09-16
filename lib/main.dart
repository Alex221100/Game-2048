import 'package:flutter/material.dart';
import 'dart:math';

import 'tile.dart';

void main() {
  runApp(MaterialApp(home: PositionedTiles(key: UniqueKey())));
}

class PositionedTiles extends StatefulWidget {
  const PositionedTiles({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  late List<List<int>> tiles;

  @override
  void initState() {
    super.initState();
    tiles = List.generate(
        4,
        (index) => List.generate(4, (index2) {
              return 2;
              //return StatefulColorfulTile(key: UniqueKey());
            }),
        growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                color: const Color.fromRGBO(187, 173, 160, 1),
                height: 450,
                width: 450,
                child: GestureDetector(
                    onHorizontalDragEnd: (dragEndDetails) {
                      if (dragEndDetails.primaryVelocity! < 0) {
                        // Page forwards
                        print('Move left');
                        //_goForward();
                      } else if (dragEndDetails.primaryVelocity! > 0) {
                        // Page backwards
                        print('Move right');
                        setState(() {
                          tiles[0][0] = tiles[0][0] + 1;
                        });
                        print(tiles[0][0]);
                      }
                    },
                    onVerticalDragEnd: (dragEndDetails) {
                      if (dragEndDetails.primaryVelocity! < 0) {
                        // Page forwards
                        print('Move bottom');
                        //_goForward();
                      } else if (dragEndDetails.primaryVelocity! > 0) {
                        // Page backwards
                        print('Move top');
                        //_goBack();
                      }
                    },
                    child: GridView.count(
                        crossAxisCount: 4,
                        children: tiles
                            .expand((value) => value)
                            .map<StatefulColorfulTile>((element) =>
                                StatefulColorfulTile(element, key: UniqueKey()))
                            .toList())))));
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
