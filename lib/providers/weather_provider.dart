import 'package:favorite_places/models/weather.dart';
import 'package:favorite_places/service/weather_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const apiKey = "";

final weatherProvider = FutureProvider<Weather>((ref) async {
  final weatherService = ref.read(weatherServiceProvider);
  // For this example, let's assume a fixed location (latitude and longitude)
  return weatherService.getWeather();
});

// Provide the WeatherService using a provider for easy mocking and testing
final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService('');
});
