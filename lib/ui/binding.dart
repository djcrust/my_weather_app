import 'package:get/get.dart';
import 'package:my_weather_app/controller/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
