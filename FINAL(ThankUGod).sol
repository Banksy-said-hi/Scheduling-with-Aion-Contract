pragma solidity ^0.4.24;

// interface Aion
contract AionContract {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint,address);

}

// Main contract
contract SinaContract{
    AionContract aion;
    address public Reciever;
    uint public Counter;

    constructor(address _reciever) public payable {
        Reciever = _reciever;
        scheduleMyfucntion();
    }

    function scheduleMyfucntion() public {
        aion = AionContract(0x2fC197cD7897f41957F72e8E390d5a7cF2858CBF);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('myfucntion()')));
        uint callCost = 800000*100e9 + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp + 30 seconds, address(this), 0, 800000, 100e9, data, true);
    }

    function myfucntion() public {
        Counter+=1;
        Reciever.transfer(100000000000000000);
        // do your task here and call again the function to schedule
        scheduleMyfucntion();
    }

    function () public payable {}

    function withdraw() public {
        Reciever.transfer(address(this).balance);
    }

}
