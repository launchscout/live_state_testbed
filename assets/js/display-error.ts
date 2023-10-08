import { html, css, LitElement } from 'lit'
import { customElement, property, query, state } from 'lit/decorators.js'
import { liveState, liveStateConfig, LiveStateError } from 'phx-live-state';

/**
 * An example element.
 *
 * @slot - This element has a slot
 * @csspart button - The button
 */
@customElement('display-error')
@liveState({events: {receive: ['livestate-error']}})
export class ConnectErrorElement extends LitElement {
  
  @liveStateConfig('topic')
  @property()
  topic: string = '';

  @property()
  @liveStateConfig('url')
  url: string = '';

  constructor() {
    super();
    this.addEventListener('livestate-error', (e: CustomEvent) => {
      this.errorDescription = e.detail.message;
    })
  }

  @state()
  errorDescription = '';

  render() {
    return html`
      <div>
        ${this.errorDescription}
      </div>
    `
  }
}

declare global {
  interface HTMLElementTagNameMap {
    'connect-error': ConnectErrorElement
  }
}

declare global {
  interface HTMLElementEventMap {
    'livestate-error': CustomEvent<{ type: string, source: object }>;
  }
}