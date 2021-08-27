import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/models/weather_data.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final _networking = Networking();

  BehaviorSubject<WeatherData> _subjectWeather = BehaviorSubject<WeatherData>();
  BehaviorSubject<bool> _subjectLoading = BehaviorSubject<bool>.seeded(false);

  Stream<WeatherData> get weather => _subjectWeather.stream;
  Stream<bool> get loading => _subjectLoading.stream;

  WeatherBloc() {
    getCurrentLocationWeather();
  }

  Future<void> getCurrentLocationWeather() async {
    _subjectLoading.sink.add(true);

    final location = Location();
    await location.getCurrentLocation();
    WeatherData weather = await _networking.getWeather(location);
    _subjectWeather.sink.add(weather);

    _subjectLoading.sink.add(false);
  }

  /// returns true -> success, false -> error
  Future<bool> getCityWeather({required String cityName}) async {
    _subjectLoading.sink.add(true);
    bool success;

    final location = Location(cityName: cityName);
    try {
      WeatherData weather = await _networking.getWeather(location);
      _subjectWeather.sink.add(weather);
      success = true;
    } catch (e) {
      success = false;
    }
    _subjectLoading.sink.add(false);
    return success;
  }

  dispose() {
    _subjectWeather.close();
    _subjectLoading.close();
  }
}
