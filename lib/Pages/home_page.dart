// ignore_for_file: must_call_super

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe_game/Ad%20Hepler/ad_helper.dart';
import 'package:tic_tac_toe_game/Pages/play_page.dart';
import 'package:tic_tac_toe_game/Class/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String player1XX = "PLAYER 1 ";
  String player2XX = "PLAYER 2 ";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/bgpic.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.white.withOpacity(0.09)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: TitleGradientMask(
                  child: Text(
                    'Tic Tac Toe',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w900,
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontFamily: 'AhayHore',
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.04375,
                                  width: MediaQuery.of(context).size.height * 0.04375,
                                  child: XGradientMask(
                                    child: Image.asset(
                                      'assets/images/x.png',
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  'PLAYER 1 :',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.height * 0.05,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'MomCake',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.03125,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Motend',
                                color: Colors.lightBlueAccent,
                              ),
                              decoration: InputDecoration(
                                border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white70),
                                ),
                                hintText: 'Player 1',
                                hintStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Motend',
                                  color: Colors.grey[600],
                                ),
                                fillColor: Colors.black54,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onChanged: (value) => {
                                player1XX = value,
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04375,
                              width: MediaQuery.of(context).size.height * 0.04375,
                              child: OGradientMask(
                                child: Image.asset(
                                  'assets/images/o.png',
                                  fit: BoxFit.fill,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              'PLAYER 2 :',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height * 0.05,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MomCake',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03125,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Motend',
                            color: Colors.orange,
                          ),
                          decoration: InputDecoration(
                            border: new UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white70),
                            ),
                            hintText: 'Player 2',
                            hintStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Motend',
                              color: Colors.grey[600],
                            ),
                            fillColor: Colors.black54,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey[600],
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onChanged: (value) => {
                            player2XX = value,
                          },
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 80.0,
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  // if (_isRewardedAdReady) {
                  //   _rewardedAd.show();
                  // }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlayPage(player1: player1XX, player2: player2XX),
                    ),
                  );
                  print(player1XX);
                  print(player2XX);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.0625,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: TextGradientMask(
                        child: Text(
                          'PLAY GAME',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02875,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Motend',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
    );
  }
}
