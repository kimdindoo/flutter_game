import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../ember_quest.dart';

class Star extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final Vector2 velocity = Vector2.zero();

  Star({
    required super.position,
  }) : super(size: Vector2.all(32), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final starImage = game.images.fromCache('star.png');
    sprite = Sprite(starImage);

    add(RectangleHitbox()..collisionType = CollisionType.passive);
    add(
      SizeEffect.by(
        Vector2(-24, -24),
        EffectController(
          duration: .75,
          reverseDuration: .5,
          infinite: true,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    // velocity.x = game.objectSpeed;
    // velocity.y = game.objectSpeedY;
    //
    // position += velocity * dt;
    // if (position.x < -size.x) removeFromParent();
    //
    // if (position.x < -size.x || game.health <= 0) removeFromParent();

    super.update(dt);
  }
}
