import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weather_app/ui/get_started.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'My Weather App',
      debugShowCheckedModeBanner: false,
      home: GetStarted(),
    );
  }
}
