import 'package:dio/dio.dart';
import 'package:my_first_app/apps/utils/const.dart';
import 'package:my_first_app/models/weather.dart';

class ApiRepository {
  static Future<WeatherData> callApiGetWeather() async {
    try {
      final dio = Dio();
      final res = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=10,77585&lon=106,75467&units=metric&appid=${MyKey.api_token}',
      );
      final data = res.data;
      WeatherData result = WeatherData.fromMap(data);
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<WeatherDetail>> callApiGetWeatherDetail() async {
    try {
      final dio = Dio();
      final res = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=10.801831111111111&lon=106.65113833333334&units=metric&appid=${MyKey.api_token}',
      );
      List data = res.data['list'];
      List<WeatherDetail> result = List<WeatherDetail>.from(
        data.map((e) => WeatherDetail.fromMap(e)).toList(),
      );
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
