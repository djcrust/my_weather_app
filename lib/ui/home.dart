import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/controller/controller.dart';
import 'package:my_weather_app/models/constants.dart';
import 'package:my_weather_app/widgets/weather_item.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants myyConstants = Constants();
    homeCtrl.fetchWeatherForecast('London');
    homeCtrl.setLocationFn('London');
    homeCtrl.fetchWeather('London');
    homeCtrl.selectedCitiesList();
    //String location = 'London';

    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/profile.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pin.png',
                      width: 20.0,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: homeCtrl.selLocation.value.isNotEmpty
                            ? homeCtrl.selLocation.value
                            : 'London',
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: homeCtrl.citiess.map((String locationField) {
                          return DropdownMenuItem(
                            value: locationField,
                            child: Text(locationField),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          homeCtrl.setLocationFn(newValue!);
                          homeCtrl.fetchWeatherForecast(newValue);
                          homeCtrl.fetchWeather(newValue);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                homeCtrl.selLocation.value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              Text(
                homeCtrl.currentDate.value,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: myyConstants.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: myyConstants.primaryColor.withOpacity(.5),
                      offset: const Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -12,
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -40,
                      left: 20,
                      child: homeCtrl.imageUrl == ''
                          ? const Text('')
                          : Image.network(
                              'http:${homeCtrl.imageUrl}',
                              width: 100,
                            ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        homeCtrl.weatherStateName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              double.parse(homeCtrl.temperature)
                                  .round()
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Text(
                            'o',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weatherwidget(
                      value: homeCtrl.windSpeed,
                      text: 'Wind Speed',
                      unit: 'km/h',
                      imageUrl: 'assets/windspeed.png',
                    ),
                    weatherwidget(
                      value: homeCtrl.humidity,
                      text: 'Humidity',
                      unit: '',
                      imageUrl: 'assets/humidity.png',
                    ),
                    weatherwidget(
                      value: homeCtrl.maxTemp,
                      text: 'Max Temp',
                      unit: 'C',
                      imageUrl: 'assets/max-temp.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Next 3 Days',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: myyConstants.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeCtrl.objTest1.forecast.forecastday.length,
                  itemBuilder: (BuildContext context, int index) {
                    String today = DateTime.now().toString().substring(0, 10);
                    var selectedDay =
                        homeCtrl.objTest1.forecast.forecastday[index].date;
                    var parsedDate = DateTime.parse(selectedDay);
                    var newDate =
                        DateFormat('EEEE').format(parsedDate).substring(0, 3);
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      margin: const EdgeInsets.only(
                        right: 20.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      width: 80,
                      decoration: BoxDecoration(
                        color: selectedDay == today
                            ? myyConstants.primaryColor
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            color: selectedDay == today
                                ? myyConstants.primaryColor
                                : Colors.black54.withOpacity(.2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${homeCtrl.objTest1.forecast.forecastday[index].day.avgtempC?.toInt()}C',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: selectedDay == today
                                  ? Colors.white
                                  : myyConstants.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Image.network(
                            'http:${homeCtrl.objTest1.forecast.forecastday[index].day.condition.icon}',
                            width: 40,
                          ),
                          Text(
                            newDate,
                            style: TextStyle(
                              fontSize: 17,
                              color: selectedDay == today
                                  ? Colors.white
                                  : myyConstants.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
