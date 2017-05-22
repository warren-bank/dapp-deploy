var msg = []

msg.push('----------------------------------------')

try {
  msg.push('')
  msg.push('C_1.name == ' + toAscii(C_1.name()))

  msg.push('')
  msg.push('C_2.name == ' + toAscii(C_2.name()))
  msg.push('C_2.dependency == ' + toAscii(C_2.get_dependency_name()))

  msg.push('')
  msg.push('C_3.name == ' + toAscii(C_3.name()))
  msg.push('C_3.dependency == ' + toAscii(C_3.get_dependency_name()))
}
catch(error){
  msg.push('')
  msg.push('[Error] ' + error.message)
}
finally {
  console.log(msg.join("\n"))
}
