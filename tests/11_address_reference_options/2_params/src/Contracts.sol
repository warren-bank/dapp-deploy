pragma solidity ^0.4.2;

contract named {
  bytes32 public name;

  function named(bytes32 _name) {
    name = _name;
  }
}

contract C_base {
  address public dependency;

  function get_dependency_name() constant returns(bytes32){
    named _dep = named(dependency);
    return _dep.name();
  }
}

contract C_1 is named("C_1") {
}

contract C_2 is C_base, named("C_2") {
  function C_2(address _dep) {
    dependency = _dep;
  }
}

contract C_3 is C_base, named("C_3") {
  function C_3(address _dep) {
    dependency = _dep;
  }
}
