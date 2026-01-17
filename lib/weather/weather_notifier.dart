import 'package:alarm_clock/weather/weather_data.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_notifier.g.dart';

@Riverpod(keepAlive: true)
class WeatherNotifier extends _$WeatherNotifier {
  @override
  Future<WeatherData> build() async {
    final response = await Dio().get(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': 40.1150,
        'longitude': -111.6549,
        'current': 'temperature_2m,wind_speed_10m,weather_code',
        'temperature_unit': 'fahrenheit',
        'wind_speed_unit': 'mph',
        'timezone': 'auto',
      },
    );

    if (response.statusCode == 200) {
      print(response.data['current']);
      return WeatherData.fromJson(response.data['current']);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
