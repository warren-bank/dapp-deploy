pragma solidity ^0.4.2;

contract C {
  bytes32[] public names;
  uint256[] public values;

  function C(bytes32[] _names, uint256[] _values) {
    names = _names;
    values = _values;
  }

  function count_names() constant returns(uint256){
    return names.length;
  }

  function count_values() constant returns(uint256){
    return values.length;
  }
}
