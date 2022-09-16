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
    String? swipeDirection;

    return Scaffold(
        body: Center(
            child: Container(
                color: const Color.fromRGBO(187, 173, 160, 1),
                height: 450,
                width: 450,
                child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dx > 1) {
                        swipeDirection = "right";
                      } else {
                        if (details.delta.dx < -1) {
                          swipeDirection = "left";
                        } else {
                          if (details.delta.dy > 1) {
                            swipeDirection = "down";
                          } else {
                            if (details.delta.dy < -1) {
                              swipeDirection = "up";
                            }
                          }
                        }
                      }
                    },
                    onPanEnd: (details) {
                      if (swipeDirection != null) {
                        if (swipeDirection == "right") {
                          print("Action right");
                        } else {
                          if (swipeDirection == "left") {
                            print("Action left");
                            setState(() {
                              moveLeft();
                            });
                          } else {
                            if (swipeDirection == "down") {
                              print("Action down");
                            } else {
                              if (swipeDirection == "up") {
                                print("Action up");
                              }
                            }
                          }
                        }
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

  moveLeft() {
    for (int i = 0; i < tiles.length; i++) {
      for (int j = tiles.length - 1; j > 0; j--) {
        if (tiles[i][j] == tiles[i][j - 1] || tiles[i][j - 1] == 0) {
          //merge
          merge(i, j - 1, i, j);
        }
      }
    }
  }

  //x1 est la case qui récupére la somme
  merge(int x1, int y1, int x2, int y2) {
    tiles[x1][y1] = tiles[x1][y1] + tiles[x2][y2];
    tiles[x2][y2] = 0;
  }
}
