pragma solidity ^0.4.2;

// I literally couldn't find a single example of this usage pattern in Google..

// contrived example of deeply nested Library dependencies based upon:
// http://solidity.readthedocs.io/en/develop/contracts.html#using-for

library Lib_1 {
  struct Data {
    mapping(uint => bool) flags;
  }

  function insert(Data storage self, uint value) returns (bool) {
    if (self.flags[value]) return false; // already there
    self.flags[value] = true;
    return true;
  }

  function remove(Data storage self, uint value) returns (bool) {
    if (!self.flags[value]) return false; // not there
    self.flags[value] = false;
    return true;
  }

  function contains(Data storage self, uint value) returns (bool) {
    return self.flags[value];
  }
}

library Lib_2 {
  struct Data {
    Lib_1.Data data;
  }

  function insert(Data storage self, uint value) returns (bool) {
    return Lib_1.insert(self.data, value);
  }

  function remove(Data storage self, uint value) returns (bool) {
    return Lib_1.remove(self.data, value);
  }

  function contains(Data storage self, uint value) returns (bool) {
    return Lib_1.contains(self.data, value);
  }
}

library Lib_3 {
  struct Data {
    Lib_2.Data data;
  }

  function insert(Data storage self, uint value) returns (bool) {
    return Lib_2.insert(self.data, value);
  }

  function remove(Data storage self, uint value) returns (bool) {
    return Lib_2.remove(self.data, value);
  }

  function contains(Data storage self, uint value) returns (bool) {
    return Lib_2.contains(self.data, value);
  }
}

library Lib_4 {
  struct Data {
    Lib_3.Data data;
  }

  function insert(Data storage self, uint value) returns (bool) {
    return Lib_3.insert(self.data, value);
  }

  function remove(Data storage self, uint value) returns (bool) {
    return Lib_3.remove(self.data, value);
  }

  function contains(Data storage self, uint value) returns (bool) {
    return Lib_3.contains(self.data, value);
  }
}
