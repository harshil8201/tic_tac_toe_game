import 'package:flutter/material.dart';

class XGradientMask extends StatelessWidget {
  XGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.cyanAccent, Colors.indigo],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

class OGradientMask extends StatelessWidget {
  OGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.yellow, Colors.amber[900]],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

class TextGradientMask extends StatelessWidget {
  TextGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo,
            Colors.cyanAccent,
          ],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

class TitleGradientMask extends StatelessWidget {
  TitleGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.yellow, Colors.amber[900]],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
