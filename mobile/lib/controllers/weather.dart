import 'dart:async';
import 'package:location/location.dart';
import 'package:mobile/models/weather.dart';
import 'package:mobile/services.dart/http.dart';
import 'package:mobile/services.dart/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherController{
  StreamController<Weather> _weather = StreamController<Weather>();
  HttpService httpService = HttpService();

  Future<bool> _updateWeather({String cityName, double lat, double lon}) async{
    try{
      Weather newWeather ;
      if(cityName!=null)
        newWeather = Weather.fromJson(await httpService.getWeatherByCityName(cityName));
      else if(lat != null && lon!= null)
        newWeather = Weather.fromJson(await httpService.getWeatherByLocation(lat, lon));
      else
        return false;

      _weather.sink.add(newWeather);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cityName', newWeather.cityName);

      return true;
    } catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> updateWeatherByLocation(double lat, double lon) async{
    return _updateWeather(lat: lat, lon: lon);
  }

  Future<bool> updateWeatherByCityName(String cityName) async{
   return _updateWeather(cityName: cityName);
  }

  Future<bool> initFromDefaultLocation() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cityName = prefs.getString('cityName');

    if(cityName!= null)
      return updateWeatherByCityName(cityName);

    LocationService locationService = LocationService();
    LocationData locationData = await locationService.getLocation();

    if(locationData!=null)
      return updateWeatherByLocation(locationData.latitude, locationData.longitude);
    
    return updateWeatherByCityName('Brasília');
  }

  Stream<Weather> get weather{
    return _weather.stream;
  }

  String filterAssetByWeatherId(int id){
    if(id>800)
      return 'clouds.jpg';
    if(id==800)
      return 'clear.jpg';
    if(id>700)
      return 'atmosphere.jpg';
    if(id>600)
      return 'snow.jpg';
    if(id>300)
      return 'rain.jpg';
    if(id>200)
      return 'thunderstorm.jpg';

    return 'default.jpg';
  }

  void dispose(){
    _weather.close();
  }
}