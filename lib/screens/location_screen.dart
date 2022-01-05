import 'package:flutter/material.dart';
import 'city_screen.dart';

import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen(this.locationWeather);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  int condition = 0;
  String cityName = '';
  String errorMessage = '';
  bool errorFound = false;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == 'Location services are disabled.') {
      setState(() {
        errorMessage = 'Location services are disabled.';
        temperature = 0;
        condition = 0;
        cityName = '';
        errorFound = true;
      });
      return;
    } else if (weatherData == 'Location permissions are denied') {
      setState(() {
        errorMessage = 'Location permissions are denied';
        temperature = 0;
        condition = 0;
        cityName = '';
        errorFound = true;
      });
      return;
    } else if (weatherData ==
        'Location permissions are permanently denied, we cannot request permissions.') {
      setState(() {
        errorMessage =
            'Location permissions are permanently denied, we cannot request permissions.';
        temperature = 0;
        condition = 0;
        cityName = '';
        errorFound = true;
      });
      return;
    } else if (weatherData == null) {
      setState(() {
        errorMessage = 'Error obtaining weather. Please try later!';
        temperature = 0;
        condition = 0;
        cityName = '';
        errorFound = true;
      });
      return;
    }
    setState(() {
      temperature = weatherData["main"]["temp"].toInt();
      condition = weatherData["weather"][0]["id"];
      cityName = weatherData["name"];
      errorFound = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: errorFound
            ? Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Oops!', style: kErrorTitleStyle),
                    Text(errorMessage, style: kErrorTextStyle),
                    errorMessage == 'Location services are disabled.'
                        ? Text(
                            'Try turning on your GPS. If this still doesn\'t solve the problem, please try again later!',
                            style: kErrorTextStyle)
                        : Text(''),
                    errorMessage == 'Location permissions are denied.'
                        ? Text(
                            'Seems like you haven\'t given us permission to access your location. This is required to show you the weather at your place. Please try turning on your GPS to keep using our service. Thank you!',
                            style: kErrorTextStyle)
                        : Text(''),
                    errorMessage ==
                            'Location permissions are permanently denied, we cannot request permissions.'
                        ? Text(
                            'Please try uninstalling and then reinstalling Clima. If the issue still persists, please try contacting us at Clima\'s customer service',
                            style: kErrorTextStyle)
                        : Text(''),
                    errorMessage == null
                        ? Text('Please try again later!',
                            style: kErrorTextStyle)
                        : Text('')
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/location_background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.4), BlendMode.dstATop),
                  ),
                ),
                constraints: BoxConstraints.expand(),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Color(0xFF60513E).withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () async {
                                var jsonWeatherData = await weatherModel
                                    .getWeatherOfCurrentLocation();
                                updateUI(jsonWeatherData);
                              },
                              child: Icon(
                                Icons.near_me,
                                size: 50.0,
                                color: Colors.white70,
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                var enteredCityName = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CityScreen();
                                    },
                                  ),
                                );
                                if (enteredCityName != null) {
                                  //Make request to get weather data
                                  var weatherData = await weatherModel
                                      .getCustomCityWeather(enteredCityName);
                                  updateUI(weatherData);
                                }
                              },
                              child: Icon(
                                Icons.location_city,
                                size: 50.0,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(temperature - 273).toString()}°C',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weatherModel.getWeatherIcon(condition),
                              style: kConditionTextStyle,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      weatherModel.getMessage(
                                          temperature - 273, cityName),
                                      style: kMessageTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
