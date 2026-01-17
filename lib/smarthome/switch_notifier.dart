import 'package:alarm_clock/smarthome/switch_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch_notifier.g.dart';

const ceilingFan = '192.168.40.241';

const bridgeUrl = "http://127.0.0.1:8000";

@Riverpod(keepAlive: true)
class SwitchNotifier extends _$SwitchNotifier {
  @override
  FutureOr<SwitchState> build(String ip) async {
    if (kIsWeb) return SwitchState(isOn: false);

    final response = await Dio().get('$bridgeUrl/switch/$ip/status');
    if (response.statusCode == 200) {
      return SwitchState(isOn: response.data['is_on']);
    } else {
      throw Exception("Failed to get bulb status");
    }
  }

  Future<void> toggleBulb() async {
    final lastState = await future;

    var newState = !lastState.isOn;

    if (kIsWeb) {
      state = AsyncData(SwitchState(isOn: newState));
      return;
    }

    final response = await Dio().get('$bridgeUrl/switch/$ip/${newState ? 'on' : 'off'}');
    if (response.statusCode == 200) {
      state = AsyncData(SwitchState(isOn: newState));
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }
}
