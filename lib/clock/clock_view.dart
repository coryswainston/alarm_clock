import 'dart:async';

import 'package:alarm_clock/clock/alarm_notifier.dart';
import 'package:alarm_clock/scores/scores_widget.dart';
import 'package:alarm_clock/smarthome/lightbulb_notifier.dart';
import 'package:alarm_clock/theme_notifier.dart';
import 'package:alarm_clock/weather/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ClockView extends HookConsumerWidget {
  const ClockView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(themeNotifierProvider).brightness == Brightness.dark;

    final setAlarm = useState<TimeOfDay?>(null);
    final editingAlarm = useState(false);
    final currentTime = useState(DateTime.now());
    final alarmHasGoneOff = useState(false);

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 1), (timer) {
        currentTime.value = DateTime.now();
        if (alarmHasGoneOff.value) return;
        if (setAlarm.value == null) return;
        if (currentTime.value.hour == setAlarm.value?.hour && currentTime.value.minute == setAlarm.value?.minute) {
          alarmHasGoneOff.value = true;
          ref.read(lightbulbNotifierProvider(corysLamp).notifier).setBulbState('night');
          ref.read(alarmNotifierProvider.notifier).startAlarm();
        }
        if (currentTime.value.hour == setAlarm.value?.hour &&
            currentTime.value.minute == (setAlarm.value!.minute + 1)) {
          alarmHasGoneOff.value = false;
          ref.read(alarmNotifierProvider.notifier).stopAlarm();
        }
      });

      return () {
        timer.cancel();
      };
    }, []);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 48),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      DateFormat('h:mm').format(currentTime.value),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: MediaQuery.of(context).size.height / 3,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      DateFormat(' a').format(DateTime.now()),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: MediaQuery.of(context).size.height / 6,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                if (editingAlarm.value) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setAlarm.value = setAlarm.value!.subtractMinutes(15);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        setAlarm.value!.format(context),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.height / 12,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setAlarm.value = setAlarm.value!.addMinutes(15);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.green, width: 2.0),
                          foregroundColor: Colors.green,
                        ),
                        onPressed: () {
                          editingAlarm.value = false;
                          setAlarm.value = null;
                        },
                        child: Text('Clear'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          editingAlarm.value = false;
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ] else if (setAlarm.value == null)
                  IconButton(
                    iconSize: 36,
                    color: ColorScheme.of(context).onSurface,
                    onPressed: () {
                      setAlarm.value = TimeOfDay(hour: 6, minute: 30);
                      editingAlarm.value = true;
                    },
                    icon: Icon(Icons.alarm_add),
                  )
                else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 20,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          setAlarm.value!.format(context),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          side: BorderSide(color: Colors.green, width: 2.0),
                          foregroundColor: Colors.green,
                          minimumSize: Size(0, 0),
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                        onPressed: () {
                          editingAlarm.value = true;
                        },
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => ref.read(themeNotifierProvider.notifier).toggleDarkMode(),
              icon: Icon(
                Icons.brightness_6,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              spacing: 12.0,
              children: [
                WeatherWidget(),
                ScoresWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addMinutes(int minutes) {
    final totalMinutes = hour * 60 + minute + minutes;
    final newHour = (totalMinutes ~/ 60) % 24;
    final newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  TimeOfDay subtractMinutes(int minutes) {
    final totalMinutes = hour * 60 + minute - minutes;
    final newHour = (totalMinutes ~/ 60) % 24;
    final newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }
}
