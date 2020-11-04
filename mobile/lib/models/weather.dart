class Weather {
  int id;
  String cityName;
  String weather;
  int temp;
  int tempMax;
  int tempMin;

  Weather({
    this.id,
    this.cityName,
    this.weather,
    this.temp,
    this.tempMax,
    this.tempMin
  });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['cityName'];
    weather = json['weather'];
    temp = json['temp'].round();
    tempMax = json['tempMax'].round();
    tempMin = json['tempMin'].round();
  }
}