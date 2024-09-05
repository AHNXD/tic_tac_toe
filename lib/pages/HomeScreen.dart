import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/multiplayerScreen.dart';
import 'package:tic_tac_toe/pages/singleplayerScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Tic Tac Toe",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Stack(children: <Widget>[
            const Positioned.fill(
              //
              child: Image(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            elevation: 20,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SinglePlayerScreen()));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "🤖 ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              "V",
                              style: TextStyle(color: Colors.red, fontSize: 30),
                            ),
                            Text(
                              "S",
                              style:
                                  TextStyle(color: Colors.cyan, fontSize: 30),
                            ),
                            Text(
                              " 🦸‍♂️",
                              style: TextStyle(color: Colors.red, fontSize: 30),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            elevation: 20,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MultiPlayerScreen()));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "🦸 ",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              "V",
                              style: TextStyle(color: Colors.red, fontSize: 30),
                            ),
                            Text(
                              "S",
                              style:
                                  TextStyle(color: Colors.cyan, fontSize: 30),
                            ),
                            Text(
                              " 🦸‍♂️",
                              style: TextStyle(color: Colors.red, fontSize: 30),
                            )
                          ],
                        )),
                  ),
                  Image.asset(
                    'assets/images/icon.png',
                    height: 80,
                    width: 80,
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
