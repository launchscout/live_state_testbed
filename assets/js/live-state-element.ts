import { prepareTemplate, evaluateTemplate } from './stampino';
import { LitElement, PropertyValueMap } from 'lit';
import { customElement, property } from 'lit/decorators.js';
import { liveState, liveStateConfig } from 'phx-live-state';

@customElement('live-state')
@liveState({
  events: {
    receive: ['livestate-change']
  }
})
export class LiveStateElement extends LitElement {

  @property()
  @liveStateConfig('url')
  url: string = '';

  @property()
  @liveStateConfig('topic')
  topic: string = '';

  template;

  constructor() {
    super();
    this.addEventListener('livestate-change', (e) => {
      console.debug((e as CustomEvent).detail);
      this.requestUpdate();
    })
  }

  firstUpdated(_changedProperties: PropertyValueMap<any> | Map<PropertyKey, unknown>): void {
    const templateElement = this.querySelector(':scope > template');
    this.template = prepareTemplate(templateElement as HTMLTemplateElement);
  }
  
  send(name) {
    console.log(`calling send with ${name}`);
    const doSend = (e) => {
      if (e instanceof SubmitEvent) {
        const form = e.target as HTMLFormElement;
        const formData = new FormData(form);
        const data = Object.fromEntries(formData.entries());
        this['liveState'].pushEvent(name, data);
      } else {
        this['liveState'].pushEvent(name, e.target.dataset)
      }
      console.log(name, e);
      e.preventDefault();
    }
    console.log(typeof doSend);
    return doSend;
  }

  render() {
    return this.template ? this.template({ ...this['liveState'].state, send: this.send.bind(this) }) : ``;
  }

}
