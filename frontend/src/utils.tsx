import atmosphere from './images/atmosphere.jpg';
import clear from './images/clear.jpg';
import clouds from './images/clouds.jpg';
import rain from './images/rain.jpg';
import snow from './images/snow.jpg';
import thunderstorm from './images/thunderstorm.jpg';

export default function getBgByWeatherId(weatherId: Number) {
  if (weatherId > 800)
    return clouds;
  if (weatherId === 800)
    return clear;
  if (weatherId > 700)
    return atmosphere;
  if (weatherId > 600)
    return snow;
  if (weatherId > 300)
    return rain;
  if (weatherId > 200)
    return thunderstorm;

  return 'default';
}