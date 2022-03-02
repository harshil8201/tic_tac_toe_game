// //import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
//
// class Sound extends StatefulWidget {
//   @override
//   _SoundState createState() => _SoundState();
// }
//
// class _SoundState extends State<Sound> {
//   AudioCache _audioCache;
//
//   @override
//   void initState() {
//     super.initState();
//     // create this only once
//     _audioCache = AudioCache(
//       prefix: "assets/sounds/",
//       fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("Music play")),
//         body: RaisedButton(
//           onPressed: () => _audioCache.play('click.mp3'),
//           child: Text("Play Audio"),
//         ),
//       ),
//     );
//   }
// }
