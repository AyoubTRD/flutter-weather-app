import 'dart:convert';

class WeatherData {
  double temperature = 0;
  String description = '';
  String icon = '';
  late String locationName;

  WeatherData.fromJSON(String json) {
    dynamic data = jsonDecode(json);
    temperature = data['main']['temp'];
    description = data['weather'][0]['description'];
    icon = data['weather'][0]['icon'];
    locationName = data['name'];
  }
}
