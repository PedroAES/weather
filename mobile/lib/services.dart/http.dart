import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService{
  String url = 'http://10.0.2.2:3001/weather/?';

  Future<Map<String, dynamic>> _getWeather({String cityName, double lat, double lon}) async {
    String query = '';
    if(cityName!= null)
      query = 'city=$cityName';
    else if(lon!= null && lat!=null)
      query = 'lat=$lat&lon=$lon';
    
    else
      throw HttpException("City name or latitude and longitude must be provided");
    
    http.Response response = await http.get(
      url+query,
      headers: {"Content-Type": "application/json"}
    );
    
    if(response.statusCode != 200)
      throw HttpException(response.body);
    
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getWeatherByCityName(String cityName){
    return _getWeather(cityName: cityName);
  }

   Future<Map<String, dynamic>> getWeatherByLocation(double lat, double lon){
    return _getWeather(lat: lat, lon: lon);
  }
}