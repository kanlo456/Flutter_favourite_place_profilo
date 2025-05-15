import 'dart:convert';
import 'package:favorite_places/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=HongKong&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
