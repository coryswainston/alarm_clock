import 'dart:ui';

import 'package:alarm_clock/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clock Hub',
        theme: ThemeData.dark(),
        home: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: HomePage(),
        ),
      ),
    );
  }
}
