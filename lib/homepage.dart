import 'dart:async';

import 'package:brick_breaker/coverscreen.dart';
import 'package:brick_breaker/gameoverscreen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ball.dart';
import 'brick.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

enum Direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
  // ball variables
  double ballX = 0;
  double ballY = 0;
  var ballDirection = Direction.DOWN;

  // player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // brick variables
  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4; // out of 2
  double brickHeight = 0.05;
  bool brickBroken = false;

  // game settings
  bool gameHasStarted = false;
  bool isGameOver = false;

  void startGame() {
    if (!gameHasStarted) {
      gameHasStarted = true;
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        updateDirection();
        moveBall();
        // check if player died
        if (isPlayerDead()) {
          timer.cancel();
          isGameOver = true;
        }

        // check if brick is smashed
        checkForBrokenBricks();
      });
    }
  }

  void checkForBrokenBricks() {
    if (ballX >= brickX &&
        ballX <= brickX + brickWidth &&
        ballY >= brickY + brickHeight &&
        brickBroken == false) {
      setState(() {
        brickBroken = true;
      });
    }
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballDirection = Direction.UP;
      } else if (ballY <= -0.9) {
        ballDirection = Direction.DOWN;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballDirection == Direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == Direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return KeyboardListener(
    //   focusNode: FocusNode(),
    //   autofocus: true,
    //   onKeyEvent: (event) {
    //     if (event is KeyDownEvent) {
    //       if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
    //         moveLeft();
    //       } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
    //         moveRight();
    //       }
    //     }
    //   },
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                // tap to play
                CoverScreen(gameHasStarted: gameHasStarted),
                // game over screen
                GameOverScreen(isGameOver: isGameOver),
                // ball
                Ball(ballX: ballX, ballY: ballY),
                // player
                Player(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),
                // bricks
                Brick(
                  brickX: brickX,
                  brickY: brickY,
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickBroken: brickBroken,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
