import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gdsc_app/blank_pixel.dart';
import 'package:gdsc_app/food_pixel.dart';
import 'package:gdsc_app/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

enum SnakeDirection { UP, DOWN, LEFT, RIGHT }

class HomePageState extends State<HomePage> {
  // grid dimensions
  int rowSize = 14;
  int totalNumberOfSquare = 196;

  bool gameHasStarted = false;

  //user score
  int currentScore = 0;

  // snake position
  List<Widget> snakePixelList = [const SnakePixel(), const SnakePixel2()];
  List<int> snakePos = [0, 1, 2];

  //food position
  int foodPos = 55;

  //snake direction is to the right
  var currentDirection = SnakeDirection.RIGHT;
  bool gamePaused = false;
  Timer? timerr;
  //start the game
  void startGame() {
    gameHasStarted = true;
    setState(() {
      gamePaused = false;
    });
    timerr = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        // keep the snake moving
        moveSnake();

        //if snake eat food
        eatFood();

        //check game over
        if (gameOver()) {
          timer.cancel();

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Game Over'),
                content: Column(
                  children: [
                    Text('Your score is: $currentScore'),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Enter Name'),
                    )
                  ],
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      submitScore();
                      newGame();
                    },
                    color: Colors.pink,
                    child: const Text('Submit'),
                  )
                ],
              );
            },
          );
        }
      });
    });
  }

  void submitScore() {
    //
  }
  void newGame() {
    setState(() {
      snakePos = [0, 1, 2];
      foodPos = 55;
      currentDirection = SnakeDirection.RIGHT;
      gameHasStarted = false;
      currentScore = 0;
    });
  }

  void eatFood() {
    while (snakePos.contains(foodPos)) {
      currentScore++;
      foodPos = Random().nextInt(totalNumberOfSquare);
      print("snakepos => $snakePos");
    }
  }

  bool gameOver() {
    List<int> bodySnake = snakePos.sublist(0, snakePos.length - 1);

    if (bodySnake.contains(snakePos.last)) {
      return true;
    }
    return false;
  }

  void moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.RIGHT:
        {
          // if snake is at the right wall, re adjust
          if (snakePos.last % rowSize == (rowSize - 1)) {
            snakePos.add(snakePos.last + 1 - rowSize);
          } else {
            snakePos.add(snakePos.last + 1);
          }
        }

        break;
      case SnakeDirection.LEFT:
        {
          // if snake is at the left wall, re adjust
          if (snakePos.last % rowSize == 0) {
            snakePos.add(snakePos.last - 1 + rowSize);
          } else {
            snakePos.add(snakePos.last - 1);
          }
        }

        break;
      case SnakeDirection.UP:
        {
          //add a head
          if (snakePos.last < rowSize) {
            snakePos.add(snakePos.last - rowSize + totalNumberOfSquare);
          } else {
            snakePos.add(snakePos.last - rowSize);
          }
        }
        break;
      case SnakeDirection.DOWN:
        {
          //add a head
          if (snakePos.last + rowSize > totalNumberOfSquare) {
            snakePos.add(snakePos.last + rowSize - totalNumberOfSquare);
          } else {
            snakePos.add(snakePos.last + rowSize);
          }
        }
        break;
      default:
    }
    // snake is eating food
    if (snakePos.last == foodPos) {
      eatFood();
    } else {
      //remove the tail
      snakePos.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          //high score
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //user current score
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Current Score'),
                    Text(
                      currentScore.toString(),
                      style: const TextStyle(fontSize: 36),
                    ),
                  ],
                ),

                //highscores, top 5 or 10
                const Text('highscores..')
              ],
            ),
          ),

          //game grid
          Expanded(
              flex: 3,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0 &&
                      currentDirection != SnakeDirection.UP) {
                    currentDirection = SnakeDirection.DOWN;
                  } else if (details.delta.dy < 0 &&
                      currentDirection != SnakeDirection.DOWN) {
                    currentDirection = SnakeDirection.UP;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 &&
                      currentDirection != SnakeDirection.LEFT) {
                    currentDirection = SnakeDirection.RIGHT;
                  } else if (details.delta.dx < 0 &&
                      currentDirection != SnakeDirection.RIGHT) {
                    currentDirection = SnakeDirection.LEFT;
                  }
                },
                child: GridView.builder(
                    itemCount: totalNumberOfSquare,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: rowSize),
                    itemBuilder: (context, index) {
                      if (snakePos.contains(index)) {
                        return getRandomElement(snakePixelList);
                      } else if (foodPos == index) {
                        return const FoodPixel();
                      } else {
                        return const BlankPixel();
                      }
                    }),
              )),

          //play button
          Expanded(
            child: Center(
              child: MaterialButton(
                color: gameHasStarted ? Colors.grey : Colors.pink,
                onPressed: () {
                  // startGame;
                  if (gamePaused == false) {
                    gameHasStarted ? pauseGame() : startGame();
                    return;
                  }
                  if (gamePaused) {
                    startGame();
                  }
                },
                child: Text(updateBtnTxt()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String updateBtnTxt() {
    if (gameHasStarted) {
      if (gamePaused) {
        return "RESUME";
      }
      return "PAUSE";
    }
    return "PLAY";
  }

  void pauseGame() {
    print("paused");
    timerr!.cancel();
    setState(() {
      gamePaused = true;
    });
  }

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}
