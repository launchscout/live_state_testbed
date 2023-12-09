import { TemplateInstance } from '@github/template-parts'
import { parse, EvalAstFactory } from 'jexpr';
const astFactory = new EvalAstFactory();
import type { TemplatePart, TemplateTypeInit } from '@github/template-parts';

const processor = {
  processCallback(_: TemplateInstance, parts: Iterable<TemplatePart>, params: unknown): void {
    if (typeof params !== 'object' || !params) return
    for (const part of parts) {
      const expr = parse(part.expression, astFactory);
      part.value = expr?.evaluate(params);
    }
  }
};


export class LiveStateElement extends HTMLElement {

  templateInstances: TemplateInstance[] = [];

  connectedCallback() {
    this.querySelectorAll('template[livestate]').forEach(tpl => {
      const instance = new TemplateInstance((tpl as HTMLTemplateElement), { person: { firstName: 'Bob', lastName: 'Jones' } }, processor);
      this.templateInstances.push(instance);
      this.appendChild(instance);
    });
  }

}

window.customElements.define('live-state', LiveStateElement);