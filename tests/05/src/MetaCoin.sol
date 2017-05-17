pragma solidity ^0.4.2;

// https://ethereum.stackexchange.com/q/6927

import "./TestLib.sol";

contract MetaCoin {
  TestLib.Data data;
  address public owner;

  function MetaCoin() {
    owner = msg.sender;
    TestLib.Set(data, 2);
  }

  function GetData() constant returns(uint) {
    return TestLib.Get(data);
  }
}
