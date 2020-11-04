import {BrowserRouter, Switch, Route} from 'react-router-dom';
import React from 'react';

import Weather from './pages/weather';

function Routes(){
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" component={Weather}/>
      </Switch>
    </BrowserRouter>
  )
}

export default Routes;