import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sensor_test_game/actors/enemy.dart';
import 'package:sensor_test_game/controller/ble_controller.dart';

import '../bullet.dart';
import '../data.dart';
import '../ember_quest.dart';
import '../objects/star.dart';
import 'water_enemy.dart';

class EmberPlayer extends SpriteComponent
    with KeyboardHandler, CollisionCallbacks, HasGameRef<EmberQuestGame> {
  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  int horizontalDirection = 0;
  int verticalDirection = 0;

  int horizontalDirectionKeyBoard = 0;

  bool hitByEnemy = false;

  bool _shootMultipleBullets = false;

  int _shootCount = 2;

  @override
  Future<void> onLoad() async {
    final carImage = game.images.fromCache('car.png');
    sprite = Sprite(carImage);
    add(
      CircleHitbox(),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirectionKeyBoard = 0;
    horizontalDirectionKeyBoard +=
        (keysPressed.contains(LogicalKeyboardKey.keyA) ||
                keysPressed.contains(LogicalKeyboardKey.arrowLeft))
            ? -1
            : 0;
    horizontalDirectionKeyBoard +=
        (keysPressed.contains(LogicalKeyboardKey.keyD) ||
                keysPressed.contains(LogicalKeyboardKey.arrowRight))
            ? 1
            : 0;

    return true;
  }

  @override
  void update(double dt) {
    // velocity.x = horizontalDirection * moveSpeed;
    horizontalDirection = 0;
    Gyro.x > 0 ? horizontalDirection = -1 : horizontalDirection = 1;

    verticalDirection = 0;
    Gyro.y > 0 ? verticalDirection = -1 : verticalDirection = 1;

    velocity.x = Gyro.x.abs() * horizontalDirection * 10;
    velocity.y = Gyro.y.abs() * verticalDirection * 10;

    if (position.x - 36 <= 0 && horizontalDirection < 0) {
      velocity.x = 0;
    }

    if (position.x + 36 >= game.size.x && horizontalDirection > 0) {
      velocity.x = 0;
      game.objectSpeed = -moveSpeed;
    }

    if (position.y + 36 >= game.size.y && verticalDirection > 0) {
      velocity.y = 0;
    }

    if (position.y - 36 <= 0 && verticalDirection < 0) {
      velocity.y = 0;
    }
    // 키보드 이동
    // velocity.x = horizontalDirectionKeyBoard * moveSpeed;

    position += velocity * dt;

    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    if (10< Grab.GrabPower && Grab.GrabPower < 30) {
      print('case 1 Grab.GrabPower : ${Grab.GrabPower}}');
      _shootMultipleBullets = false;
      joystickAction();
    } else if (31 < Grab.GrabPower && Grab.GrabPower < 50) {
      print('case 2 Grab.GrabPower 2 : ${Grab.GrabPower}}');
      _shootMultipleBullets = true;
      _shootCount = 2;
      joystickAction();
    } else if (51 < Grab.GrabPower && Grab.GrabPower < 100) {
      print('case 3 Grab.GrabPower 3 : ${Grab.GrabPower}}');
      _shootMultipleBullets = true;
      _shootCount = 10;
      joystickAction();
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is WaterEnemy) {
      hit();
    }

    if (other is Enemy) {
      hit();
    }

    if (other is Star) {
      other.removeFromParent();
      game.starsCollected++;
    }

    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    print('hit');
    if (!hitByEnemy) {
      game.health--;
      hitByEnemy = true;
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 5,
        ),
      )..onComplete = () {
          hitByEnemy = false;
        },
    );
  }

  void joystickAction() {
    Bullet bullet = Bullet(
      sprite: gameRef.spriteSheet.getSpriteById(28),
      size: Vector2(64, 64),
      position: position.clone(),
      // level: _spaceship.level,
    );

    // Anchor it to center and add to game world.
    bullet.anchor = Anchor.center;
    gameRef.add(bullet);

    // Ask audio player to play bullet fire effect.
    // gameRef.addCommand(Command<AudioPlayerComponent>(action: (audioPlayer) {
    //   audioPlayer.playSfx('laserSmall_001.ogg');
    // }));

    // If multiple bullet is on, add two more
    // bullets rotated +-PI/6 radians to first bullet.
    if (_shootMultipleBullets) {
      for (int i = -1; i < _shootCount; i += 2) {
        Bullet bullet = Bullet(
          sprite: gameRef.spriteSheet.getSpriteById(28),
          size: Vector2(64, 64),
          position: position.clone(),
          // level: _spaceship.level,
        );

        // Anchor it to center and add to game world.
        bullet.anchor = Anchor.center;
        bullet.direction.rotate(i * pi / 6);
        gameRef.add(bullet);
      }
    }
  }
}
