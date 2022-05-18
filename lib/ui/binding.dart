import 'package:get/get.dart';
import 'package:my_weather_app/controller/controller.dart';
import 'package:my_weather_app/services/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
      cityRepository: CityRepository(),
    ));
  }
}
