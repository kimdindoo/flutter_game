import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:sensor_test_game/controller/ble_controller.dart';
import 'package:sensor_test_game/data.dart';
import 'package:sensor_test_game/enemy_manager.dart';
import 'package:sensor_test_game/overlays/hud.dart';

import 'actors/ember.dart';
import 'actors/water_enemy.dart';
import 'objects/star.dart';

class EmberQuestGame extends FlameGame
    with
        HasCollisionDetection,
        HasKeyboardHandlerComponents,
        HasDraggables,
        HasTappables {
  EmberQuestGame();

  late SpriteSheet spriteSheet;

  late EnemyManager _enemyManager;

  late EmberPlayer ember;
  double objectSpeed = 0.0;
  double objectSpeedY = 0.0;

  late WaterEnemy waterEnemy;
  late WaterEnemy waterEnemy2;
  late WaterEnemy waterEnemy3;
  late WaterEnemy waterEnemy4;
  late WaterEnemy waterEnemy5;

  late Star star1;
  late Star star2;
  late Star star3;
  late Star star4;
  late Star star5;

  // HUD
  int starsCollected = 0;
  int health = 8;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(250, 150, 150, 150);
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'car.png',
      'ember.png',
      'water_enemy.png',
      'star.png',
      'simpleSpace_tilesheet@2.png',
      'heart_half.png',
      'heart.png',
    ]);
    initializeGame(true);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void initializeGame(bool loadHud) {

      spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('simpleSpace_tilesheet@2.png'),
        columns: 8,
        rows: 6,
      );


    _enemyManager = EnemyManager(spriteSheet: spriteSheet);
    add(_enemyManager);

    ember = EmberPlayer(
      position: Vector2(200, canvasSize.y - 50),
    );
    add(ember);

    waterEnemy = WaterEnemy(
      position: Vector2(128, 100),
    );

    waterEnemy2 = WaterEnemy(
      position: Vector2(200, 500),
    );

    waterEnemy3 = WaterEnemy(
      position: Vector2(300, 130),
    );

    waterEnemy4 = WaterEnemy(
      position: Vector2(100, 300),
    );

    waterEnemy5 = WaterEnemy(
      position: Vector2(300, 600),
    );

    star1 = Star(
      position: Vector2(100, 100),
    );

    star2 = Star(
      position: Vector2(200, 300),
    );

    star3 = Star(
      position: Vector2(200, 100),
    );

    star4 = Star(
      position: Vector2(100, 400),
    );

    star5 = Star(
      position: Vector2(300, 100),
    );

    add(waterEnemy);
    add(waterEnemy2);
    add(waterEnemy3);
    add(waterEnemy4);
    add(waterEnemy5);
    add(star1);
    add(star2);
    add(star3);
    add(star4);
    add(star5);
    add(Hud());
  }
}
