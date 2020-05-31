import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'IntroPage.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audio_cache.dart';

class GamePage extends StatefulWidget {
  final int gridNumber;

  GamePage({Key key, @required this.gridNumber}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

void playSound(int file) {
  final player = AudioCache();
  player.play('note$file.wav');
}

//List<String> movesNumber = new List<String>();
//List<String> timeTaken = new List<String>();
//
//SharedPreferences preferencesMoves;
//SharedPreferences preferencesTime;

int moves = 0;

//Future<List<String>> loadMovesList() async {
//  preferencesMoves = await SharedPreferences.getInstance();
//  if (preferencesMoves == null) {
//    return null;
//  } else {
//    return preferencesMoves.getStringList('movesNumber');
//  }
//}
//
//Future<List<String>> loadTimeList() async {
//  preferencesTime = await SharedPreferences.getInstance();
//  if (preferencesTime == null) {
//    return null;
//  } else {
//    return preferencesTime.getStringList('timeTaken');
//  }
//}

class _GamePageState extends State<GamePage> {
  int finalTime;

//  Future<bool> saveMovesList() async {
//    preferencesMoves = await SharedPreferences.getInstance();
//    return await preferencesMoves.setStringList('movesNumber', movesNumber);
//  }
//
//  setMovesList() {
//    loadMovesList().then(
//      (value) {
//        setState(
//          () {
//            movesNumber = value;
//          },
//        );
//      },
//    );
//  }
//
//  Future<bool> saveTimeList() async {
//    preferencesTime = await SharedPreferences.getInstance();
//    return await preferencesTime.setStringList('timeTaken', timeTaken);
//  }
//
//  setTimeList() {
//    loadTimeList().then(
//      (value) {
//        setState(
//          () {
//            timeTaken = value;
//          },
//        );
//      },
//    );
//  }

  List<GlobalKey<FlipCardState>> cardStateKeys = [];

  List<int> done = [];
  int i = 0;

  List<bool> isFlippable = [];

  List<String> value = [];

  int prevIndex = -1;

  int time = 0;
  Timer timer;
  startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        setState(
          () {
            time = time + 1;
          },
        );
      },
    );
  }

  void reset() {
    setState(
      () {
        moves = 0;
        done.clear();
        i = 0;
        isFlippable.clear();
        value.clear();
        prevIndex = -1;
        time = 0;
        cardStateKeys.clear();
      },
    );
  }

  @override
  void initState() {
    super.initState();
//    loadNameList().then(
//      (value) {
//        setState(
//          () {
//            names = value;
//          },
//        );
//        names = (preferencesNames.getStringList('names') != null)
//            ? preferencesNames.getStringList('names')
//            : null;
//      },
//    );
//    loadMovesList().then(
//      (value) {
//        setState(
//          () {
//            movesNumber = value;
//          },
//        );
//        movesNumber = (preferencesMoves.getStringList('movesNumber') != null)
//            ? preferencesMoves.getStringList('movesNumber')
//            : null;
//      },
//    );
//    loadTimeList().then(
//      (value) {
//        setState(
//          () {
//            timeTaken = value;
//          },
//        );
//        timeTaken = (preferencesTime.getStringList('timeTaken') != null)
//            ? preferencesTime.getStringList('timeTaken')
//            : null;
//      },
//    );
    reset();
    for (int a = 1; a <= widget.gridNumber * widget.gridNumber; a++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      isFlippable.add(true);
    }
    for (int e = 1; e <= widget.gridNumber * widget.gridNumber / 2; e++) {
      value.add('$e');
      value.add('$e');
    }
    startTimer();
    value.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('MATCH-THE-TILES'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '$time',
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: widget.gridNumber * widget.gridNumber,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridNumber,
                ),
                itemBuilder: (context, index) => FlipCard(
                  key: cardStateKeys[index],
                  onFlip: () {
                    playSound(1);
                    moves++;
                    if (checkFirstTime()) {
                      prevIndex = index;
                    } else {
                      //check whether match
                      if (index != prevIndex) {
                        if (value[index] == value[prevIndex]) {
                          playSound(3);
                          setState(
                            () {
                              isFlippable[index] = false;
                              isFlippable[prevIndex] = false;
                              done.add(index);
                              done.add(prevIndex);
                              prevIndex = -1;
                            },
                          );
                          if (isFlippable.every((t) => t == false)) {
                            finalTime = time;
//                            setState(
//                              () {
//                                timeTaken.add(finalTime.toString());
//                                loadTimeList();
//                                setTimeList();
//                                movesNumber.add(moves.toString());
//                                loadMovesList();
//                                setMovesList();
//                              },
//                            );
                            timer.cancel();
//                            one.clear();
                            two.clear();
//                            name = null;
                            n = null;
                            Future.delayed(
                              const Duration(milliseconds: 2000),
                              () {
                                Alert(
                                  context: context,
                                  title: 'Congratulations!',
                                  desc:
                                      'You\'ve completed the game in $moves moves an in $finalTime seconds!!',
                                ).show();
                              },
                            );
                          }
                        } else {
                          if (done.length == 0) {
                            for (int j = 0;
                                j < widget.gridNumber * widget.gridNumber;
                                j++) {
                              setState(
                                () {
                                  isFlippable[j] = false;
                                },
                              );
                            }
                          } else {
                            while (!(done.contains(i))) {
                              setState(
                                () {
                                  isFlippable[i] = false;
                                },
                              );
                              i++;
                            }
                            i = 0;
                          }
                          Future.delayed(
                            const Duration(milliseconds: 1000),
                            () {
                              playSound(2);
                              cardStateKeys[prevIndex]
                                  .currentState
                                  .toggleCard();
                              cardStateKeys[index].currentState.toggleCard();

                              setState(
                                () {
                                  prevIndex = -1;
                                },
                              );
                              if (done.length == 0) {
                                for (int j = 0;
                                    j < widget.gridNumber * widget.gridNumber;
                                    j++) {
                                  setState(
                                    () {
                                      isFlippable[j] = true;
                                    },
                                  );
                                }
                              } else {
                                while (!(done.contains(i))) {
                                  setState(
                                    () {
                                      isFlippable[i] = true;
                                    },
                                  );
                                  i++;
                                }
                                i = 0;
                              }
                            },
                          );
                        }
                      } else {
                        setState(
                          () {
                            prevIndex = -1;
                          },
                        );
                      }
                    }
                  },
                  direction: FlipDirection.VERTICAL,
                  flipOnTouch: isFlippable[index],
                  front: Container(
                    margin: EdgeInsets.all(4),
                    color: Colors.red,
                  ),
                  back: Container(
                    margin: EdgeInsets.all(4),
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        '${value[index]}',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkFirstTime() {
    if (prevIndex == -1) {
      return true;
    } else {
      return false;
    }
  }
}
