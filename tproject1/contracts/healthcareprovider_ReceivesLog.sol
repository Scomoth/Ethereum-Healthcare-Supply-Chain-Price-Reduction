// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract healthcareprovider_receiveslog{
    address sender;
    address receiver;
    address presender;
    uint batch_id;
    bytes32 medicine_name;
    bytes32 medicine_type;
    uint total_price;
    uint expiry_daysleft;
    uint quantity;
    address payment_address;
    event distributor_to_healthcareprovider_transaction_received(
        address presender,
        address indexed sender,
        address indexed receiver,
        uint batch_id,
        bytes32 medicine_name,
        bytes32 medicine_type,
        uint total_price,
        uint expiry_daysleft,
        uint quantity,
        address indexed payment_address
    );
    event Transaction_payment_initiated(
        address receiver,
        address indexed payment_address,
        address presender,
        uint batch_id,
        uint total_price    
    );
    function ReceivesLog(
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
        presender = _producer;
        receiver = _distributor;
        sender = _healthcareprovider;
        batch_id = _batchid;
        medicine_name = _medicinename;
        medicine_type = _medicinetype;
        total_price = _medicineprice + _logisticsprice;
        total_price = total_price * _amount;
        expiry_daysleft = _daysleft;
        quantity = _amount;
        payment_address = _paymentaddress;
        emit distributor_to_healthcareprovider_transaction_received(presender, sender, receiver, batch_id, medicine_name, medicine_type, 
        total_price, expiry_daysleft, quantity, payment_address);

        //emit Transaction_Request(sender, paymentaddress, batch_id, total_price);
    }  
    function transaction() public {
        emit Transaction_payment_initiated(sender, payment_address, presender, batch_id, total_price);
    }
    function h2event() public view returns(address, address, address, uint, uint) {
        return (sender, payment_address, presender, batch_id, total_price);
    }
}

