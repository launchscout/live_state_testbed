import { LitElement, html } from "lit";
import { customElement, state } from "lit/decorators.js";

@customElement('dumb-form')
export class DumbForm extends LitElement {

  @state()
  stuff = 'wut';

  render() {
    return html`
      <div>
        Stuff ${this.stuff}
        <form>
          <input .value=${this.stuff} />
          <button @click=${this.emptyStuff}>Empty Stuff</button>
        </form>
  </div>
    `
  }

  emptyStuff(e) {
    e.preventDefault();
    this.stuff = '';
  }
}