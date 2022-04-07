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
    uint temp1 = 0;
    string aval;
    string ack = "NO";
    uint i = 0;
    uint j = 0;
    uint k = 0;
    uint mp;
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
    address[] public distributor_addresses = [0x3D6e946f209B3cd44FFb97A70c4D7FB982d75E1D, 0xD63779a8CaB68c5B8bA71b0eDc5547bFAc749c22]; //modify addresses later on
    address[] public healthcareprovider_addresses = [0x8f78EcF8129434802481650032dB4242f049FEFc, 0x669E53B7a7A18b828764cc193b73119BBe3ee599]; // modify addresses later on
    event transaction_initiation_request (
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
    event healthcareprovider_transaction_request_reply (
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
        temp = k;
        i=0;
        require(keccak256(bytes(aval)) == keccak256(bytes("YES")));
        require(lprice != 0);
        distributor = distributor_addresses[i];
        i = 0;
        j = 0;
        if(medicine_price >= med_id[temp].med_price){
            batch_id = BatchID();
            mp = medicine_price;
            emit healthcareprovider_transaction_request_reply(ack, medicine_price);
            emit transaction_initiation_request(producer, batch_id, medicine_name, medicine_type, medicine_price, lprice, expiry_daysleft,
            quantity, distributor, healthcareprovider);
        } else if (medicine_price < med_id[temp].med_price) {
            ack="NO";
            mp = med_id[temp].med_price;
            emit healthcareprovider_transaction_request_reply(ack, med_id[temp].med_price);           
        }
        temp = 0;
        temp1 = 0;
        i = 0;
        j = 0;
        k = 0;
    }
    modifier Medicine_Verification {
        temp = 0;
        k = no_of_medicines-1;
        while (k != 0) {
            if (med_id[i].med_name == medicine_name){
                temp = 0.0;
            }
            k=k-1; 
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
        temp1 = 0;
        j = 0;
        while(j<2) {
            if (healthcareprovider == healthcareprovider_addresses[j]){
                temp1 = 0.0;
                while(i<2) {
                    temp = logistics_prices[i][j];

                    if (logistics_prices[i][j] >= temp) {
                        logistics_prices[i][j] = logistics_prices[i][j];
                    } else if (logistics_prices[i][j] < temp) {
                        temp = logistics_prices[i][j];
                    }
                    i=i+1;
                }
            }
            else if (healthcareprovider != healthcareprovider_addresses[j]){
                j=j+1;
            } 
        }
        i = 0;
        j = 0;
        return temp;
    }
    function m1event1() public view returns(string memory, uint) {
        return (ack, mp);
    }
    function m2event() public view returns(address, uint, bytes32, bytes32, uint, uint, uint, uint, address, address) {
        return (producer, batch_id, medicine_name, medicine_type, medicine_price, lprice, expiry_daysleft, quantity, distributor, healthcareprovider);
    }
}