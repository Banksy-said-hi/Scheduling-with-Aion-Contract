pragma solidity 0.4.24;

// interface Aion
contract AionContract {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint,address);
}

// Main contract
contract SinaContract {
    uint256 public sqrtValue;
    AionContract aion;

    function schedule_rqsr(uint256 number) public {
        aion = AionContract(0xFcFB45679539667f7ed55FA59A15c8Cad73d9a4E);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('sqrt(uint256)')),number);
        uint callCost = 200000*100e9 + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp+ 15 seconds, address(this), 0, 200000, 100e9, data, true);
    }

    function sqrt(uint256 number) public {
        sqrtValue = number**2;
    }

    function () public payable {}

}
