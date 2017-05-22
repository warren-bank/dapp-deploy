var msg

msg = '----------------------------------------'
console.log(msg)

try {
  console.log('')
  msg = 'C_1.name == ' + toAscii(C_1.name())
  console.log(msg)

  console.log('')
  msg = 'C_2.name == ' + toAscii(C_2.name())
  console.log(msg)
  msg = 'C_2.dependency == ' + toAscii(C_2.get_dependency_name())
  console.log(msg)

  console.log('')
  msg = 'C_3.name == ' + toAscii(C_3.name())
  console.log(msg)
  msg = 'C_3.dependency == ' + toAscii(C_3.get_dependency_name())
  console.log(msg)
}
catch(error){
  console.log('')
  console.log('[Error] ', error.message)
}
