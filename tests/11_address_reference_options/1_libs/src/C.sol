pragma solidity ^0.4.2;

// I literally couldn't find a single example of this usage pattern in Google..

// contrived example of deeply nested Library dependencies based upon:
// http://solidity.readthedocs.io/en/develop/contracts.html#using-for

import "./Libs.sol";

contract C {
  bytes32 public name;

  Lib_4.Data data;

  function C(bytes32 _name) {
    name = _name;

    bool val;

    // insert new flag
    val = Lib_4.insert(data, 1);
    // expect: TRUE
    assert(val);

    // validate existence of the flag
    val = Lib_4.contains(data, 1);
    // expect: TRUE
    assert(val);

    // validate non-existence of unknown flag
    val = Lib_4.contains(data, 100);
    // expect: FALSE
    assert(!val);

    // insert pre-existing flag
    val = Lib_4.insert(data, 1);
    // expect: FALSE
    assert(!val);

    // remove pre-existing flag
    val = Lib_4.remove(data, 1);
    // expect: TRUE
    assert(val);

    // validate non-existence of the flag
    val = Lib_4.contains(data, 1);
    // expect: FALSE
    assert(!val);

  }
}
