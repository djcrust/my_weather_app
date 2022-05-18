import 'package:get/get.dart';
import 'package:my_weather_app/models/city.dart';
import 'package:my_weather_app/services/repository.dart';

class HomeController extends GetxController {
  CityRepository cityRepository;
  HomeController({
    required this.cityRepository,
  });

  final cities = <City>[].obs;

  @override
  void onInit() {
    super.onInit();
    cities.assignAll(cityRepository.readCities());
  }

  @override
  void onClose() {
    cities.clear();
    super.onClose();
  }

  getSelectedCities() {
    return cities.where((city) => city.isSelected == true).toList();
  }

  void setSelectedCity(int index) {
    cities[index].isSelected = !cities[index].isSelected;
  }
}
