const NodeCache = require('node-cache');

const getWeather = require('../services/weather_api');
const normalizeString = require('../utils');

const cache = new NodeCache();

exports.getWeather = async (req, res) => {
    const {city, lat, lon} = req.query;
    if(city){
        const normalizedCity = normalizeString(city);
        if(cache.has(normalizedCity)){
            res.status(200).send(cache.get(normalizedCity));
        }
        else{
            getWeather('q='+normalizedCity).then(response=>{
                if(response.status === 200)
                    cache.set(normalizedCity, response.body, 60*15);
                res.status(200).send(response.body);
            }).catch(error => {
                res.status(500).send({error});
            });
        }
    }
    
    else if(lat && lon){
        getWeather('lat='+lat+'&lon='+lon).then(response=>{
            if(response.status === 200)
                cache.set(normalizeString(response.body.cityName), response.body, 60*15);
            res.status(200).send(response.body);
        }).catch(error => {
            res.status(500).send({error});
        });
    }
    else
        res.status(400).send({message: "You must provide city name or latitude and longitude"});
}