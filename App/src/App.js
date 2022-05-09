import React from 'react';
// eslint-disable-next-line
import ReactDOM from 'react-dom';
// eslint-disable-next-line
import AppCSS from './App.css';
// eslint-disable-next-line
import Blink from 'react-blink-text';
// eslint-disable-next-line
import options from './drizzleoptions';
// eslint-disable-next-line
import { Drizzle, generateStore } from "@drizzle/store";
// eslint-disable-next-line
import { DrizzleProvider } from "@drizzle/react-plugin";
// eslint-disable-next-line
import { drizzleConnect } from '@drizzle/react-plugin';
// eslint-disable-next-line
import {useEffect, useState} from 'react';
// eslint-disable-next-line
import Web3 from 'web3';
// eslint-disable-next-line
import { h1acc, h1abi } from './config';
// eslint-disable-next-line
import networkaccounts from './components';

// eslint-disable-next-line
import { AccountData, ContractData, ContractForm, LoadingContainer} from "@drizzle/react-components";


//import { hp1 }from "./hp1";
// eslint-disable-next-line
//Setup Drizzle Instance

//const drizzleStore = generateStore(options);
//const drizzle = new Drizzle(options, drizzleStore);

function App() {
// eslint-disable-next-line
  const [account, setAccount] = useState();
// eslint-disable-next-line
  const [contract, setContract] = useState();
// eslint-disable-next-line
  const [value, setValue] = useState();
  async function load() {
      // eslint-disable-next-line
    const web3 = new Web3(new Web3.providers.HttpProvider('https://127.0.0.1:8545'));
    const accounts = await web3.eth.getAccounts();
      // eslint-disable-next-line
    const iacc = '0x24879dFc8EAa4772dff425767D6ea506e807B5c0';
    setAccount(accounts[0]);
  }
/*     const contracts = new web3.eth.Contract(h1abi, h1acc);
      setContract(contracts);
      var iacc = '0x24879dFc8EAa4772dff425767D6ea506e807B5c0';
      var inum1 = 1;

      var istr1 = '0x000000000000000000000000000000000000000000004c6973696e6f7072696c';
      var istr2 = '0x0000000000000000000000000000000000000000000000005072696e6976696c';
      var inum2 = 180;
      var inum3 = 1;
      // eslint-disable-next-line
      var i1 = await contract.methods.TransactionRequest(iacc, inum1, istr1, istr2, inum2, inum3).send({from: h1acc, gas: 3000000});
      var r1 = await contract.methods.h1event1().call({from: h1acc, gas: 3000000});
      setValue(r1);
*/  



  return (
    <>
      <div className="MainContent">
        <div className="Intro">
          <div class="container">
            <div class="row">
              <div class="col-md-12 text-center">
              <h3 class="animate-charcter">-Healthcare Medicine Manufacturer Website-</h3>
              </div>
            </div>
          </div>
          <Blink color='white' text='IMPORTANT NOTE: WARNING!!! LOGISTICS PRICE IS ALSO INCLUDED TO BE PAYED BY CUSTOMER!!!' fontSize='770'></Blink>
        </div>
        <div className="ListContent">
          <div id="Med">
          <ul>
          <h1>-----MEDICINE DETAILS----- </h1>
            <li>
            <h2>  Medicine 1 </h2>
            <ol>
              <li>Medicine Name: Atorvastatin</li>
              <li>Medicine Type: Lipitor</li>
              <li>Medicine Price: 3</li>
              <li>Expiry Count(Days): 180</li>
            </ol>
            </li>
            <li>
            <h2>  Medicine 2 </h2>
            <ol>
              <li>Medicine Name: Amoxicillin</li>
              <li>Medicine Type: Amoxil</li>
              <li>Medicine Price: 2</li>
              <li>Expiry Count(Days): 180</li>
            </ol>
            </li>
            <li>
            <h2>  Medicine 3 </h2>
            <ol>
              <li>Medicine Name: Lisinopril</li>
              <li>Medicine Type: Prinivil</li>
              <li>Medicine Price: 1</li>
              <li>Expiry Count(Days): 180</li>
            </ol>
            </li>
          </ul>
          </div>
        </div>
      </div>
      <div>
        <p>Use the following contract address to process request: 0x24879dFc8EAa4772dff425767D6ea506e807B5c0</p>
        <p>Format of request is: ("Address Given Above","Medicine Price", "Medicine Name in bytes32 format","Medicine Type in bytes32 format","Expiry Days","Quantity in format of batches")</p>
        <p>Manufacturer Account Address: 0xA9e0ed8bAA6acfbE4293648a46b5d23Ad2F0D22B</p>

      </div>
    </>
  );
}

export default App;
