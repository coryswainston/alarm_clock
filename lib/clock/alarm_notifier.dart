import 'package:alarm_clock/constants.dart';
import 'package:alarm_clock/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_notifier.g.dart';

@Riverpod(keepAlive: true)
class AlarmNotifier extends _$AlarmNotifier {
  @override
  FutureOr<bool> build() async {
    final response = await dio.get('$apiUrl/alarm/status');
    if (response.statusCode == 200) {
      return response.data['status'] == 'playing';
    } else {
      throw Exception("Failed to get alarm status");
    }
  }

  Future<void> startAlarm() async {
    final response = await dio.get('$apiUrl/alarm/play');
    if (response.statusCode == 200) {
      state = AsyncData(response.data['status'] == 'playing');
      return;
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }

  Future<void> stopAlarm() async {
    final response = await dio.get('$apiUrl/alarm/stop');
    if (response.statusCode == 200) {
      state = AsyncData(response.data['status'] == 'playing');
    } else {
      state = AsyncError('Error changing light', StackTrace.current);
    }
  }
}
