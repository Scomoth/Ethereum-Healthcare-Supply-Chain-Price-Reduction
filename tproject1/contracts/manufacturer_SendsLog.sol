// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract manufacturer_sendslog{
    address sender;
    uint batch_id;
    address postreceiver;
    bytes32 medicine_name;
    bytes32 medicine_type;
    uint medicine_price;
    uint logistics_price;
    uint expiry_daysleft;
    uint quantity;
    address paymentaddress = 0xB40AfbEC7f7E1bFe5D7Bbb4303466BA33Ce4fEd8;
    address receiver;
    bytes32 message;
    event manufacturer_to_distributor_transaction_initiated(
        address indexed sender,
        address indexed receiver,
        address postreceiver,
        uint batch_id,
        bytes32 medicine_name,
        bytes32 medicine_type,
        uint medicine_price,
        uint logistics_price,
        uint expiry_daysleft,
        uint quantity,
        address indexed paymentaddress
    );
    function SendLog(address producer, uint batchid, bytes32 medicinename, bytes32 medicinetype, uint medicineprice, uint logisticsprice,
    uint daysleft, uint amount, address distributor, address healthcareprovider) public {
        sender = producer;
        batch_id = batchid;
        medicine_name = medicinename;
        medicine_type = medicinetype;
        medicine_price = medicineprice;
        logistics_price = logisticsprice;
        expiry_daysleft = daysleft;
        quantity = amount;
        receiver = distributor;
        postreceiver = healthcareprovider;
        emit manufacturer_to_distributor_transaction_initiated(sender, receiver, postreceiver, batch_id, medicine_name, medicine_type, medicine_price, logistics_price,
        expiry_daysleft, quantity, paymentaddress);
    }
    function m2event() public view returns(address, address, address, uint, bytes32, bytes32, uint, uint, uint, uint, address) {
        return (sender, receiver, postreceiver, batch_id, medicine_name, medicine_type, medicine_price, logistics_price,
        expiry_daysleft, quantity, paymentaddress);
    }
}

