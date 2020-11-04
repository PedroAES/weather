const axios = require('axios');

const mountURL = (params)=>{
    return 'http://api.openweathermap.org/data/2.5/weather?'
        +params+
        '&lang=pt_br' +
        '&units=metric' +
        '&appid=60f11a2c19edf807e6767f6b6a4c52b1'
}

module.exports = async function (params){
    try{
        const response = await axios.get(mountURL(params)) 
        const data = response.data;
        if(data.cod === 200){
            const cityName = data.name;
            const {id, description: weather} = data.weather[0];
            const {temp_max: tempMax, temp_min: tempMin, temp} = data.main;
            
            const resBody = {
                id,
                cityName,
                weather,
                temp,
                tempMax,
                tempMin
            }
            
            return {
                status: data.cod,
                body: resBody
            };

        }
    } catch(error){
        return {
            status: 404,
            body: error
        };
    }
   
}