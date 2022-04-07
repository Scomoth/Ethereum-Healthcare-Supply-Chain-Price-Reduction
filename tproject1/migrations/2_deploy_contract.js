//var web3G = new Web3('http://127.0.0.1:7545');
//accounts = web3.eth.getAccounts();

const h1 = artifacts.require("healthcareprovider_PriceNegotiator");
const m1 = artifacts.require("manufacturer_PriceNegotiator");
const m2 = artifacts.require("manufacturer_SendsLog");
const d1 = artifacts.require("distributor_SendsAndReceivesLog");
const h2 = artifacts.require("healthcareprovider_ReceivesLog");
const m3 = artifacts.require("manufacturer_ReceivesPayment");


module.exports = async function(deployer) {
    /*let fp1 = await deployer.deploy(h1, );
    let fp2 = await deployer.deploy(m1, fp1);
    let fp3 = await deployer.deploy(m2, fp2);
    let fp4 = await deployer.deploy(d1, fp3);
    let fp5 = await deployer.deploy(h2, fp4);
    deployer.deploy(m3, fp5);
    */
    deployer.deploy(h1);
    deployer.deploy(m1);
    deployer.deploy(m2);
    deployer.deploy(d1);
    deployer.deploy(h2);
    deployer.deploy(m3);
};
