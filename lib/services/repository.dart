import 'package:my_weather_app/models/city.dart';

class CityRepository {
  List<City> readCities() => City.citiesList;

  //List<City> cities = City.citiesList.where((city) => city.isDefault == false).toList();

}
