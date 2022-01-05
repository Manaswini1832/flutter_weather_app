import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Location loc = Location();
  double latitude = 0.0;
  double longitude = 0.0;

  String urlAuthority = 'api.openweathermap.org';
  String urlUnencodedPath = '/data/2.5/weather';
  String apiKey = '<PASTE API KEY HERE>';

  Future<dynamic> getWeatherOfCurrentLocation() async {
    //Get the latitude and longitude of user location
    var coordinatesList = await loc.getCurrentLocation();
    if (coordinatesList == 'Location services are disabled.') {
      return 'Location services are disabled.';
    } else if (coordinatesList == 'Location permissions are denied') {
      return 'Location permissions are denied';
    } else if (coordinatesList ==
        'Location permissions are permanently denied, we cannot request permissions.') {
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }

    latitude = coordinatesList[0];
    longitude = coordinatesList[1];

    //Create a URL to query open weather map's servers using the latitude and longitude obtained above
    Uri uri = Uri.https(urlAuthority, urlUnencodedPath, {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': apiKey
    });

    //Send the URL to networking.dart which will get the jsonWeatherData
    NetworkHelper networkHelper = NetworkHelper(uri);
    var jsonWeatherData = await networkHelper.getData();
    return jsonWeatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition <= 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp, String cityName) {
    if (temp > 25) {
      return 'It\'s 🍦 time in $cityName';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in $cityName';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in $cityName';
    } else {
      return 'Bring a 🧥 just in case to $cityName';
    }
  }

  Future<dynamic> getCustomCityWeather(String enteredCity) async {
    Uri uri = Uri.https(
        urlAuthority, urlUnencodedPath, {'q': enteredCity, 'appid': apiKey});
    NetworkHelper networkHelper = NetworkHelper(uri);
    var jsonWeatherData = await networkHelper.getData();
    return jsonWeatherData;
  }
}
