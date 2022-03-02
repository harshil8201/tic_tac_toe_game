import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe_game/Ad%20Hepler/ad_helper.dart';
import 'package:tic_tac_toe_game/Class/theme.dart';
import 'package:tic_tac_toe_game/Pages/home_page.dart';

class PlayPage extends StatefulWidget {
  final String player1, player2;

  PlayPage({Key key, this.player1, this.player2}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool oTurn = true;

  // 1st player is O
  List displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  // var _boardState = List.filled(9, TileState.EMPTY);
  // int ohScore = 0;
  // int exScore = 0;

  // var _currentTurn = TileState.CROSS;

  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: AdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _rewardedAd = RewardedAd(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (_) {
          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a rewarded ad: ${err.message}');
          _isRewardedAdReady = false;
          ad.dispose();
        },
        onAdClosed: (_) {
          setState(() {
            _isRewardedAdReady = false;
          });
          _rewardedAd.load();
        },
        // onRewardedAdUserEarnedReward: (_, reward) {
        //   QuizManager.instance.useHint();
        // },
      ),
    );
    _rewardedAd.load();
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  // void remove() {
  //   setState(() {
  //     ohScore = 0;
  //     exScore = 0;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //navigatorKey: navigatorKey,
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.0625,
                          width: MediaQuery.of(context).size.height * 0.0625,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade600,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 12,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (_isRewardedAdReady) {
                                _rewardedAd.show();
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.home,
                              color: Colors.white,
                              size:
                                  MediaQuery.of(context).size.height * 0.04375,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade600,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 12,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.04375,
                                  width: MediaQuery.of(context).size.height *
                                      0.04375,
                                  child: XGradientMask(
                                    child: Image.asset(
                                      'assets/images/x.png',
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                XGradientMask(
                                  child: Text(
                                    '${widget.player1}='.toUpperCase(),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.05625,
                                      color: Colors.white,
                                      fontFamily: 'MomCake',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.08333,
                                  child: Text(
                                    xScore.toString(),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.05625,
                                      color: Colors.white,
                                      fontFamily: 'MomCake',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flexible(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _tapped(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                child: Text(
                                  displayElement[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 80, top: 50),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffF4B029).withOpacity(0.9),
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 12,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.04375,
                                  width: MediaQuery.of(context).size.height *
                                      0.04375,
                                  child: OGradientMask(
                                    child: Image.asset(
                                      'assets/images/o.png',
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                OGradientMask(
                                  child: Text(
                                    '${widget.player2}='.toUpperCase(),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.05625,
                                      color: Colors.white,
                                      fontFamily: 'MomCake',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.08333,
                                  child: Text(
                                    oScore.toString(),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.05625,
                                      color: Colors.white,
                                      fontFamily: 'MomCake',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.0625,
                          width: MediaQuery.of(context).size.height * 0.0625,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffF4B029).withOpacity(0.9),
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 12,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (_isRewardedAdReady) {
                                _rewardedAd.show();
                              }
                              _clearScoreBoard();
                            },
                            child: Icon(
                              Icons.restart_alt_outlined,
                              color: Colors.white,
                              size:
                                  MediaQuery.of(context).size.height * 0.04375,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + winner + " \" is Winner!!!"),
            actions: [
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }
}

// Widget _boardTiles() {
//   return Builder(
//     builder: (context) {
//       final boardDimension = MediaQuery.of(context).size.width;
//       final tileDimension = boardDimension / 3;
//
//       return Container(
//         width: boardDimension,
//         height: boardDimension,
//         child: Column(
//           children: chunk(_boardState, 3).asMap().entries.map((entry) {
//             final chunkIndex = entry.key;
//             final tileStateChunk = entry.value;
//
//             return Row(
//               children: tileStateChunk.asMap().entries.map((innerEntry) {
//                 final innerIndex = innerEntry.key;
//                 final tileState = innerEntry.value;
//                 final tileIndex = (chunkIndex * 3) + innerIndex;
//
//                 return BoardTile(
//                   tileState: tileState,
//                   dimension: tileDimension,
//                   onPressed: () => _updateTileStateForIndex(tileIndex),
//                   key: null,
//                 );
//               }).toList(),
//             );
//           }).toList(),
//         ),
//       );
//     },
//   );
// }
//
// void _updateTileStateForIndex(int selectedIndex) {
//   if (_boardState[selectedIndex] == TileState.EMPTY) {
//     setState(
//       () {
//         _boardState[selectedIndex] = _currentTurn;
//         _currentTurn = _currentTurn == TileState.CROSS
//             ? TileState.CIRCLE
//             : TileState.CROSS;
//         // if (_currentTurn == TileState.CROSS) {
//         //   _audioCache.play('oclick.mp3');
//         // } else if (_currentTurn == TileState.CIRCLE) {
//         //   _audioCache.play('xclick.mp3');
//         // }
//       },
//     );
//
//     final winner = _findWinner();
//     if (winner != null) {
//       print('WINNER IS: $winner');
//       _showWinnerDialog(winner);
//     }
//   } else {
//     _showDrawDialog();
//   }
// }
//
// void _showDrawDialog() {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(20.0),
//           ),
//         ),
//         title: Text(
//           'DRAW',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             letterSpacing: 2,
//             fontSize: MediaQuery.of(context).size.height * 0.05,
//             color: Colors.black,
//             fontFamily: 'MomCake',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text(
//               'CONTINUE',
//               style: TextStyle(
//                 fontSize: MediaQuery.of(context).size.height * 0.025,
//                 color: Colors.black,
//                 fontFamily: 'MomCake',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onPressed: () {
//               _playAgain();
//               Navigator.pop(context);
//             },
//           )
//         ],
//       );
//     },
//   );
// }
//
// TileState _findWinner() {
//   TileState Function(int, int, int) winnerForMatch = (a, b, c) {
//     if (_boardState[a] != TileState.EMPTY) {
//       if ((_boardState[a] == _boardState[b]) &&
//           (_boardState[b] == _boardState[c])) {
//         return _boardState[a];
//       }
//     }
//     return null;
//   };
//
//   final checks = [
//     winnerForMatch(0, 1, 2),
//     winnerForMatch(3, 4, 5),
//     winnerForMatch(6, 7, 8),
//     winnerForMatch(0, 3, 6),
//     winnerForMatch(1, 4, 7),
//     winnerForMatch(2, 5, 8),
//     winnerForMatch(0, 4, 8),
//     winnerForMatch(2, 4, 6),
//   ];
//
//   TileState winner;
//   for (int i = 0; i < checks.length; i++) {
//     if (checks[i] != null) {
//       winner = checks[i];
//       break;
//     }
//   }
//   return winner;
// }
//
// void _showWinnerDialog(TileState tileState) {
//   //final context = navigatorKey.currentState.overlay.context;
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(20.0),
//           ),
//         ),
//         title: Text(
//           'WINNER',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             letterSpacing: 2,
//             fontSize: MediaQuery.of(context).size.height * 0.05,
//             color: Colors.black,
//             fontFamily: 'MomCake',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: tileState == TileState.CROSS
//             ? XGradientMask(
//                 child: Image.asset(
//                   'assets/images/x.png',
//                   color: Colors.white,
//                 ),
//               )
//             : OGradientMask(
//                 child: Image.asset(
//                   'assets/images/o.png',
//                   color: Colors.white,
//                 ),
//               ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _resetGame();
//               Navigator.of(context).pop();
//             },
//             child: tileState == TileState.CROSS
//                 ? XGradientMask(
//                     child: Text(
//                       'CONTINUE',
//                       style: TextStyle(
//                         fontSize: MediaQuery.of(context).size.height * 0.025,
//                         color: Colors.white,
//                         fontFamily: 'MomCake',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 : OGradientMask(
//                     child: Text(
//                       'CONTINUE',
//                       style: TextStyle(
//                         fontSize: MediaQuery.of(context).size.height * 0.025,
//                         color: Colors.white,
//                         fontFamily: 'MomCake',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       );
//     },
//   );
//   if (tileState == TileState.CROSS) {
//     exScore += 1;
//   } else if (tileState == TileState.CIRCLE) {
//     ohScore += 1;
//   }
// }
//
// void _resetGame() {
//   setState(
//     () {
//       _boardState = List.filled(9, TileState.EMPTY);
//       _currentTurn = TileState.CROSS;
//     },
//   );
// }
//
// void _playAgain() {
//   setState(() {
//     _boardState = List.filled(9, TileState.EMPTY);
//     if (_currentTurn == TileState.CIRCLE) {
//       _currentTurn = TileState.CROSS;
//     } else {
//       _currentTurn = TileState.CIRCLE;
//     }
//   });
// }
