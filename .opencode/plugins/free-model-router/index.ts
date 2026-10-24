import { Plugin } from "@opencode/plugin"

// Preference order is based on note-writing quality and tool discipline. The
// selector uses the currently available catalog and never sends probe prompts.
const preferred = [
  ["opencode", "nemotron-3.5-super-vl-free"],
  ["opencode", "nemotron-3-ultra-free"],
  ["opencode", "deepseek-v4.1-flash-free"],
  ["opencode", "mimo-v2.6-flash-free"],
  ["opencode", "glm-5.3-flash-free"],
  ["opencode", "minimax-m3.1-flash-free"],
  ["openrouter", "free"],
  ["openrouter", "thinkingmachines/inkling:free"],
  ["openrouter", "minimax/minimax-m3.1-flash:free"],
  ["ollama", "qwen2.5:3b"],
]

const free = (model: { cost?: readonly { input: number; output: number }[] }) =>
  model.cost?.length > 0 && model.cost.every((tier) => tier.input === 0 && tier.output === 0)

export default Plugin.define({
  id: "appunti.free-model-router",
  async setup(ctx) {
    await ctx.model.transform((editor) => {
      const models = editor.list()
      const eligible = new Set<string>()
      for (const model of models) {
        const isPreferred = preferred.some(
          ([providerID, modelID]) => providerID === model.providerID && modelID === model.id,
        )
        if (!isPreferred || !free(model) || !model.capabilities.tools) {
          editor.update(model.providerID, model.id, (draft) => {
            draft.enabled = false
          })
        } else if (model.enabled) {
          eligible.add(`${model.providerID}/${model.id}`)
        }
      }
      const selected = preferred.find(([providerID, modelID]) =>
        eligible.has(`${providerID}/${modelID}`),
      )
      if (selected) editor.default.set(selected[0], selected[1])
    })
  },
})
