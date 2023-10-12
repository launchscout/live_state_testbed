
import { wrap } from "./wrap";

export const init = wrap(function() {
  return { foo: "bar"};
});

export const increaseFoo = wrap(function(payload, state) {
  return { foo: state.foo + payload.foo};
});

// export const increaseFoo({}) {

// }


