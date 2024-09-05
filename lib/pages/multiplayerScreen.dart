import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Models/players.dart';

class MultiPlayerScreen extends StatefulWidget {
  const MultiPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MultiPlayerScreen> createState() => _MultiPlayerScreenState();
}

class _MultiPlayerScreenState extends State<MultiPlayerScreen> {
  static const indexCount = 9;
  String lastMove = Players.none;
  late List<String> matrix;

  @override
  void initState() {
    super.initState();

    restart();
  }

  void restart() {
    setState(() {
      matrix = List.generate(indexCount, (_) => Players.none);
    });
  }

  Color getBackgroundColor() {
    final thisMove = lastMove == Players.X ? Players.O : Players.X;
    return getFieldColor(thisMove).withAlpha(150);
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
    if (value == Players.none) {
      final newValue = lastMove == Players.X ? Players.O : Players.X;
      setState(() {
        lastMove = newValue;
        matrix[index] = newValue;
      });
      if (isWinner()) {
        showEndDialog('Player $newValue Won !');
      } else if (isEnd()) {
        showEndDialog('No Winner :(');
      }
    }
  }

  bool isEnd() => matrix.every((values) => values != Players.none);

  bool isWinner() {
    // 0=x 1=o  else=no winner

    if (((matrix[0] == lastMove) &&
            (matrix[1] == lastMove) &&
            (matrix[2] == lastMove)) ||
        ((matrix[3] == lastMove) &&
            (matrix[4] == lastMove) &&
            (matrix[5] == lastMove)) ||
        ((matrix[6] == lastMove) &&
            (matrix[7] == lastMove) &&
            (matrix[8] == lastMove)) ||
        ((matrix[0] == lastMove) &&
            (matrix[3] == lastMove) &&
            (matrix[6] == lastMove)) ||
        ((matrix[1] == lastMove) &&
            (matrix[4] == lastMove) &&
            (matrix[7] == lastMove)) ||
        ((matrix[2] == lastMove) &&
            (matrix[5] == lastMove) &&
            (matrix[8] == lastMove)) ||
        ((matrix[0] == lastMove) &&
            (matrix[4] == lastMove) &&
            (matrix[8] == lastMove)) ||
        ((matrix[2] == lastMove) &&
            (matrix[4] == lastMove) &&
            (matrix[6] == lastMove))) {
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
            selectField(value, index);
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
          "Multiplayer Player",
          style: TextStyle(fontSize: 35),
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
