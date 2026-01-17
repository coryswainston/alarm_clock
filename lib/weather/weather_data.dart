import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherData {
  final int code;
  final double temperature;
  final double windSpeed;

  WeatherData({
    required this.code,
    required this.temperature,
    required this.windSpeed,
  });

  static IconData getWeatherIcon(int code) {
    final isDayTime = DateTime.now().hour >= 6 && DateTime.now().hour < 18;

    switch (code) {
      case 0:
        return isDayTime ? WeatherIcons.day_sunny : WeatherIcons.night_clear;
      case 1:
        return isDayTime ? WeatherIcons.day_cloudy : WeatherIcons.night_cloudy;
      case 2:
      case 3:
        return WeatherIcons.cloudy;
      case 45:
      case 48:
        return isDayTime ? WeatherIcons.day_fog : WeatherIcons.night_fog;
      case 51:
      case 53:
      case 55:
        return isDayTime ? WeatherIcons.day_rain : WeatherIcons.night_rain;
      case 61:
      case 63:
      case 65:
        return isDayTime ? WeatherIcons.day_showers : WeatherIcons.night_showers;
      case 71:
      case 73:
      case 75:
        return isDayTime ? WeatherIcons.day_snow : WeatherIcons.night_snow;
      case 95:
        return isDayTime ? WeatherIcons.day_thunderstorm : WeatherIcons.night_thunderstorm;
      default:
        return isDayTime ? WeatherIcons.day_sunny : WeatherIcons.night_clear;
    }
  }

  static String getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Sunny';
      case 1:
        return 'Mostly Sunny';
      case 2:
        return 'Partly cloudy';
      case 3:
        return 'Cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzling';
      case 61:
      case 63:
      case 65:
        return 'Raining';
      case 71:
      case 73:
      case 75:
        return 'Snowing';
      case 95:
        return 'Thunderstorm';
      default:
        return 'Unknown';
    }
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      code: json['weather_code'],
      temperature: json['temperature_2m'],
      windSpeed: json['wind_speed_10m'],
    );
  }
}
