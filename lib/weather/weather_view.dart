import 'package:flutter/material.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          spacing: 18.0,
          children: [
            for (var image in ['image1', 'image2', 'image3'])
              Expanded(
                child: Container(
                  height: double.maxFinite,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.asset(
                    'images/$image.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
