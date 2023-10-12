export function wrap(f) {
  return function() {
    const inputStr = Host.inputString();
    let output
    if (inputStr != "") {
      const args = JSON.parse(inputStr);
      output = f(...args);
    } else {
      output = f();
    }
    Host.outputString(JSON.stringify(output));  
  }
}
