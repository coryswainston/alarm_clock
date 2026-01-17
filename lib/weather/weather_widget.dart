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

    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 14.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                WeatherData.getWeatherIcon(
                  weatherData?.code ?? 0,
                ),
                size: 26,
              ),
              const SizedBox(width: 14.0),
              Text(
                '${weatherData?.temperature.toStringAsFixed(0) ?? '--'}\u00B0',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
