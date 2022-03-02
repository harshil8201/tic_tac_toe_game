import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/Class/theme.dart';
import 'package:tic_tac_toe_game/Class/title.dart';

class BoardTile extends StatelessWidget {
  final TileState tileState;
  final double dimension;
  final VoidCallback onPressed;

  BoardTile({Key key, this.tileState, this.dimension, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: dimension,
      height: dimension,
      child: FlatButton(
        onPressed: onPressed,
        child: _widgetForTileState(),
      ),
    );
  }

  Widget _widgetForTileState() {
    Widget widget;

    switch (tileState) {
      case TileState.EMPTY:
        {
          widget = Container();
        }
        break;

      case TileState.CROSS:
        {
          widget = XGradientMask(
            child: Image.asset(
              'assets/images/x.png',
              color: Colors.white,
            ),
          );
        }
        break;

      case TileState.CIRCLE:
        {
          widget = OGradientMask(
            child: Image.asset(
              'assets/images/o.png',
              color: Colors.yellowAccent,
            ),
          );
        }
        break;
    }
    return widget;
  }
}
