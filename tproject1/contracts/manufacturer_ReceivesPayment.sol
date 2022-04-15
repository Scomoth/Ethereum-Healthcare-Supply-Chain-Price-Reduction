// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract manufacturer_receivespayment {
    address sender;
    address payable receiver;
    string message;
    uint batch_id;
    uint total_price;
    address paymentaddress;
    event transaction_concluded (
        address indexed sender,
        address indexed receiver,
        uint batch_id,
        string message
    );
    function Receives_Payment(
        address _healthcareprovider,
        address _payment_address,
        address payable _producer,
        uint _batchid,
        uint _totalprice
    ) payable external {
        sender = _healthcareprovider;
        paymentaddress = _payment_address;
        receiver = _producer;
        batch_id = _batchid;
        total_price = _totalprice;
        message = "Transaction Accepted. Medicine Batch will be supplied.";
        emit transaction_concluded(sender, receiver, batch_id, message);
        receiver.transfer(msg.value);
    }
}