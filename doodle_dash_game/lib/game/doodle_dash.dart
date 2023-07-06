import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'world.dart';

class DoodleDash extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final World _world = World();

  @override
  Future<void> onLoad() async {
    await add(_world);
  }
}
