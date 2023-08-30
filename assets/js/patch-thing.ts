import { html, css, LitElement } from 'lit'
import { customElement, property, query } from 'lit/decorators.js'
import { liveState, liveStateConfig, liveStateProperty } from 'phx-live-state';

@customElement('patch-thing')
@liveState({topic: 'patchy', events: {send: ['bump']}})
export class JoinParamsElement extends LitElement {
  
  @property({attribute: 'the-url'})
  @liveStateConfig('url')
  theUrl: string = "foo";

  @property()
  @liveStateProperty()
  result: string = '';

  render() {
    return html`
      <div>
        ${this.result}
      </div>
      <div>version: ${this['liveState'].stateVersion}</div>
      <button @click=${() => this.bump()}>Bump</button>
    `
  }

  bump() { 
    this.dispatchEvent(new CustomEvent('bump', {detail: {}})); 
  }

}

declare global {
  interface HTMLElementTagNameMap {
    'patch-thing': JoinParamsElement
  }
}
