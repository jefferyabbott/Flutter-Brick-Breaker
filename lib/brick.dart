import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;

  const Brick(
      {required this.brickX,
      required this.brickY,
      required this.brickHeight,
      required this.brickWidth,
      required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
            alignment: Alignment(brickX, brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: Colors.deepPurple,
              ),
            ),
          );
  }
}
