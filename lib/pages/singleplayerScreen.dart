import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Models/players.dart';

class SinglePlayerScreen extends StatefulWidget {
  const SinglePlayerScreen({Key? key}) : super(key: key);

  @override
  State<SinglePlayerScreen> createState() => _SinglePlayerScreenState();
}

class Move {
  late var index = 0;
  late var score;
  Move(this.index, this.score);
}

class _SinglePlayerScreenState extends State<SinglePlayerScreen> {
  static const indexCount = 9;
  late List<String> matrix;
  late String com;
  late String player;
  late String turn;
  late int idx;

  @override
  void initState() {
    super.initState();
    restart();
  }

  void playersSet() {
    Random random = Random();
    int comSet = random.nextInt(2);
    com = (comSet == 1 ? Players.X : Players.O);
    player = com == Players.X ? Players.O : Players.X;
    turn = random.nextInt(2) == 1 ? Players.X : Players.O;
  }

  Move getBestMove(String t, int idx) {
    if (isWinner(com)) {
      return Move(0, 1000 / idx);
    } else if (isWinner(player)) {
      return Move(0, -1000 / idx);
    } else if (isEnd()) {
      return Move(0, 0);
    }
    List<Move> moves = [];
    Random r = Random();
    int i = r.nextInt(9);

    for (int j = 0; j < 9; j++, i = (i + 1) % 9) {
      if (matrix[i] == Players.none) {
        Move move = Move(i, 0);
        matrix[i] = t;
        move.score =
            getBestMove((t == Players.X ? Players.O : Players.X), idx + 1)
                .score;
        moves.add(move);
        matrix[i] = Players.none;
      }
    }

    Move best = moves[0];
    for (int i = 1; i < moves.length; i++) {
      if (t == com) {
        if (moves[i].score > best.score) {
          best = moves[i];
        }
      } else {
        if (moves[i].score < best.score) {
          best = moves[i];
        }
      }
    }
    return best;
  }

  void restart() {
    setState(() {
      matrix = List.generate(indexCount, (_) => Players.none);
    });
    playersSet();
    if (turn == com) {
      Random r = Random();
      int i = r.nextInt(9);
      matrix[i] = com;
      turn = player;
      setState(() {});
    }
  }

  Color getBackgroundColor() {
    return getFieldColor(player).withAlpha(150);
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Players.O:
        return Colors.cyan;
      case Players.X:
        return const Color.fromARGB(255, 236, 28, 13);
      default:
        return Colors.white;
    }
  }

  void selectField(String value, int index) {
    bool flag = false;
    if (value == Players.none) {
      if (turn != com) {
        setState(() {
          matrix[index] = player;
        });
        if (isWinner(turn)) {
          flag = true;
          showEndDialog('Player $turn Won :)');
        } else if (isEnd()) {
          flag = true;
          showEndDialog('No Winner :(');
        }
        turn = com;
        // prnt();
      }
      if (turn == com && flag == false) {
        Move move = Move(0, 0);
        idx = 0;
        move = getBestMove(com, 0);
        setState(() {
          matrix[move.index] = com;
        });
        if (isWinner(turn)) {
          showEndDialog('Player $turn Won :)');
        } else if (isEnd()) {
          showEndDialog('No Winner :(');
        }
        //prnt();
        // print(move.index);
        turn = player;
      }
    }
  }

  bool isEnd() => matrix.every((values) => values != Players.none);

  bool isWinner(String turn) {
    if (((matrix[0] == turn) && (matrix[1] == turn) && (matrix[2] == turn)) ||
        ((matrix[3] == turn) && (matrix[4] == turn) && (matrix[5] == turn)) ||
        ((matrix[6] == turn) && (matrix[7] == turn) && (matrix[8] == turn)) ||
        ((matrix[0] == turn) && (matrix[3] == turn) && (matrix[6] == turn)) ||
        ((matrix[1] == turn) && (matrix[4] == turn) && (matrix[7] == turn)) ||
        ((matrix[2] == turn) && (matrix[5] == turn) && (matrix[8] == turn)) ||
        ((matrix[0] == turn) && (matrix[4] == turn) && (matrix[8] == turn)) ||
        ((matrix[2] == turn) && (matrix[4] == turn) && (matrix[6] == turn))) {
      return true;
    } else {
      return false;
    }
  }

  Future showEndDialog(String title) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          title: Center(
              child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          )),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  restart();
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.restart_alt,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      );

  Widget buildField(int index) {
    final value = matrix[index];
    final color = getFieldColor(value);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: () {
            setState(() {
              selectField(value, index);
            });
          },
          child: Text(
            value,
            style: const TextStyle(fontSize: 50),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: const Text(
          "Single Player",
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return buildField(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
