import 'package:http/http.dart' as http;
import 'dart:convert';

var url= 'api.openweathermap.org/data/2.5/weather';
var apiKey = '1a68c9ee1dbb5414ceab83339745342b';

class Networking {
  Networking({this.latitude, this.longitude});
  var latitude;
  var longitude;

  Future getWeather() async {
    http.Response response = await http.get(
        'https://$url?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    return jsonDecode(response.body);
  }

  Future getCityLocation(cityName) async {
    http.Response response = await http.get(
        'https://$url?q=$cityName&appid=$apiKey&units=metric');
    return jsonDecode(response.body);
  }
}
