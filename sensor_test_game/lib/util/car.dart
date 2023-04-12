import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ble_controller.dart';

class Car extends StatefulWidget {
  const Car({super.key});

  @override
  State<Car> createState() => _CarState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _CarState extends State<Car> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  );

  late final Animation<double> newAnimation =
      Tween<double>(begin: 0.03, end: -0.03).animate(_animation);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        bottom: BleController.to.babyImageLocationY.value +
            BleController.to.gyroY.value.toDouble(),
        // 레프트로만 하려면 레프트: 넓이의반 - 베이비넓이의반
        right: BleController.to.babyImageLocationX.value +
            BleController.to.gyroX.value.toDouble(),
        child: RotationTransition(
          turns: newAnimation,
          child: GestureDetector(
            onTap: () {
              print('위치 초기화');
              BleController.to.gyroX.value = 0;
              BleController.to.gyroY.value = 0;
            },
            child: Image.asset(
              'assets/images/car.png',
              height: 350,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
