// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract healthcareprovider_receiveslog{
    address sender;
    address receiver;
    uint batch_id;
    bytes32 medicine_name;
    bytes32 medicine_type;
    uint total_price;
    uint expiry_daysleft;
    uint quantity;
    address payment_address;
    event distributor_to_healthcareprovider_transaction_received(
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
        uint batch_id,
        uint total_price    
    );
    function ReceivesLog(
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
        batch_id = batchid;
        medicine_name = medicinename;
        medicine_type = medicinetype;
        total_price = medicineprice + logisticsprice;
        expiry_daysleft = daysleft;
        quantity = amount;
        payment_address = paymentaddress;
        emit distributor_to_healthcareprovider_transaction_received(sender, receiver, batch_id, medicine_name, medicine_type, 
        total_price, expiry_daysleft, quantity, payment_address);
        //emit Transaction_Request(sender, paymentaddress, batch_id, total_price);
    }  
    function transaction() public {
        require(getBalance()>=total_price,"Not Enough Ether.");
        emit Transaction_payment_initiated(sender, payment_address, batch_id, total_price);
        payable(payment_address).transfer(total_price);
    }
    function h2event() public view returns(address, address, uint, uint) {
        return (sender, payment_address, batch_id, total_price);
    }
    function getBalance() public view returns(uint) {
        return receiver.balance;
    }
}

