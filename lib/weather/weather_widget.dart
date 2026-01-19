import 'dart:async';

import 'package:alarm_clock/weather/weather_data.dart';
import 'package:alarm_clock/weather/weather_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherWidget extends HookConsumerWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(weatherNotifierProvider).value;

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 60 * 5), (timer) async {
        ref.invalidate(weatherNotifierProvider);
      });

      return () {
        timer.cancel();
      };
    }, []);

    return Container(
      decoration: BoxDecoration(
        color: ColorScheme.of(context).surfaceContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 9.0),
      child: Row(
        children: [
          Icon(
            WeatherData.getWeatherIcon(
              weatherData?.code ?? 0,
            ),
            size: 32,
          ),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${weatherData?.temperature.toStringAsFixed(0) ?? '--'}\u00B0',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                WeatherData.getWeatherDescription(weatherData?.code ?? 0),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
