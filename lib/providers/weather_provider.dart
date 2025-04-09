import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_first_app/models/weather.dart';
import 'package:my_first_app/repositories/api_repository.dart';

class WeatherProvider extends ChangeNotifier {
  Position? position;
  String cityName = '';
  updatePosition(Position positionCurrent) {
    position = positionCurrent;
    notifyListeners();
  }

  Future<WeatherData> getWeatherCurrent() async {
    WeatherData result = await ApiRepository.callApiGetWeather(position);
    cityName = result.name;
    notifyListeners();
    return result;
  }

  Future<List<WeatherDetail>> getWeatherDetail() async {
    List<WeatherDetail> result = await ApiRepository.callApiGetWeatherDetail(
      position,
    );
    return result;
  }
}
