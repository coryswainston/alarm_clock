import 'package:alarm_clock/constants.dart';
import 'package:alarm_clock/network.dart';
import 'package:alarm_clock/smarthome/lightbulb_state.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lightbulb_notifier.g.dart';

@Riverpod(keepAlive: true)
class LightbulbNotifier extends _$LightbulbNotifier {
  @override
  FutureOr<LightbulbState> build(String ip) async {
    try {
      final response = await dio.get('$apiUrl/bulb/$ip/status');
      if (response.statusCode == 200) {
        return LightbulbState(currentScene: response.data['current_scene']);
      } else {
        throw Exception("Failed to get bulb status");
      }
    } catch (e) {
      print("ERROR: $e");
      throw Exception("Failed to get bulb status");
    }
  }

  Future<void> setBulbState(String scene) async {
    final response = await dio.get('$apiUrl/bulb/$ip/scene/$scene');
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

    final response = await dio.get('$apiUrl/bulb/$ip/scene/$newState');
    if (response.statusCode == 200) {
      state = AsyncData(LightbulbState(currentScene: newState));
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }
}
