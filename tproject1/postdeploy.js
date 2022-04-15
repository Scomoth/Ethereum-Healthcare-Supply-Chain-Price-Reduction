module.exports = async(callback) => {
var Web3 = require('web3');
var web3 = new Web3('http://127.0.0.1:8545');
//Importing JSON files
var m1contractabi = require('./build/contracts/manufacturer_pricenegotiator.json');
var m2contractabi = require('./build/contracts/manufacturer_sendslog.json');
var m3contractabi = require('./build/contracts/manufacturer_receivespayment.json');
var d1contractabi = require('./build/contracts/distributor_SendsAndReceivesLog.json');
var h1contractabi = require('./build/contracts/healthcareprovider_pricenegotiator.json');
var h2contractabi = require('./build/contracts/healthcareprovider_receiveslog.json');
//Extracting abi from JSON files
m1contractabi = m1contractabi.abi;
m2contractabi = m2contractabi.abi;
m3contractabi = m3contractabi.abi;
d1contractabi = d1contractabi.abi;
h1contractabi = h1contractabi.abi;
h2contractabi = h2contractabi.abi;
//Assigning deploying smart contract addresses
var m1acc = '0x5b4429C96a01152dbeB601A0B037adc43548E302';
var m2acc = '0x7C7850421F5fab44aA9170303537Cb99F27C4779';
var m3acc = '0xE9E7e3EA1307Fba345a3488851bCD8Ae651272E6';
var d1acc = '0x40aEB0DeE4851D6fB37250137EA147a99fFB1376';
var h1acc = '0x085E9F0473771428fA5847C627bB062ce8aDecBE';
var h2acc = '0xAb4091329A98243218f3100D710dbD4d9F21cFC4';
//Creating smart contract instances
var m1contract = new web3.eth.Contract(m1contractabi, m1acc);
var m2contract = new web3.eth.Contract(m2contractabi, m2acc);
var m3contract = new web3.eth.Contract(m3contractabi, m3acc);
var d1contract = new web3.eth.Contract(d1contractabi, d1acc);
var h1contract = new web3.eth.Contract(h1contractabi, h1acc);
var h2contract = new web3.eth.Contract(h2contractabi, h2acc);
//Basic Values Assignment
var acc1 = '0xA9e0ed8bAA6acfbE4293648a46b5d23Ad2F0D22B';//manufacturer account address
var acc2 = '0x3D6e946f209B3cd44FFb97A70c4D7FB982d75E1D';//distributor account address
var acc3 = '0x8f78EcF8129434802481650032dB4242f049FEFc';//healthcareprovider account address
await h1contract.methods.set_contract_address(h1acc).send({from: acc3, gas: 3000000});
await m2contract.methods.set_contract_address(m3acc).send({from: acc1, gas: 3000000});
//First Smart Contract Invocation Initiation
var yes = "Y";
var iacc = '0x24879dFc8EAa4772dff425767D6ea506e807B5c0';
var inum1 = 1;
var istr1 = '0x000000000000000000000000000000000000000000004c6973696e6f7072696c';
var istr2 = '0x0000000000000000000000000000000000000000000000005072696e6976696c';
var inum2 = 180;
var inum3 = 1;
await h1contract.methods.TransactionRequest(iacc, inum1, istr1, istr2, inum2, inum3).send({from: acc3, gas: 3000000});
var r1 = await h1contract.methods.h1event1().call({from: acc3, gas: 3000000});
//Second Smart Contract Invocation Initiation
await m1contract.methods.MPriceNegotiation(r1[0],r1[1],r1[2],r1[3],r1[4],r1[5],r1[6],r1[7]).send({from: acc3, gas: 3000000});
var i1 = await m1contract.methods.getAck().call({from: acc1, gas: 3000000});
/*if (String(i1[0]) == String(yes)) {
    callback("Supply Chain Transaction Executed");
}*/

(String(i1[0]) != String(yes)) ? callback("Supply Chain Transaction Interrupted") : "Transaction Acknowledged";
var i2 = await m1contract.methods.m1event1().call({from: acc1, gas: 3000000});
await h1contract.methods.HPriceNegotiation(i2[0],i2[1]).send({from: acc1, gas: 3000000});
var r2 = await m1contract.methods.m1event2().call({from: acc1, gas: 3000000});
//Third Smart Contract Invocation
await m2contract.methods.SendLog(r2[0],r2[1],r2[2],r2[3],r2[4],r2[5],r2[6],r2[7],r2[8],r2[9]).send({from: acc1, gas: 3000000});
var r3 = await m2contract.methods.m2event().call({from: acc1, gas: 3000000});
//Fourth Smart Contract Invocation
await d1contract.methods.DReceivesLog(r3[0],r3[1],r3[2],r3[3],r3[4],r3[5],r3[6],r3[7],r3[8],r3[9],r3[10]).send({from: acc1, gas: 3000000});
var r4 = await d1contract.methods.d1event().call({from: acc2, gas: 3000000});
//Fifth Smart Contract Invocation
await h2contract.methods.ReceivesLog(r4[0],r4[1],r4[2],r4[3],r4[4],r4[5],r4[6],r4[7],r4[8],r4[9], r4[10]).send({from: acc2, gas: 3000000});
await h2contract.methods.transaction().send({from: acc3, gas: 3000000}); 
var r5 = await h2contract.methods.h2event().call({from: acc3, gas: 3000000});
//Sixth Smart Contract Invocation
var weiValue = Web3.utils.toWei(r5[4], 'ether');
await m3contract.methods.Receives_Payment(r5[0],r5[1],r5[2],r5[3],r5[4]).send({from: acc3, gas: 3000000, value: weiValue});
//}
/*else if (String(i1[0]) != String(yes)) {
    var i2 = await m1contract.methods.m1event1().call({from: acc1, gas: 3000000});
    await h1contract.methods.HPriceNegotiation(i2[0],i2[1]).send({from: acc1, gas: 3000000});
}*/

/*m2contract.events.manufacturer_to_distributor_transaction({filter: {sender: acc1, receiver: acc2}})
}, function(error, event){ console.log(event); })
.on('data', function(event){ console.log(event); })
console.log(r2);
*/
//m2contract.events.manufacturer_to_distributor_transaction({filter: {sender: acc1, receiver: acc2}, fromBlock: 0, toBlock: 'latest'}, function(error, event){ console.log(event); }).on('data', function(event){ console.log(event); })

//m2contract.events.allEvents();
callback("Supply Chain Transaction Executed");
}

