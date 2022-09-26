import 'package:flutter/material.dart';
import 'dart:math';

import 'score.dart';
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
        body: InheritedScore(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                SizedBox(
                    height: 50,
                    width: 225,
                    child: Container(
                        color: Colors.orangeAccent,
                        child: Center(child: Builder(builder: (context) {
                          return Text(
                              "Best Score : ${InheritedScore.of(context)?.scoreStructure.bestScore}",
                              style: const TextStyle(fontSize: 18.0));
                        })))),
                SizedBox(
                    height: 50,
                    width: 225,
                    child: Container(
                        color: Colors.amberAccent,
                        child: Center(child: Builder(builder: (context) {
                          return Text(
                              "Current Score : ${InheritedScore.of(context)?.scoreStructure.currentScore}",
                              style: const TextStyle(fontSize: 18.0));
                        }))))
              ])),
          Container(
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
                        setState(() {
                          move(0, tiles.length - 1, tiles.length, 0, 1, -1);
                        });
                      } else {
                        if (swipeDirection == "left") {
                          print("Action left");
                          setState(() {
                            move(0, 0, tiles.length, tiles.length - 1, 1, 1);
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
                          .toList())))
        ])));
  }

  move(int istart, int jstart, int iend, int jend, int ifactor, int jfactor) {
    for (int i = istart; i < iend; i += ifactor) {
      for (int j = jstart; jfactor * j < jend * jfactor; j += jfactor) {
        if (tiles[i][j] == tiles[i][j + 1 * jfactor] ||
            tiles[i][j + 1 * jfactor] == 0) {
          //merge
          if (j - 1 * jfactor > 0 &&
              j - 1 * jfactor < tiles.length &&
              tiles[i][j - 1 * jfactor] == 0) {
            merge(i, j, i, j + 1 * jfactor, i, j - 1 * jfactor);
          } else {
            merge(i, j, i, j + 1 * jfactor, i, j);
          }
        }
      }
    }
  }

  //x1 est la case qui récupére la somme
  merge(int x1, int y1, int x2, int y2, int mergex, int mergey) {
    tiles[mergex][mergey] = tiles[x1][y1] + tiles[x2][y2];
    tiles[x2][y2] = 0;
    if (mergey != y1) {
      tiles[x1][y1] = 0;
    }
  }

  spawnRandomTile() {
    List<Pair<int, int>> availablePlaces = [];

    for (int i = 0; i < tiles.length; i++) {
      for (int j = tiles.length - 1; j > 0; j--) {
        if (tiles[i][j] == 0) {
          availablePlaces.add(Pair(i, j));
        }
      }
    }

    Pair<int, int> randomPick =
        availablePlaces[Random().nextInt(availablePlaces.length)];
    tiles[randomPick.x][randomPick.y] = 2;
  }
}

class Pair<T1, T2> {
  final T1 x;
  final T2 y;

  Pair(this.x, this.y);
}
