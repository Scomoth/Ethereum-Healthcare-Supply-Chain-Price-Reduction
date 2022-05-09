//Importing necessary external files/modules
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
  // eslint-disable-next-line
import hp from './artifacts/healthcareprovider_pricenegotiator.json';
//import { drizzleConnect } from '@drizzle/react-plugin'
//import h1 from './artifacts/healthcareprovider_pricenegotiator.json';

const root = ReactDOM.createRoot(document.getElementById('root'));

/*const mapStateToProps = state => {
  return {
    drizzleStatus: state.drizzleStatus,
    [h1] : state.contracts.SimpleStorage
  }
}

const HomeContainer = drizzleConnect(root, mapStateToProps);*/
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
/*root.render(
  <React.StrictMode>
    <Drizz />
  </React.StrictMode>
);
*/

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
