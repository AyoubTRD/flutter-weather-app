import 'package:clima/inhertiedWidgets/weather_bloc_inherited_widget.dart';
import 'package:clima/models/weather_data.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool typing = false;

  @override
  Widget build(BuildContext context) {
    final weatherBloc = WeatherBlocInherited.of(context)!.weatherBloc;

    return Scaffold(
      appBar: SearchAppBar(),
      body: Center(
        child: StreamBuilder<bool>(
          stream: weatherBloc.loading,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data == false) {
              return StreamBuilder<WeatherData>(
                stream: weatherBloc.weather,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherData> snapshot) {
                  if (snapshot.hasData) {
                    return _buildWeather(context, snapshot.data as WeatherData);
                  }
                  return CircularProgressIndicator();
                },
              );
            } else {
              return CircularProgressIndicator(
                color: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeather(BuildContext context, WeatherData data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${data.temperature.toStringAsFixed(1)}°',
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        Image.network('http://openweathermap.org/img/wn/${data.icon}@2x.png'),
        Text(
          data.description.toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool typing = false;

  @override
  Widget build(BuildContext context) {
    final weatherBloc = WeatherBlocInherited.of(context)!.weatherBloc;
    final weather = weatherBloc.weather;

    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          setState(() {
            typing = !typing;
          });
        },
        icon: Icon(Icons.search),
      ),
      title: typing
          ? TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'City name',
              ),
              onEditingComplete: () {
                setState(() {
                  typing = false;
                });
              },
              onSubmitted: (String value) async {
                bool success =
                    await weatherBloc.getCityWeather(cityName: value);
                if (!success) {
                  final controller = showBottomSheet(
                    context: context,
                    builder: _buildBottomSheet,
                  );
                  await Future.delayed(Duration(seconds: 3));
                  controller.close();
                }
              },
            )
          : StreamBuilder<WeatherData>(
              stream: weather,
              builder: (context, snapshot) => Text(
                'Weather in: ${snapshot.data?.locationName}'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.0,
      color: Colors.black,
      child: Center(
        child: Text(
          'Wrong city name',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
