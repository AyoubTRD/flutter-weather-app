import 'package:clima/models/weather_data.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

import 'package:clima/utility/constants.dart';

class Networking {
  Future<WeatherData> getWeather(Location location) async {
    String baseUrl =
        'https://api.openweathermap.org/data/2.5/weather?units=metric&appid=$kApiKey';
    Uri uri;

    if (location.cityName != null) {
      uri = Uri.parse(baseUrl + '&q=${location.cityName}');
    } else {
      uri = Uri.parse(
        baseUrl + '&lat=${location.latitude}&lon=${location.longitude}',
      );
    }
    http.Response response = await http.get(uri);
    return WeatherData.fromJSON(response.body);
  }
}
