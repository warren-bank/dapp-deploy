let contract_state = {
  value_bool:     Storage.value_bool.call(),
  value_uint8:    Storage.value_uint8.call().valueOf(),
  value_uint256:  Storage.value_uint256.call().valueOf(),
  value_address:  Storage.value_address.call().toString(16),
  value_string:   web3.toAscii(Storage.value_string.call())
}

console.log('Storage data:')
console.log(contract_state)
