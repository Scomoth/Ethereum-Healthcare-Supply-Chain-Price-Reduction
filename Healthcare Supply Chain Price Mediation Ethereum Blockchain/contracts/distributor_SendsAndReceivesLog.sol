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
    event distributor_received_med_message (
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
        address producer,
        address distributor,
        address healthcareprovider,
        uint batchid,
        bytes32 medicinename,
        bytes32 medicinetype,
        uint medicineprice,
        uint logisticsprice,
        uint daysleft,
        uint amount,
        address paymentaddress
    ) public {
        sender = distributor;
        receiver = healthcareprovider;
        presender = producer;
        batch_id = batchid;
        medicine_name = medicinename;
        medicine_type = medicinetype;
        medicine_price = medicineprice;
        logistics_price = logisticsprice;
        expiry_daysleft = daysleft;
        quantity = amount;
        payment_address = paymentaddress;
        emit distributor_received_med_message(sender, receiver, batch_id, medicine_name, medicine_type, medicine_price, logistics_price, expiry_daysleft, quantity, payment_address);
    }
}