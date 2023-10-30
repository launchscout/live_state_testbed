export function init() {
  return ['Hello', 'WASM Components'];
}

export function addTodo(todo, todos) {
  return [todo, ...todos];
}