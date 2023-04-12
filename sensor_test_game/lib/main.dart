import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller/ble_controller.dart';
import 'ember_quest.dart';
import 'util/car.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.bluetoothScan.request();
  await Permission.bluetoothConnect.request();

  // runApp(MyApp());

  Get.put(BleController(), permanent: true);
  BleController.to.scanForDevices();

  runApp(
    GameWidget<EmberQuestGame>.controlled(
      gameFactory: EmberQuestGame.new,
      // overlayBuilderMap: {
      //   'HomeScreen': (_, game) => HomeScreen(game: game),
      // },
      // initialActiveOverlays: const ['HomeScreen'],
    ),
  );

  // BleController.to.scanForDevices();
}


class HomeScreen extends StatelessWidget {
  final EmberQuestGame game;

  const HomeScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(
        () {
          Get.put(BleController(), permanent: true);
        },
      ),
      home: Scaffold(
        body: Container(
          color: Colors.red,
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Car(),
            ],
          ),
        ),
      ),
    );
  }
}
