pragma solidity ^0.4.24;

// interface Aion
contract AionContract {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint,address);

}

// Main contract
contract SinaContract{
    uint256 public sqrtValue;
    AionContract aion;

    function schedule_rqsr(uint256 number) public {
        // Kovan Aion Contract
        aion = AionContract(0x2fC197cD7897f41957F72e8E390d5a7cF2858CBF);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('sqrt(uint256)')),number);
        uint callCost = 800000*100e9 + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.number+15, address(this), 0, 800000, 100e9, data, false);
    }

    function sqrt(uint256 number) public {
        sqrtValue = number**2;
    }

    function () public payable {}

}
