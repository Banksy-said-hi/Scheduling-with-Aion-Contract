pragma solidity ^0.4.24;

// interface Aion
contract Aion {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint);


}



// Main contract
contract SinaContract {

    Aion aion;
    
    address public reciever;

    constructor(address _reciever) public {
        aion = Aion(0xFcFB45679539667f7ed55FA59A15c8Cad73d9a4E);
        reciever = _reciever;
    }








    // Getting balance of the contract
    function getBalance() public view returns(uint) {
        return address(this).balance;
    } 

    function getTimeStamp() public view returns(uint) {
        return block.timestamp;
    }


    // STEP(2) ==> Scheduling one transaction with customized properties
    function scheduleTransaction(uint256 value, uint256 _timestamp, uint256 gaslimit, uint256 gasprice, bool) public payable{

        uint256 callCost = value + gaslimit*gasprice + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp+_timestamp, reciever, value, gaslimit, gasprice, "", true);
    }


    // STEP(2) ==> Scheduling a set of payments based on 3 wanted characteristics
    function createReccuringPayments(uint256 _startpoint, uint256 _period, uint256 _numberofpayments) public {

        for (uint256 i=_startpoint; i<=_startpoint+_period*(_numberofpayments-1); i+_period) {
            
            scheduleTransaction(5000000000, i, 500000, 1000, true);
        
        }
    }


    // STEP (1) ==> Fallback funtion for recieving the total amount of payments from the customer prior to createRecurringPayments()
    // For ensuring that contract is capable of sending the amount on the event 
    function () public payable {}
}
