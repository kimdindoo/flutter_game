import 'package:flame/components.dart';

import '../doodle_dash.dart';

class Player extends SpriteComponent with HasGameRef<DoodleDash> {
  Player({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('game/character.png');
  }
}

@override
Future<void> onLoad() async {
  await super.onLoad();

  await _loadCharacterSprites(); // Add this line
  current = PlayerState.center; // Add this line
}

Future<void> _loadCharacterSprites() async {
  final left = await gameRef.loadSprite('game/${character.name}_left.png');
  final right = await gameRef.loadSprite('game/${character.name}_right.png');
  final center = await gameRef.loadSprite('game/${character.name}_center.png');
  final rocket = await gameRef.loadSprite('game/rocket_4.png');
  final nooglerCenter =
      await gameRef.loadSprite('game/${character.name}_hat_center.png');
  final nooglerLeft =
      await gameRef.loadSprite('game/${character.name}_hat_left.png');
  final nooglerRight =
      await gameRef.loadSprite('game/${character.name}_hat_right.png');

  sprites = <PlayerState, Sprite>{
    PlayerState.left: left,
    PlayerState.right: right,
    PlayerState.center: center,
    PlayerState.rocket: rocket,
    PlayerState.nooglerCenter: nooglerCenter,
    PlayerState.nooglerLeft: nooglerLeft,
    PlayerState.nooglerRight: nooglerRight,
  };
}
