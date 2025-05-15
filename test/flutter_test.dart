import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/places_detail.dart';
import 'package:favorite_places/service/weather_service.dart';
import 'package:test/test.dart';
import 'package:favorite_places/providers/user_places.dart';

main() {
  test('Test get image', () {
    final temPlaceLocation =
        PlaceLocation(latitude: 12, longitude: 24, address: '');
    final temPlace =
        Place(title: 'test', image: File(''), location: temPlaceLocation);
    final getImage = PlaceDetailScreen(place: temPlace);
    expect(getImage, isNotNull);
  });

  test('Get weather', () {
    final getWeather = WeatherService('bdc4997e6276c2aa3af027d113984e7a');
    expect(getWeather.getWeather(),isNotNull);
  });

  test('Fail to get weather', () {
    final getWeather = WeatherService('wrong api key');
    expect(getWeather.getWeather(),throwsException);
  });

    
}
