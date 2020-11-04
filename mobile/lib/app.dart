import 'package:flutter/material.dart';
import 'package:mobile/screens/weather.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.grey[100],
            decorationColor: Colors.black,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 20
              )
            ]
          )
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      home: WeatherScreen(),
    );
  }
}