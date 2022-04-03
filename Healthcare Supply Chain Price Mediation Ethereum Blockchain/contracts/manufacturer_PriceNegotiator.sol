// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
contract manufacturer_pricenegotiator{
    address presender;
    address sender;
    address receiver;
    address producer = 0xEE543FBAcAa3C22F9119B21cFe9514a0123e4d70;
    address healthcareprovider;
    address distributor;
    uint medicine_price;
    uint lprice;
    bytes32 medicine_name;
    bytes32 medicine_type;
    uint expiry_daysleft;
    uint quantity;
    uint temp = 0;
    string aval;
    string ack = "NO";
    uint i = 0;
    uint j = 0;
    uint no_of_medicines = 3;
    uint batch_id = 0;
    struct medicine_batch {
        uint med_price; 
        bytes32 med_name;
        bytes32 med_type;
        uint remainingdays;
    }
    mapping(uint => medicine_batch) public med_id;
    //mapping(uint => mapping(uint => uint)) public logistics_price; 
    //mapping(uint => address) public distributor_address; 
    //mapping(uint => address) public healthcareprovider_address;
    uint[][] public logistics_prices = [ [30,50], [50,30] ]; // 2 distributors and 2 healthcareproviders
    address[] public distributor_addresses = [0xC8aE7A1CAfD786D2C801B480700914c0990b4778, 0xc69e7497F020f26Ba083165021A87D88102fFCbB]; //modify addresses later on
    address[] public healthcareprovider_addresses = [0x5D96b7549Fa9008ad0B418F8c32aD171a9297A99, 0xc1F7691415D8170A2A435328Fb4b895D13426cC8]; // modify addresses later on
    event send_to_manufacturer (
        address producer,
        uint batch_id,
        bytes32 medicine_name,
        bytes32 medicine_type,
        uint medicine_price,
        uint lprice,
        uint expiry_daysleft,
        uint quantity,
        address distributor,
        address healthcareprovider
    );
    event healthcareprovider_acknowledgement (
        string ack,
        uint medicine_price
    );
    function MPriceNegotiation(address healthcareprovider_negotiatoraddress, address manufacturer_negotiatoraddress, address healthcareprovider_address, uint medicineprice, bytes32 medicinename, bytes32 medicinetype, 
    uint daysleft, uint amount) public {
        med_id[0] = medicine_batch({med_price : 3, med_name : "Atorvastatin", med_type : "Lipitor", remainingdays : 180}); 
        med_id[1] = medicine_batch({med_price : 2, med_name : "Amoxicillin", med_type : "Amoxil", remainingdays : 180});
        med_id[2] = medicine_batch({med_price : 1, med_name : "Lisinopril", med_type : "Prinivil", remainingdays : 180});
        presender = healthcareprovider_negotiatoraddress;
        sender = manufacturer_negotiatoraddress;
        healthcareprovider = healthcareprovider_address;
        medicine_price = medicineprice;
        medicine_name = medicinename;
        medicine_type = medicinetype;
        expiry_daysleft = daysleft;
        quantity = amount;
        ack = "NO";
        aval = Medicine_Availability();
        lprice = LogisticsPrice();
        temp = i;
        i=0;
        require(keccak256(bytes(aval)) == keccak256(bytes("YES")));
        require(lprice != 0.0);
        distributor = distributor_addresses[i];
        i = 0;
        j = 0;
        if(medicine_price >= med_id[temp].med_price){
            batch_id = BatchID();
            emit healthcareprovider_acknowledgement(ack, medicine_price);
            emit send_to_manufacturer(producer, batch_id, medicine_name, medicine_type, medicine_price, lprice, expiry_daysleft,
            quantity, distributor, healthcareprovider);
            temp = 0;
        } else if (medicine_price < med_id[temp].med_price) {
            ack="NO";
            emit healthcareprovider_acknowledgement(ack, med_id[temp].med_price);
            temp = 0;           
        }
    }
    modifier Medicine_Verification {
        temp = 0;
        i = no_of_medicines;
        while (i != 0) {
            if (med_id[i].med_name == medicine_name){
                temp = 0.0;
            } 
        }
        require(temp == 0.0, "Medicine Not Found");
        _;
    }
    function Medicine_Availability() public Medicine_Verification returns (string memory ack_return) {
        ack_return = "YES";
        return ack;    
    }
    function BatchID() public returns (uint id) {
        batch_id=batch_id+1;
        return id;
    }
    function LogisticsPrice() public returns (uint logprice) {
        temp = 0;
        j = 0;
        while(j<2) {
            if (healthcareprovider == healthcareprovider_addresses[j]){
                while(i<2) {
                    temp = logistics_prices[i][j];

                    if (logistics_prices[i][j] >= temp) {
                        return logistics_prices[i][j];
                    } else if (logistics_prices[i][j] < temp) {
                        temp = logistics_prices[i][j];
                    }
                    i=i+1;
                }
            }
            j=j+1;
        }
        i = 0;
        j = 0;
        temp = 0.0;
        return temp;
    }
}