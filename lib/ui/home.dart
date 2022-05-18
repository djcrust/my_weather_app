import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weather_app/controller/controller.dart';
import 'package:my_weather_app/models/constants.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();

    int temperature = 0;
    int maxTemp = 0;
    String weatherStateName = 'Loading...';
    int humidity = 0;
    int windSpeed = 0;
    var currentDate = 'Loading...';
    String imageUrl = '';
    int woied = 44418;
    String location = 'London';

    var selectedCities = homeCtrl.getSelectedCities();
    List<String> cities = ['London'];

    List consolidateWeatherList = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: myConstants.secondaryColor,
        title: Text('Home Page'),
      ),
    );
  }
}
