// eslint-disable-next-line
import React from 'react'
import Web3 from 'web3';
async function networkaccounts() {
    const web3 = new Web3(new Web3.providers.HttpProvider('https://127.0.0.1:8545'));
    const accounts = await web3.eth.getAccounts();
    console.log(accounts);
    return (
        <>{accounts[0]}</>
    )
}
export default networkaccounts;