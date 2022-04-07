// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract healthcareprovider_pricenegotiator{
    enum statuses {
        NONE, 
        ACTIVE 
    }
    statuses status = statuses.NONE;
    address healthcareprovider = 0x8f78EcF8129434802481650032dB4242f049FEFc;
    address public sender = 0xD7cd9550327CA67a7b4983F33655Fa4A3b89ACde;
    address public receiver;
    uint public medicine_price;
    bytes32 public medicine_name;
    bytes32 public medicine_type;
    uint public expiry_daysleft;
    uint public quantity;
    string ack = "NO";
    string message;
    event Transaction_Request_Initiated(
        address indexed sender,
        address indexed receiver,
        address indexed healthcareprovider,
        uint medicine_price,
        bytes32 medicine_name,
        bytes32 medicine_type,
        uint expiry_daysleft,
        uint quantity
    );
    event TransactionAcceptanceReceived(
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
            emit TransactionAcceptanceReceived(sender, receiver, medicine_price, status, message);
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
        emit Transaction_Request_Initiated(sender, receiver, healthcareprovider, medicine_price, medicine_name, medicine_type, expiry_daysleft, quantity);
    }
    function h1event1() public view returns(address, address, address, uint, bytes32, bytes32, uint, uint) {
        return (sender, receiver, healthcareprovider, medicine_price, medicine_name, medicine_type, expiry_daysleft, quantity);
    }
    function h2event2() public view returns(address, address, uint, statuses, string memory) {
        return (sender, receiver, medicine_price, status, message);
    }
}