import 'package:flutter/material.dart';
import 'package:mobile/controllers/weather.dart';
import 'package:mobile/models/weather.dart';
import 'package:mobile/widgets.dart/title_search_box.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherController weatherController = WeatherController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    weatherController.initFromDefaultLocation();
    return Scaffold(
      body: StreamBuilder(
        stream: weatherController.weather,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          Weather weather = snapshot.data;
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                image: AssetImage(
                  'assets/images/'+weatherController.filterAssetByWeatherId(weather.id),
                ),
                  fit: BoxFit.cover
              )
            ),
            padding: EdgeInsets.only(right: 30),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TitleSearchBox(
                  title: weather.cityName,
                  controller: searchController,
                  callback: () async {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Atualizando...')));
                    bool result = await weatherController.updateWeatherByCityName(searchController.text);
                    searchController.clear();
                    if(!result){
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Não foi possível atualizar')));
                    }
                  },
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: Text(weather.temp.toString()+'°',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(weather.weather,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom:70),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text(weather.tempMin.toString() + '° / '+weather.tempMax.toString()+'°',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    weatherController.dispose();
    super.dispose();
  }
}