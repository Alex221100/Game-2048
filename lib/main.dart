import 'package:flutter/material.dart';
import 'dart:math';

import 'score.dart';
import 'tile.dart';

void main() {
  runApp(InheritedScore(
      child: MaterialApp(home: PositionedTiles(key: UniqueKey()))));
}

class PositionedTiles extends StatefulWidget {
  const PositionedTiles({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  late List<List<int>> tiles;
  int size = 4;

  @override
  void initState() {
    super.initState();
    tiles = resetGrid();
  }

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;
    InheritedScore inheritedScore = InheritedScore.of(context);

    List<DropdownMenuItem<int>> items = [
      const DropdownMenuItem(child: Text("4"),value: 4),
      const DropdownMenuItem(child: Text("5"),value: 5),
      const DropdownMenuItem(child: Text("6"),value: 6),
      const DropdownMenuItem(child: Text("7"),value: 7),
      ];

    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Center(
              child: Padding(padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Padding(
                padding: const EdgeInsets.only(right: 30),
                child: DropdownButton(
                  value: size,
                  onChanged: (int? newValue) {
                  setState(() {
                    size = newValue!;
                    resetGrid();
                  });},
                  items: items)),
                  Padding(
                padding: const EdgeInsets.only(right: 30),
                child:SizedBox(
                    height: 50,
                    width: 100,
                    
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(187, 173, 160, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                            child: Text(
                                "Best : ${InheritedScore.of(context).scoreStructure.bestScore}",
                                style: const TextStyle(fontSize: 18.0)))))),
                Padding(
                padding: const EdgeInsets.only(right: 30),
                child:SizedBox(
                    height: 50,
                    width: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(187, 173, 160, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                            child: Text(
                                "Score : ${InheritedScore.of(context).scoreStructure.currentScore}",
                                style: const TextStyle(fontSize: 18.0)))))),

                SizedBox(
                    height: 50,
                    width: 50,
                    child: GestureDetector(
                    onTap: (){
                      setState(() {
                        resetGrid();
                      });
                      
                    },
                    child:Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(187, 173, 160, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                            child: Center(
                            child: Image.asset('../assets/img/refresh.png'))))))
              ]))),
          Container(
              height: 450,
              width: 450,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(187, 173, 160, 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
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
                          move("right");
                        });
                      } else {
                        if (swipeDirection == "left") {
                          print("Action left");
                          setState(() {
                            move("left");
                          });
                        } else {
                          if (swipeDirection == "down") {
                            print("Action down");
                            setState(() {
                              move("down");
                            });
                          } else {
                            if (swipeDirection == "up") {
                              print("Action up");
                              setState(() {
                                move("up");
                              });
                            }
                          }
                        }
                      }

                      spawnRandomTile();
                      setState(() {
                        int newScore = countCurrentBestScore();
                        inheritedScore.scoreStructure.setCurrentScore(newScore);

                        for (var tile in tiles) {
                          if (tile == 2048 * (size+1 - 4) || checkIfGridIsFull()) {
                            inheritedScore.scoreStructure.setBestScore(newScore);
                            tiles = resetGrid();
                        }
                        }
                        if (newScore == 2048 || checkIfGridIsFull()) {
                          inheritedScore.scoreStructure.setBestScore(newScore);
                          tiles = resetGrid();
                        }
                      });
                    }
                  },
                  child: GridView.count(
                      crossAxisCount: size,
                      children: tiles
                          .expand((value) => value)
                          .map<StatefulColorfulTile>((element) =>
                              StatefulColorfulTile(element, key: UniqueKey()))
                          .toList())))
        ]));
  }

  // TODO : Modifier move et clearSpaces pour éviter de repasser dans la liste sans raison
  move(String direction) {
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles.length; j++) {
        int iOffset = 0;
        int jOffset = 0;

        switch (direction.toUpperCase()) {
          case "UP":
            iOffset = -1;
            break;

          case "DOWN":
            iOffset = 1;
            break;

          case "LEFT":
            jOffset = -1;
            break;

          case "RIGHT":
            jOffset = 1;
            break;
        }

        if (i + iOffset >= 0 &&
            i + iOffset < tiles.length &&
            j + jOffset >= 0 &&
            j + jOffset < tiles.length &&
            (tiles[i][j] == tiles[i + iOffset][j + jOffset] ||
                tiles[i + iOffset][j + jOffset] == 0)) {
          if (tiles[i + iOffset][j + jOffset] == 0) {
            clearSpaces(direction);
            clearSpaces(direction);
          }

          if (tiles[i][j] == tiles[i + iOffset][j + jOffset]) {
            merge(i, j, i + iOffset, j + jOffset);
          }
        }
      }
    }

    clearSpaces(direction);
  }

  clearSpaces(String direction) {
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles.length; j++) {
        int iOffset = 0;
        int jOffset = 0;

        switch (direction.toUpperCase()) {
          case "UP":
            iOffset = -1;
            break;

          case "DOWN":
            iOffset = 1;
            break;

          case "LEFT":
            jOffset = -1;
            break;

          case "RIGHT":
            jOffset = 1;
            break;
        }

        if (i + iOffset >= 0 &&
            i + iOffset < tiles.length &&
            j + jOffset >= 0 &&
            j + jOffset < tiles.length &&
            (tiles[i + iOffset][j + jOffset] == 0)) {
          merge(i, j, i + iOffset, j + jOffset);
        }
      }
    }
  }

  //x1 est la case qui récupére la somme
  merge(int x1, int y1, int x2, int y2) {
    tiles[x2][y2] = tiles[x1][y1] + tiles[x2][y2];
    tiles[x1][y1] = 0;
  }

  checkIfGridIsFull() {
    bool result = true;
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles.length; j++) {
        if (tiles[i][j] == 0) {
          result = false;
          break;
        }
      }
    }

    return result;
  }

  // TODO : Retirer les side effects
  resetGrid() {
    tiles = List.generate(
        size,
        (index) => List.generate(size, (index2) {
              return 0;
            }),
        growable: false);

    spawnRandomTile();
    spawnRandomTile();

    return tiles;
  }

  countCurrentBestScore() {
    int currentBestTile = 0;
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles.length; j++) {
        currentBestTile += tiles[i][j];
      }
    }

    return currentBestTile;
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
