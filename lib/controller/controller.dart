import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/models/city.dart';
import 'package:my_weather_app/services/request_assistant.dart';
import 'package:my_weather_app/constants/my_constants.dart';

class HomeController extends GetxController {
  final cities = <City>[].obs;
  final nSelected = 0.obs;
  final List forecastWeather = [];
  late String temperature = '';
  late String humidity = '';
  late String windSpeed = '';
  String weatherStateName = 'Loading...';
  late String maxTemp = '';
  String currentDate = 'Loading...';

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

  void fetchWeather(String location) async {
    var searchResult = await RequestAssistant.getRequest(
        '${MyConstants.wUrl}${MyConstants.wToken}&q=$location&days=3');
    var searchResultForecast = searchResult['forecast'];
    var consolidatedWeather = searchResultForecast['forecastday'];

    for (int i = 0; i < 3; i++) {
      forecastWeather.add(consolidatedWeather[i]);
    }
    temperature = consolidatedWeather[0]['day']['avgtemp_c'].toString();
    weatherStateName = consolidatedWeather[0]['day']['condition']['text'];
    humidity = consolidatedWeather[0]['day']['avghumidity'].toString();
    windSpeed = consolidatedWeather[0]['day']['maxwind_kph'].toString();
    maxTemp = consolidatedWeather[0]['day']['maxtemp_c'].toString();

    var myDate = DateTime.parse(consolidatedWeather[0]['date']);
    currentDate = DateFormat('EEEE, d MMMM').format(myDate);

    print(currentDate);
  }
}
