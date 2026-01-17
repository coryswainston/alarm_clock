import 'package:alarm_clock/smarthome/lightbulb_notifier.dart';
import 'package:alarm_clock/smarthome/switch_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SmarthomeView extends HookConsumerWidget {
  const SmarthomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Text(
            'Lights',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 18.0,
              children: [
                for (final lamp in [corysLamp, annasLamp])
                  ref
                      .watch(lightbulbNotifierProvider(lamp))
                      .when(
                        data: (data) {
                          return Material(
                            borderRadius: BorderRadius.circular(18.0),
                            color: data.currentScene == 'off'
                                ? ColorScheme.of(context).surfaceContainer
                                : data.currentScene == 'night'
                                ? ColorScheme.of(context).onSurface.withOpacity(0.5)
                                : ColorScheme.of(context).onSurface,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18.0),
                              onTap: () {
                                ref.read(lightbulbNotifierProvider(lamp).notifier).toggleBulb();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      lamp == corysLamp ? 'Cory\'s lamp' : 'Anna\'s lamp',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: data.currentScene == 'off'
                                            ? ColorScheme.of(context).onSurface
                                            : ColorScheme.of(context).surface,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Icon(
                                      data.currentScene == 'off' ? Icons.lightbulb_outline : Icons.lightbulb,
                                      color: data.currentScene == 'off'
                                          ? ColorScheme.of(context).onSurface
                                          : ColorScheme.of(context).surface,
                                      size: 64,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return Stack(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(18.0),
                                onTap: () {
                                  ref.invalidate(lightbulbNotifierProvider(lamp));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(18.0),
                                  color: ColorScheme.of(context).surfaceContainer,
                                  child: Container(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          lamp == corysLamp ? 'Cory\'s lamp' : 'Anna\'s lamp',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: ColorScheme.of(context).onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Icon(
                                          Icons.lightbulb_outline,
                                          color: ColorScheme.of(context).onSurface,
                                          size: 64,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Icon(
                                  Icons.error_outline,
                                  size: 16,
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () {
                          return Stack(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(18.0),
                                color: ColorScheme.of(context).surfaceContainer,
                                child: Container(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        lamp == corysLamp ? 'Cory\'s lamp' : 'Anna\'s lamp',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: ColorScheme.of(context).onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      Icon(
                                        Icons.lightbulb_outline,
                                        color: ColorScheme.of(context).onSurface,
                                        size: 64,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(strokeWidth: 2),
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
                          borderRadius: BorderRadius.circular(18.0),
                          color: !data.isOn
                              ? ColorScheme.of(context).surfaceContainer
                              : ColorScheme.of(context).onSurface,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18.0),
                            onTap: () {
                              ref.read(switchNotifierProvider(ceilingFan).notifier).toggleBulb();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Ceiling fan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: !data.isOn
                                          ? ColorScheme.of(context).onSurface
                                          : ColorScheme.of(context).surface,
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Icon(
                                    Icons.light_outlined,
                                    color: !data.isOn
                                        ? ColorScheme.of(context).onSurface
                                        : ColorScheme.of(context).surface,
                                    size: 64,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return Stack(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(18.0),
                              onTap: () {
                                ref.invalidate(switchNotifierProvider(ceilingFan));
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(18.0),
                                color: ColorScheme.of(context).surfaceContainer,
                                child: Container(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Ceiling fan',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: ColorScheme.of(context).onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      Icon(
                                        Icons.light_outlined,
                                        color: ColorScheme.of(context).onSurface,
                                        size: 64,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Icon(
                                Icons.error_outline,
                                size: 16,
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () {
                        return Stack(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(18.0),
                              color: ColorScheme.of(context).surfaceContainer,
                              child: Container(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Ceiling fan',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: ColorScheme.of(context).onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Icon(
                                      Icons.light_outlined,
                                      color: ColorScheme.of(context).onSurface,
                                      size: 64,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: SizedBox(
                                height: 14,
                                width: 14,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
