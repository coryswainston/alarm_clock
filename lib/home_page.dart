import 'package:alarm_clock/clock/clock_view.dart';
import 'package:alarm_clock/smarthome/smarthome_view.dart';
import 'package:alarm_clock/theme_notifier.dart';
import 'package:alarm_clock/weather/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3, initialIndex: 1);
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: Theme(
        data: theme,
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      WeatherView(),
                      ClockView(),
                      SmarthomeView(),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
