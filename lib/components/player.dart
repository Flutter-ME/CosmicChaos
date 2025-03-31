import 'dart:async';
import 'dart:ui';

import 'package:cosmic_chaos/app_game.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameReference<AppGame> {
  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('player_blue_on0.png');
    size *= 0.3;
    return super.onLoad();
  }

  @override
  void update(double dt){
    super.update(dt);
    position += game.joystick.relativeDelta.normalized() * 200 * dt;
    _handleScreenBounds();
  }

  void _handleScreenBounds() {
    final double screenWidth = game.size.x;
    final double screenHeight = game.size.y;

    // prevent the player from going off the top of the bottom edges
    _restrictPlayerMoveOutOfBounds();

    if (position.x >= screenWidth) {
      position.x = 0;
    } else if (position.x <= 0) {
      position.x = screenWidth;
    }
  }

  void _restrictPlayerMoveOutOfBounds() {
    final double screenHeight = game.size.y;
    position.y = clampDouble(position.y, size.y / 2, screenHeight - size.y / 2);
  }
}