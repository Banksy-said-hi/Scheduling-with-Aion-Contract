pragma solidity ^0.4.24;

// interface Aion

contract Aion {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint);


}



// Main contract

contract MyContract {

    Aion aion;
    
    address public reciever;

    constructor(address _reciever) {
        aion = Aion(0xFcFB45679539667f7ed55FA59A15c8Cad73d9a4E);
        reciever = _reciever;
    }


    function scheduleTransaction(uint256 value, uint256 _timestamp, uint256 gaslimit, uint256 gasprice, bool time_or_block) public {

        uint256 callCost = value + gaslimit*gasprice + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp+_timestamp, reciever, value, gaslimit, gasprice, hex"00", true);
    }



    function () public payable {}



    function (uint256 _startpoint, uint256 _period, uint256 _numberofpayments) public {

        for (uint256 i=_startpoint; i<=_startpoint+_period*(_numberofpayments-1); i+_period) {
            
            scheduleTransaction(5000000000, i, 500000, 1000, true);
        
        }
    }
}
