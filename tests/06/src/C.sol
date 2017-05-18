pragma solidity ^0.4.2;

// http://solidity.readthedocs.io/en/develop/contracts.html#using-for

import "./Set.sol";

contract C {
    using Set for Set.Data;
    Set.Data knownValues;

    function register(uint value) {
        // Here, all variables of type Set.Data have
        // corresponding member functions.
        // The following function call is identical to
        // Set.insert(knownValues, value)
        require(knownValues.insert(value));
    }
}
