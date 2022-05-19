import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/models/city.dart';
import 'package:my_weather_app/models/weather.dart';
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
  RxString currentDate = 'Loading...'.obs;
  late String imageUrl = '';
  var weatherObject = <Weather>[];
  List<String> citiess = ['London'];
  RxString selLocation = 'London'.obs;
  late Weather objTest1;

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

  void setLocationFn(String location) {
    selLocation.value = location;
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

  void fetchWeatherForecast(String location) async {
    var searchResult = await RequestAssistant.getRequest(
        '${MyConstants.wUrl}${MyConstants.wToken}&q=$location&days=3');
    if (searchResult != null) {
      var objWeather = Weather.fromJson(searchResult);
      objTest1 = objWeather;
      //print(objTest1.current.tempC);
    }
  }

  void selectedCitiesList() {
    List<City> selectedCities = getSelectedCities();
    for (int i = 0; i < selectedCities.length; i++) {
      citiess.add(selectedCities[i].city);
    }
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
    imageUrl = consolidatedWeather[0]['day']['condition']['icon'];
    var myDate = DateTime.parse(consolidatedWeather[0]['date']);
    currentDate.value = DateFormat('EEEE, d MMMM').format(myDate);
  }
}
