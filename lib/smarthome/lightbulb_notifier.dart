import 'package:alarm_clock/smarthome/lightbulb_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lightbulb_notifier.g.dart';

const corysLamp = '192.168.40.182';
const annasLamp = '192.168.40.225';

const bridgeUrl = "http://127.0.0.1:8000";

@Riverpod(keepAlive: true)
class LightbulbNotifier extends _$LightbulbNotifier {
  @override
  FutureOr<LightbulbState> build(String ip) async {
    if (kIsWeb) return LightbulbState(currentScene: 'off');

    final response = await Dio().get('$bridgeUrl/status/$ip');
    if (response.statusCode == 200) {
      return LightbulbState(currentScene: response.data['current_scene']);
    } else {
      throw Exception("Failed to get bulb status");
    }
  }

  Future<void> setBulbState(String scene) async {
    if (kIsWeb) {
      state = AsyncData(LightbulbState(currentScene: scene));
      return;
    }

    final response = await Dio().get('$bridgeUrl/scene/$ip/$scene');
    if (response.statusCode == 200) {
      state = AsyncData(LightbulbState(currentScene: scene));
      return;
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }

  Future<void> toggleBulb() async {
    final lastState = await future;

    var newState = lastState.currentScene;
    switch (newState) {
      case 'bright':
        newState = 'night';
        break;
      case 'night':
        newState = 'off';
        break;
      case 'off':
        newState = 'bright';
        break;
      default:
        newState = 'bright';
    }

    if (kIsWeb) {
      state = AsyncData(LightbulbState(currentScene: newState));
      return;
    }

    final response = await Dio().get('$bridgeUrl/scene/$ip/$newState');
    if (response.statusCode == 200) {
      state = AsyncData(LightbulbState(currentScene: newState));
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }
}
