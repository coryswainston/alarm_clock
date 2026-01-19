import 'package:alarm_clock/constants.dart';
import 'package:alarm_clock/smarthome/lightbulb_notifier.dart';
import 'package:alarm_clock/smarthome/switch_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LightsWidget extends HookConsumerWidget {
  const LightsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.0,
      children: [
        for (final lamp in [corysLamp, annasLamp])
          ref
              .watch(lightbulbNotifierProvider(lamp))
              .when(
                data: (data) {
                  return Material(
                    borderRadius: BorderRadius.circular(12.0),
                    color: data.currentScene == 'off'
                        ? ColorScheme.of(context).surfaceContainer
                        : data.currentScene == 'night'
                        ? ColorScheme.of(context).onSurface.withOpacity(0.5)
                        : ColorScheme.of(context).onSurface,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        ref.read(lightbulbNotifierProvider(lamp).notifier).toggleBulb();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          data.currentScene == 'off' ? Icons.lightbulb_outline : Icons.lightbulb,
                          color: data.currentScene == 'off'
                              ? ColorScheme.of(context).onSurface
                              : ColorScheme.of(context).surface,
                        ),
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Opacity(
                    opacity: 0.5,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        ref.invalidate(lightbulbNotifierProvider(lamp));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ColorScheme.of(context).surfaceContainer,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.lightbulb_outline,
                            color: ColorScheme.of(context).onSurface,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                loading: () {
                  return Stack(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ColorScheme.of(context).surfaceContainer,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.lightbulb_outline,
                            color: ColorScheme.of(context).onSurface,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: SizedBox(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
        ref
            .watch(switchNotifierProvider(ceilingFan))
            .when(
              data: (data) {
                return Material(
                  borderRadius: BorderRadius.circular(12.0),
                  color: !data.isOn ? ColorScheme.of(context).surfaceContainer : ColorScheme.of(context).onSurface,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      ref.read(switchNotifierProvider(ceilingFan).notifier).toggleBulb();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.light_outlined,
                        color: !data.isOn ? ColorScheme.of(context).onSurface : ColorScheme.of(context).surface,
                      ),
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                return Opacity(
                  opacity: 0.5,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      ref.invalidate(switchNotifierProvider(ceilingFan));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(12.0),
                      color: ColorScheme.of(context).surfaceContainer,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.light_outlined,
                          color: ColorScheme.of(context).onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              },
              loading: () {
                return Stack(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(12.0),
                      color: ColorScheme.of(context).surfaceContainer,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.light_outlined,
                          color: ColorScheme.of(context).onSurface,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      ],
    );
  }
}
