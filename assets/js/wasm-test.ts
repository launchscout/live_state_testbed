import { html, css, LitElement } from 'lit'
import { customElement, property, query } from 'lit/decorators.js'
import { liveState, liveStateConfig } from 'phx-live-state';

/**
 * An example element.
 *
 * @slot - This element has a slot
 * @csspart button - The button
 */
@customElement('wasm-test')
@liveState({topic: 'wasm', properties: ['foo'], events: {send: ['increaseFoo']}})
export class JoinParamsElement extends LitElement {
  
  @property({attribute: 'the-url'})
  @liveStateConfig('url')
  theUrl: string = "foo";

  @property()
  // @liveStateProperty()
  foo: string = '';

  render() {
    return html`
      <div>
        ${this.foo}
      </div>
      <button @click=${this.increaseFoo}>Increase the foo!</button>
    `
  }

  increaseFoo() {
    this.dispatchEvent(new CustomEvent('increaseFoo', {detail: {foo: 'even more foo!'}}));
  }
}

declare global {
  interface HTMLElementTagNameMap {
    'wasm-test': JoinParamsElement
  }
}
