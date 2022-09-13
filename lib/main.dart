import 'package:flutter/material.dart';
import 'dart:math';

import 'tile.dart';

void main() {
  runApp(MaterialApp(home: PositionedTiles()));
}

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    tiles = [
      StatefulColorfulTile(key: UniqueKey()),
      StatefulColorfulTile(key: UniqueKey())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                color: Colors.red,
                height: 450,
                width: 450,
                child: GestureDetector(
                    onHorizontalDragEnd: (dragEndDetails) {
                      if (dragEndDetails.primaryVelocity! < 0) {
                        // Page forwards
                        print('Move right');
                        //_goForward();
                      } else if (dragEndDetails.primaryVelocity! > 0) {
                        // Page backwards
                        print('Move left');
                        //_goBack();
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
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FixedColumnWidth(64),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(
                          children: tiles,
                        ),
                      ],
                    )))));
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
