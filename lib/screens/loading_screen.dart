import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weatherModel = WeatherModel();

  void getWeatherData() async {
    var jsonWeatherData = await weatherModel.getWeatherOfCurrentLocation();
    //After getting the weather data, go to the location screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(jsonWeatherData);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitDoubleBounce(
              size: 80.0,
              color: Colors.white,
              // itemBuilder: ,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('Fetching weather...', style: kErrorTextStyle),
          ],
        ),
      ),
    );
  }
}
