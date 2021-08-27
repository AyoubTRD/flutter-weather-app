import 'package:clima/inhertiedWidgets/weather_bloc_inherited_widget.dart';
import 'package:clima/screens/weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WeatherBlocInherited(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: WeatherScreen(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   final _counterBloc = CounterBloc();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Counter',
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('Counter'),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: _counterBloc.decrement,
//                 icon: Icon(Icons.remove),
//               ),
//               IconButton(
//                 onPressed: _counterBloc.increment,
//                 icon: Icon(Icons.add),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _counterBloc.reset,
//           child: Icon(Icons.restore),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         body: Center(
//           child: StreamBuilder<int>(
//             stream: _counterBloc.counter,
//             builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//               return Text(
//                 snapshot.data.toString(),
//                 style: Theme.of(context).textTheme.headline1,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
