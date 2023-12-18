import templize from 'templize';
import LiveState from 'phx-live-state';

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
    } else {
      this['liveState'].pushEvent(eventName, e.target.dataset)
    }
    console.log(name, e);
    e.preventDefault();
  }
}

window.customElements.define('templize-element', TemplizeElement);