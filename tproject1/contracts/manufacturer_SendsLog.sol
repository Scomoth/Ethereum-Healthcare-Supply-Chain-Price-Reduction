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
    address paymentaddress;//m3address
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
    function SendLog(address _producer, uint _batchid, bytes32 _medicinename, bytes32 _medicinetype, uint _medicineprice, uint _logisticsprice,
    uint _daysleft, uint _amount, address _distributor, address _healthcareprovider) public {
        sender = _producer;
        batch_id = _batchid;
        medicine_name = _medicinename;
        medicine_type = _medicinetype;
        medicine_price = _medicineprice;
        logistics_price = _logisticsprice;
        expiry_daysleft = _daysleft;
        quantity = _amount;
        receiver = _distributor;
        postreceiver = _healthcareprovider;
        emit manufacturer_to_distributor_transaction_initiated(sender, receiver, postreceiver, batch_id, medicine_name, medicine_type, medicine_price, logistics_price,
        expiry_daysleft, quantity, paymentaddress);
    }
    function set_contract_address(address _m3address) public {
        paymentaddress = _m3address;
    }
    function m2event() public view returns(address, address, address, uint, bytes32, bytes32, uint, uint, uint, uint, address) {
        return (sender, receiver, postreceiver, batch_id, medicine_name, medicine_type, medicine_price, logistics_price,
        expiry_daysleft, quantity, paymentaddress);
    }
}

