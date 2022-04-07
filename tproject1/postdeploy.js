module.exports = async(callback) => {
var Web3 = require('web3');
var web3 = new Web3('http://127.0.0.1:7545');
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
var m1acc = '';
var m2acc = '0x193E8317244898c6F9db12A68B01166788823083';
var m3acc = '';
var d1acc = '';
var h1acc = '';
var h2acc = '';
//Creating smart contract instances
var m1contract = new web3.eth.Contract(m1contractabi, m1acc);
var m2contract = new web3.eth.Contract(m2contractabi, m2acc);
var m3contract = new web3.eth.Contract(m3contractabi, m3acc);
var d1contract = new web3.eth.Contract(d1contractabi, d1acc);
var h1contract = new web3.eth.Contract(h1contractabi, h1acc);
var h2contract = new web3.eth.Contract(h2contractabi, h2acc);
//First Smart Contract Invocation
var acc1 = '0xA9e0ed8bAA6acfbE4293648a46b5d23Ad2F0D22B';
var acc2 = '0x3D6e946f209B3cd44FFb97A70c4D7FB982d75E1D';
var acc3 = '0x8f78EcF8129434802481650032dB4242f049FEFc';
var str1 = '0x0000000000000000000000000000000000000000000000000000000000000042';
var str2 = '0x0000000000000000000000000000000000000000000000000000000000000042';
await m2contract.methods.SendLog(acc1,0,str1,str2,1,1,1,1,acc2,acc3).send({from: acc1, gas: 3000000});
var r1 = await m2contract.methods.m2event().call({from: acc1, gas: 3000000});
//Second Smart Contract Invocation
await d1contract.methods.SendLog(acc2,0,str1,str2,1,1,1,1,acc2,acc3).send({from: acc1, gas: 3000000});
var r2 = await d1contract.methods.d1event().call({from: acc1, gas: 3000000});
//Third Smart Contract Invocation
await m2contract.methods.SendLog(acc1,0,str1,str2,1,1,1,1,acc2,acc3).send({from: acc1, gas: 3000000});
var r3 = await h1contract.methods.h1event().call({from: acc1, gas: 3000000});
//Fourth Smart Contract Invocation
//Fifth Smart Contract Invocation
//Sixth Smart Contract Invocation

/*m2contract.events.manufacturer_to_distributor_transaction({filter: {sender: acc1, receiver: acc2}})
}, function(error, event){ console.log(event); })
.on('data', function(event){ console.log(event); })
console.log(r2);
*/
//m2contract.events.manufacturer_to_distributor_transaction({filter: {sender: acc1, receiver: acc2}, fromBlock: 0, toBlock: 'latest'}, function(error, event){ console.log(event); }).on('data', function(event){ console.log(event); })

//m2contract.events.allEvents();
callback(r1);
}

