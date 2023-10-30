
use anyhow::Context;
use wasmtime::component::*;
use wasmtime::{Config, Engine, Store};
use wasmtime_wasi::preview2::{Table, WasiCtxBuilder};

wasmtime::component::bindgen!({
    path: "todo-list.wit",
    world: "todo-list"
});

#[rustler::nif]
fn other_init() -> Vec<String> {
    let mut config = Config::default();
    config.wasm_component_model(true);
    let engine = Engine::new(&config).unwrap();
    let linker = Linker::new(&engine);

    let mut table = Table::new();

    let wasi = WasiCtxBuilder::new()
        .build(&mut table);
    let mut store = Store::new(&engine, wasi);

    let component = Component::from_file(&engine, "./todo-list.wasm").context("Component file not found").unwrap();

    let (instance, _) = TodoList::instantiate(&mut store, &component, &linker).unwrap();

    println!("after instantiation, before execution");

    instance
        .call_init(&mut store).unwrap()
    
    // println!("Got {} and {}", result[0], result[1]);

    // let new_result = instance
    //     .call_add_todo(&mut store, "more", &result[..])
    //     .context("Failed to call init function")
    //     .unwrap();
    
    // println!("Got {} and {} and {}", new_result[0], new_result[1], new_result[2]);
    
    // new_result
}

#[rustler::nif]
fn other_add_todo(todo: String, todo_list: Vec<String>) -> Vec<String> {
    let mut config = Config::default();
    config.wasm_component_model(true);
    let engine = Engine::new(&config).unwrap();
    let linker = Linker::new(&engine);

    let mut table = Table::new();

    let wasi = WasiCtxBuilder::new()
        .build(&mut table);
    let mut store = Store::new(&engine, wasi);

    let component = Component::from_file(&engine, "./todo-list.wasm").context("Component file not found").unwrap();

    let (instance, _) = TodoList::instantiate(&mut store, &component, &linker).unwrap();

    println!("after instantiation, before execution"); 

    instance.call_add_todo(&mut store, &todo, &todo_list[..]).unwrap()
}

rustler::init!("Elixir.LivestateTestbedWeb.WasmComponent", [other_init, other_add_todo]);