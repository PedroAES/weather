import React, { FormEvent, useEffect, useState } from 'react';

import api from '../services/api';
import '../styles/weather.css';
import getBgByWeatherId from '../utils';

function Weather() {

  function handleSubmit(event: FormEvent) {
    event.preventDefault();
    if (searchCityName.trim() !== '') {
      api.get(`weather?city=${searchCityName}`).then((res) => {
        const { id, cityName, temp, tempMax, tempMin, weather } = res.data;
        setBackgroundImageName(getBgByWeatherId(id));
        setCityName(cityName);
        setTemp(temp);
        setTempMax(tempMax);
        setTempMin(tempMin);
        setWeather(weather);
      });
      setSearchedCityName('');
    }
  }

  const [searchCityName, setSearchedCityName] = useState('');
  const [cityName, setCityName] = useState('');
  const [tempMin, setTempMin] = useState(0);
  const [tempMax, setTempMax] = useState(0);
  const [temp, setTemp] = useState(0);
  const [weather, setWeather] = useState('');
  const [backgroundImageName, setBackgroundImageName] = useState('');
  useEffect(() => {
    function initializeFromLocation() {
      navigator.geolocation.getCurrentPosition(function (position) {
        const { latitude, longitude } = position.coords;
        api.get(`weather?lat=${latitude}&lon=${longitude}`).then((res) => {
          const { id, cityName, temp, tempMax, tempMin, weather } = res.data;
          setBackgroundImageName(getBgByWeatherId(id));
          setCityName(cityName);
          setTemp(temp);
          setTempMax(tempMax);
          setTempMin(tempMin);
          setWeather(weather);
        });
      })
    }
    initializeFromLocation();
  }, []);

  return (
    <div id="background" style={{ backgroundImage: `url(${backgroundImageName})` }}>
      <div id="page-weather" >
        <main>
          <form onSubmit={handleSubmit}>
            <div className='form-field'>
              <input
                id="city_name"
                type="text"
                placeholder="Nome da Cidade"
                value={searchCityName}
                onChange={event => setSearchedCityName(event.target.value)}
              />
              <input className="submit " type="submit" value="Buscar" />
            </div>
          </form>
          <h1>{cityName}</h1>
          <h2>{temp}°</h2>
          <h3>{weather}</h3>
          <div className="min_max">
            <p>Mínima: {tempMin}°</p>
            <p>Máxima: {tempMax}°</p>
          </div>
        </main>
      </div>
    </div>
  )
}

export default Weather;