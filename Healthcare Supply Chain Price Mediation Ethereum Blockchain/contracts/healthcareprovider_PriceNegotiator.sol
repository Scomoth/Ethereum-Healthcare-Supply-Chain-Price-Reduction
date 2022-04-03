// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract healthcareprovider_pricenegotiator{
    enum statuses {
        NONE, 
        ACTIVE 
    }
    statuses status = statuses.NONE;
    address healthcareprovider_address = 0xee8318A534F55E27D8d4B6bD6047a34bE888dAD4;
    address sender = msg.sender;
    address public receiver;
    uint public medicine_price;
    bytes32 public medicine_name;
    bytes32 public medicine_type;
    uint public expiry_daysleft;
    uint public quantity;
    string ack = "NO";
    string message;
    event Transaction_Request(
        address indexed sender,
        address indexed receiver,
        address indexed healthcareprovider_address,
        uint medicine_price,
        bytes32 medicine_name,
        bytes32 medicine_type,
        uint expiry_daysleft,
        uint quantity
    );
    event TransactionAcceptance(
        address indexed sender,
        address indexed receiver,
        uint medicine_price,
        statuses status,
        string message
    );
    function HPriceNegotiation(string memory acknowledgement, uint price) public {
        ack = acknowledgement;
        medicine_price = price;
        if (keccak256(bytes(ack)) == keccak256(bytes("YES"))) {
            status = statuses.ACTIVE;
            message = "Transaction Mutually Acknowledged.";
            emit TransactionAcceptance(sender, receiver, medicine_price, status, message);
            status = statuses.NONE;
        } else if (keccak256(bytes(ack)) != keccak256(bytes("YES"))) {
            ack = "NO";
        }
    }
    function TransactionRequest(address manufacturer_negotiatoraddress, uint medicineprice, bytes32 medicinename, bytes32 medicinetype,
    uint daysleft, uint amount) public {
        receiver = manufacturer_negotiatoraddress;
        medicine_price = medicineprice;
        medicine_name = medicinename;
        medicine_type = medicinetype;
        expiry_daysleft = daysleft;
        quantity = amount;
        emit Transaction_Request(sender, receiver, healthcareprovider_address, medicine_price, medicine_name, medicine_type, expiry_daysleft, quantity);
    }
}