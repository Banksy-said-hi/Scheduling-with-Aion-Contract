pragma solidity ^0.4.24;

// interface Aion
contract Aion {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint,address);

}

// Main contract
contract Sina{

    Aion aion;
    uint256 public Counter;

    constructor() public payable {
        scheduleMyfucntion();
    }

    function scheduleMyfucntion() public {
        aion = Aion(0xFcFB45679539667f7ed55FA59A15c8Cad73d9a4E);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('myfucntion()')));
        uint callCost = 200000*1e9 + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp + 20 seconds, address(this), 0, 200000, 5e9, data, true);
    }

    function myfucntion() public {
        Counter+1;
        // do your task here and call again the function to schedule
        scheduleMyfucntion();
    }

    function () public payable {}

}
