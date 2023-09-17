import { html, css, LitElement } from 'lit'
import { customElement, state, query } from 'lit/decorators.js'
import { liveState } from 'phx-live-state';

/**
 * An example element.
 *
 * @slot - This element has a slot
 * @csspart button - The button
 */
@customElement('todo-form')
@liveState({
  events: {
    send: ['add_todo'],
    receive: ['livestate-change']
  },
  context: 'todoLiveState'
})
export class TodoFormElement extends LitElement {

  @query("input[name='todo']")
  todoInput: HTMLInputElement | undefined;

  @state()
  sending: Boolean = false;

  constructor() {
    super();
    this.addEventListener('livestate-change', () => {
      this.sending = false;
    })
  }

  render() {
    return html`
      <div>
        <input name="todo" />
        <button @click=${this.addTodo} ?disabled=${this.sending}>Add Todo</button>
      </div>
    `
  }

  addTodo(_event : Event) {
    this.sending = true;
    this.dispatchEvent(new CustomEvent('add_todo', {detail: {todo: this.todoInput!.value}}));
    this.todoInput!.value = '';
  }
}

declare global {
  interface HTMLElementTagNameMap {
    'todo-form': TodoFormElement
  }
}
