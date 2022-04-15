// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
contract manufacturer_pricenegotiator{
    address presender;
    address sender;
    address receiver;
    address producer = 0xA9e0ed8bAA6acfbE4293648a46b5d23Ad2F0D22B;//manufacturer address
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
    uint temp2 = 0;
    string aval;
    string ack = "NO";
    uint i = 0;
    uint j = 0;
    uint k = 0;
    uint mp;
    uint no_of_medicines = 3;
    uint batch_id = 0;
    string yes = "YES";
    string no = "NO";
    uint index = 0;
    uint[3] public med_price = [3, 2, 1];
    bytes32[3] public med_name = [bytes32(0x000000000000000000000000000000000000000041746f72766173746174696e), bytes32(0x000000000000000000000000000000000000000041746f72766173746174696e), bytes32(0x000000000000000000000000000000000000000000004c6973696e6f7072696c)];
    bytes32[3] public med_type = [bytes32(0x000000000000000000000000000000000000000000000000004c697069746f72), bytes32(0x0000000000000000000000000000000000000000000000000000416d6f78696c), bytes32(0x0000000000000000000000000000000000000000000000005072696e6976696c)];
    uint[3] public expiry = [180, 180, 180];
    /*struct medicine_batch {
        uint med_price; 
        bytes32 med_name;
        bytes32 med_type;
        uint remainingdays;
    }
    //medicine_batch[] public med_id;
    medicine_batch[3] public med_id;*/
    //med_id[1] = medicine_batch({med_price : 2, med_name : "Amoxicillin", med_type : "Amoxil", remainingdays : 180});
    
    //med_id[2] = medicine_batch({med_price : 1, med_name : "Lisinopril", med_type : "Prinivil", remainingdays : 180});
    //mapping(uint => mapping(uint => uint)) public logistics_price; 
    //mapping(uint => address) public distributor_address; 
    //mapping(uint => address) public healthcareprovider_address;
    uint[][] public logistics_prices = [[1,2],[2,1]]; // 2 distributors and 2 healthcareproviders
    address[] public distributor_addresses = [0x3D6e946f209B3cd44FFb97A70c4D7FB982d75E1D, 0xD63779a8CaB68c5B8bA71b0eDc5547bFAc749c22]; //modify addresses later on
    address[] public healthcareprovider_addresses = [0x8f78EcF8129434802481650032dB4242f049FEFc, 0x669E53B7a7A18b828764cc193b73119BBe3ee599]; // modify addresses later on
    /*med_id[0] = medicine_batch(3, 0x000000000000000000000000000000000000000041746f72766173746174696e, 0x000000000000000000000000000000000000000000000000004c697069746f72, 180); 
    med_id[1] = medicine_batch(2, 0x000000000000000000000000000000000000000000416d6f786963696c6c696e, 0x0000000000000000000000000000000000000000000000000000416d6f78696c, 180);        
    med_id[2] = medicine_batch(1, 0x000000000000000000000000000000000000000000004c6973696e6f7072696c, 0x0000000000000000000000000000000000000000000000005072696e6976696c, 180);
    bytes32 public iu = med_id[2].med_name;
    uint public ip = med_id[2].med_price;*/
    bytes32 public iu = med_name[2];
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
    function MPriceNegotiation(address _healthcareprovider_negotiatoraddress, address _manufacturer_negotiatoraddress, address _healthcareprovider_address, uint _medicineprice, bytes32 _medicinename, bytes32 _medicinetype, 
    uint _daysleft, uint _amount) public {
        presender = _healthcareprovider_negotiatoraddress;
        sender = _manufacturer_negotiatoraddress;
        healthcareprovider = _healthcareprovider_address;
        medicine_price = _medicineprice;
        medicine_name = _medicinename;
        medicine_type = _medicinetype;
        expiry_daysleft = _daysleft;
        quantity = _amount;
        receiver = producer;
        ack = "NO";
        aval = "NO";
        aval = Medicine_Availability();
        lprice = LogisticsPrice();
        index = k-1;
        require(keccak256(bytes(aval)) == keccak256(bytes(yes)));
        require(lprice != 0);
        i = 0;
        j = 0;
        if(medicine_price >= med_price[index]){
            distributor = distributor_addresses[temp2];
            ack = "YES";
            batch_id = BatchID();
            mp = medicine_price;
            emit healthcareprovider_transaction_request_reply(ack, medicine_price);
            emit transaction_initiation_request(producer, batch_id, medicine_name, medicine_type, mp, lprice, expiry_daysleft,
            quantity, distributor, healthcareprovider);
        } else if (medicine_price < med_price[index]) {
            ack = "NO";
            mp = med_price[index];
            emit healthcareprovider_transaction_request_reply(ack, mp);           
        }
        temp = 0;
        temp1 = 0;
        i = 0;
        j = 0;
        k = 0;
    }
    modifier Medicine_Verification {
        temp = 0;

        while (k < no_of_medicines) {

            if (med_name[k] == medicine_name){
            //if (bytes32(med_id[k].med_name) == bytes32(medicine_name)) {
                if (med_type[k] == medicine_type){
                    if (expiry[k] == expiry_daysleft){
                        temp = 1;
                    }
                }
            }
            k = k+1; 
        }
        require(uint(temp) == uint(1));
        _;
    }
    function Medicine_Availability() public Medicine_Verification returns (string memory _ack) {
        _ack = "YES";
        return _ack;    
    }
    function BatchID() public returns (uint) {
        batch_id=batch_id+1;
        return batch_id;
    }
    function LogisticsPrice() public returns (uint) {
        temp = 0;
        temp1 = 0;
        j = 0;
        i = 0;
        while(temp1==0) {
            if (healthcareprovider == healthcareprovider_addresses[i]){
                temp1 = 1;
                temp = logistics_prices[i][j];
                while(j<2) {
                    if (logistics_prices[i][j] >= temp) {
                        logistics_prices[i][j] = logistics_prices[i][j];
                    } else if (logistics_prices[i][j] < temp) {
                        temp = logistics_prices[i][j];
                        temp2 = j;
                    }
                    j=j+1;
                }
            }
            else if (healthcareprovider != healthcareprovider_addresses[i]){
                i=i+1;
            } 
        }
        return temp;
    }
    function getAck() public view returns(string memory) {
        return ack;
    }
    function m1event1() public view returns(string memory, uint) {
        return (ack, mp);
    }
    function m1event2() public view returns(address, uint, bytes32, bytes32, uint, uint, uint, uint, address, address) {
        return (producer, batch_id, medicine_name, medicine_type, medicine_price, lprice, expiry_daysleft, quantity, distributor, healthcareprovider);
    }
}