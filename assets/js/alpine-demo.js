import LiveState from "phx-live-state";
import Alpine from 'alpinejs'
window.Alpine = Alpine

const liveState = new LiveState({url: "ws://localhost:4000/socket", topic: "todo:all"});

liveState.connect();
Alpine.store('todoList', {
    todos: [],
    init() {
      liveState.connect();
      liveState.addEventListener('livestate-change', ({detail: {state}}) => {
        console.log(this.todos);
        console.log(state);
        this.todos = state.todos;
      });
    }

})

Alpine.start()