import 'package:get/get.dart';
import 'package:my_weather_app/models/city.dart';

class HomeController extends GetxController {
  final cities = <City>[].obs;
  final nSelected = 0.obs;
  //final cities = RxList<City>([]);

  @override
  void onInit() {
    super.onInit();
    readCities();
  }

  void readCities() {
    cities.assignAll(City.citiesList);
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
    List<City> selectedCities = getSelectedCities();
    updateSelect(selectedCities.length);
    cities.refresh();
  }

  void updateSelect(int valueSelected) {
    nSelected.value = valueSelected;
  }
}
