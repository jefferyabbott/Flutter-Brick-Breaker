import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool gameHasStarted;

  CoverScreen({required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.2),
            child: Text(
              'tap to play',
              style: TextStyle(
                color: Colors.deepPurple[400],
              ),
            ),
          );
  }
}
