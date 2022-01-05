import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  final Uri url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String weatherData = response.body;
      var decodedData = convert.jsonDecode(weatherData);
      return decodedData;
    } else {
      String error = 'Request failed with status: ${response.statusCode}';
      return error;
    }
  }
}
