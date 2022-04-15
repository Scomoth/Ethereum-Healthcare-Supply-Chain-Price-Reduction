// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract distributor_SendsAndReceivesLog{
    address sender;
    address receiver;
    address presender;
    uint batch_id;
    bytes32 medicine_name;
    bytes32 medicine_type;
    uint medicine_price;
    uint logistics_price;
    uint expiry_daysleft;
    uint quantity;
    address payment_address;
    event manufacturer_to_distributor_transaction_received(
        address presender,
        address indexed sender,
        address indexed receiver,
        uint batch_id,
        bytes32 medicine_name,
        bytes32 medicine_type,
        uint medicine_price,
        uint logistics_price,
        uint expiry_daysleft,
        uint quantity,
        address indexed payment_address
    );
    function DReceivesLog(
        address _producer,
        address _distributor,
        address _healthcareprovider,
        uint _batchid,
        bytes32 _medicinename,
        bytes32 _medicinetype,
        uint _medicineprice,
        uint _logisticsprice,
        uint _daysleft,
        uint _amount,
        address _paymentaddress
    ) public {
        sender = _distributor;
        receiver = _healthcareprovider;
        presender = _producer;
        batch_id = _batchid;
        medicine_name = _medicinename;
        medicine_type = _medicinetype;
        medicine_price = _medicineprice;
        logistics_price = _logisticsprice;
        expiry_daysleft = _daysleft;
        quantity = _amount;
        payment_address = _paymentaddress;
        emit manufacturer_to_distributor_transaction_received(presender, sender, receiver, batch_id, medicine_name, medicine_type, medicine_price, logistics_price, expiry_daysleft, quantity, payment_address);
    }
    function d1event() public view returns (address, address, address, uint, bytes32, bytes32, uint, uint, uint, uint, address) {
        return (presender, sender, receiver, batch_id, medicine_name, medicine_type, medicine_price, logistics_price, expiry_daysleft, quantity, payment_address);
    }
}