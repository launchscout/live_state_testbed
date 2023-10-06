
export function foo() {
  let input = JSON.parse(Host.inputString());
  const output = {
    stuff: input.stuff + " and moar"
  }
  Host.outputString(JSON.stringify(output));
}