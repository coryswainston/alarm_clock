import 'package:alarm_clock/constants.dart';
import 'package:alarm_clock/network.dart';
import 'package:alarm_clock/smarthome/switch_state.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch_notifier.g.dart';

@Riverpod(keepAlive: true)
class SwitchNotifier extends _$SwitchNotifier {
  @override
  FutureOr<SwitchState> build(String ip) async {
    try {
      final response = await dio.get('$apiUrl/switch/$ip/status');
      if (response.statusCode == 200) {
        return SwitchState(isOn: response.data['is_on']);
      } else {
        throw Exception("Failed to get bulb status");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to get bulb status");
    }
  }

  Future<void> toggleBulb() async {
    final lastState = await future;
    var newState = !lastState.isOn;

    final response = await dio.get('$apiUrl/switch/$ip/${newState ? 'on' : 'off'}');
    if (response.statusCode == 200) {
      state = AsyncData(SwitchState(isOn: newState));
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }
}
