import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_notifier.g.dart';

const bridgeUrl = "http://127.0.0.1:8000";

@Riverpod(keepAlive: true)
class AlarmNotifier extends _$AlarmNotifier {
  @override
  FutureOr<bool> build() async {
    if (kIsWeb) return false;

    final response = await Dio().get('$bridgeUrl/alarm/status');
    if (response.statusCode == 200) {
      return response.data['status'] == 'playing';
    } else {
      throw Exception("Failed to get alarm status");
    }
  }

  Future<void> startAlarm() async {
    if (kIsWeb) {
      state = AsyncData(true);
      return;
    }

    final response = await Dio().get('$bridgeUrl/alarm/play');
    if (response.statusCode == 200) {
      state = AsyncData(response.data['status'] == 'playing');
      return;
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }

  Future<void> stopAlarm() async {
    if (kIsWeb) {
      state = AsyncData(false);
      return;
    }

    final response = await Dio().get('$bridgeUrl/alarm/stop');
    if (response.statusCode == 200) {
      state = AsyncData(response.data['status'] == 'playing');
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }
}
