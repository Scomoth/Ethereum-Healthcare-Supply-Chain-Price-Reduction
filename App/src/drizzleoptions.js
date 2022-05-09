import h1 from './artifacts/healthcareprovider_pricenegotiator.json';
const options = {
    contracts: [h1],
    web3: {
        fallback: {
            type: "ws",
            url: "ws://127.0.0.1:8545",
        },
    }
};
export default options;