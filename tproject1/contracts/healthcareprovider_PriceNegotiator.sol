// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract healthcareprovider_pricenegotiator{
    enum statuses {
        NONE, 
        ACTIVE 
    }
    statuses status = statuses.NONE;
    address healthcareprovider = 0x8f78EcF8129434802481650032dB4242f049FEFc; //healthcareprovider address
    address public sender;//h1address
    address public receiver;//m1address
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
        } else if (keccak256(bytes(ack)) != keccak256(bytes("YES"))) {
            status = statuses.NONE;
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
    function set_contract_address(address _h1address) public {
        sender = _h1address;
    }
    function h1event1() public view returns(address, address, address, uint, bytes32, bytes32, uint, uint) {
        return (sender, receiver, healthcareprovider, medicine_price, medicine_name, medicine_type, expiry_daysleft, quantity);
    }
    function h2event2() public view returns(address, address, uint, statuses, string memory) {
        return (sender, receiver, medicine_price, status, message);
    }
}