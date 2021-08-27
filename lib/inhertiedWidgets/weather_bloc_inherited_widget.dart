import 'package:clima/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';

class WeatherBlocInherited extends InheritedWidget {
  final weatherBloc = WeatherBloc();

  WeatherBlocInherited({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static WeatherBlocInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WeatherBlocInherited>();
  }
}
