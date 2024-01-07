import templize, {directive} from './templize';
import LiveState from 'phx-live-state';
import { TemplateInstance } from 'template-parts';

const makeSound = (sound) => (e) => console.log(sound, e)

export class TemplizeElement extends HTMLElement {
  connectedCallback() {
    this.liveState = new LiveState({
      url: this.getAttribute('url'),
      topic: this.getAttribute('topic')
    });
    this.liveState.connect();
    this.liveState.addEventListener('livestate-change', ({ detail: { state } }) => {
      if (this.updater) {
        this.updater(state);
      } else {
        const send = (eventName) => (e) => this.sendEvent(eventName, e);
        const [params, update] = templize(this, { ...state, send });
        this.updater = update;
      }
    });
  }

  sendEvent(eventName, e) {
    if (e instanceof SubmitEvent) {
      const form = e.target;
      const formData = new FormData(form);
      const data = Object.fromEntries(formData.entries());
      this['liveState'].pushEvent(eventName, data);
    } else if (e instanceof InputEvent) {
      const form = e.target.form;
      const formData = new FormData(form);
      const data = Object.fromEntries(formData.entries());
      this['liveState'].pushEvent(eventName, data);
    } else {
      console.log(e);
      this['liveState'].pushEvent(eventName, e.target.dataset)
    }
    console.log(name, e);
    e.preventDefault();
  }
}

window.customElements.define('templize-element', TemplizeElement);