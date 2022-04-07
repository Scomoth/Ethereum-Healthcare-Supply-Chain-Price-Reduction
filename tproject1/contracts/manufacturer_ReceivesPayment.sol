// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract manufacturer_receivespayment {
    address sender;
    address receiver;
    string message;
    uint batch_id;
    uint total_price;
    event transaction_concluded (
        address indexed sender,
        address indexed receiver,
        uint batch_id,
        string message
    );
    modifier PriceVerification(uint _totalprice) {
        require(msg.value >= _totalprice, "Not Enough Ether. Transaction Rejected.");
        _;
    }
    function Receives_Payment(
        address healthcareprovider,
        address producer,
        uint batchid,
        uint totalprice
    ) public {
        sender = healthcareprovider;
        receiver = producer;
        batch_id = batchid;
        total_price = totalprice;
    }
    receive() external payable PriceVerification (total_price) {
        message = "Transaction Accepted. Medicine Batch will be supplied.";
        emit transaction_concluded(sender, receiver, batch_id, message);
    }
}