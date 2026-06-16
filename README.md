# 🪐 NTC Shell v3.0: The AI-Native DevOps Cockpit

An advanced, agnostic, and AI-Native Terminal User Interface (TUI) engineered to streamline multi-cloud orchestration, context switching, and autonomous code generation. Designed for elite DevOps Engineers and SaaS Architects who operate in high-tempo, multi-client international environments.

Developed by **Leandro Paixão** (SaaS & Cloud Architect).

---

## 🌌 The Philosophy: Why AI in the Terminal?

Traditional development setups treat the IDE as the center of gravity. However, for a SaaS Architect, the IDE is just the workshop (focused on writing text). The Terminal is the execution deck (focused on infrastructure, dockerization, local emulators, context sync, and deployment).

By marrying a high-performance console engine with local telemetry and an array of elite LLM APIs, NTC Shell eliminates context switching. It handles system diagnostics offline (ultra-fast, $0 token cost) and delegates cognitive tasks (debugging, architecture, agentic code writing) to the cloud only when triggered.

```text
                     ┌─────────────────────────────────────────┐
                     │            LEANDRO'S COCKPIT            │
                     └────────────────────┬────────────────────┘
                                          │
                  ┌───────────────────────┴───────────────────────┐
                  ▼                                               ▼
         [ NTC IDE PRO ]                                   [ NTC SHELL ]
      Writing & Fine-Editing                          Orchestration & DevOps
      (Cursor-like Side Chat)                         (?? and !! AI engines)
```

---

## ⚡ Core Architecture & Operational Gateways

The system segregates quick natural language consultation from autonomous file-system modifications using a distinct Dual-Core AI Gateway:

### 1. Cognitive Consulting Gateway (`??`)
An instant-response natural language interpreter. By passing unquoted arguments directly into the terminal, the gateway automatically packs system variables, formats raw prompts, and queries the active LLM via a secure, direct REST wrapper.

- **Syntax:** `?? <your question here in natural language without quotes>`
- **Result:** A fully rendered markdown panel showing the architectural explanation, system commands, or concept.

### 2. Autonomous Agentic Engine (`!!`)
A production-grade wrapper around elite command-line agent engines, natively integrated with PowerShell. It enables full-agentic cycles: reads directory maps, diagnoses bugs, proposes code updates, and automatically commits validated changes.

- **Syntax:** `!! "inspect database.js and write a connection pool to handle Redis failures"`
- **Result:** Engages the autonomous agent to solve the task within your working directory.

---

## 🎨 Interactive High-Performance TUI

The cockpit uses `Spectre.Console` on top of PowerShell 7+ to render a sleek, real-time telemetry control board:

- **Active Brain Badge:** Displays the selected LLM (Gemini Pro, Claude Sonnet, DeepSeek R1, Grok, Ollama Local, etc.) and automatically adapts visual highlight themes based on the provider's brand identity.
- **Active Cloud Project Sensor:** Auto-detects localized infrastructure states (e.g., Firebase active aliases, GCP active environments, Docker stacks).
- **Deployment Guardrail (Color-Coded Alerts):** If the active cloud environment matches `PRODUCTION`, the cockpit header blinks in **Bold Red**, acting as a psychological firewall to prevent accidental deployment disasters. If `STAGING`, it highlights in yellow.

---

## 🛠️ The 5-Step Operational Matrix (Numerical Shortcuts)

The NTC Shell maps elite workflows to global numerical shortcuts (`n1` through `n5`) to maintain hands-on-keyboard speed:

| Command | Alias | Function | Scope |
| :--- | :--- | :--- | :--- |
| `n1 [folder]` | `workon` | **Project Teleportation.** Enters directory, loads `.env`, launches NTC IDE PRO. | Local |
| `n2 [model]` | `switch-model` | **AI Switcher.** Dynamically switches active cloud brains (10 specific modes available). | Cloud API |
| `n3` | `sys-logs` / `monitor` | **Local Telemetry.** Checks active ports, emulator status, and container health. | Offline |
| `n4 [msg]` | `git-save` | **Version Control.** Encapsulates add, commit, and push in a unified, safe pipeline. | DevOps |
| `n5 [env]` | `switch-env` | **Env Switcher.** Switches cloud targets (Staging ↔ Production) and syncs contexts. | Cloud Infra |

---

## 🔒 Security & Cloud Guardrails

When working with elite clients in international markets, security is non-negotiable. NTC Shell embeds local guardrails directly into the delivery pipeline:

- **`env-check` (The Financial Firewall):** Integrated directly into `n4` (`git-save`). Before initiating Git delivery, the script checks if sensitive cloud files (e.g., `.env`, `service-account.json`, secret private keys) are exposed in the staging area. If any security risk is detected, the pipeline is blocked automatically, protecting client cloud billing accounts.
- **`git-undo`:** A quick safety-valve to instantly revert the latest AI agent commits, soft-resetting HEAD without wiping local progress.

---

## 🧠 Brains Mapping (Multi-LLM Matrix)

The cockpit handles dynamic transits across the primary AI providers, split by Routine/Cost-Effective work and Heavy/Reasoning workloads:

| Provider | Routine / Speed Mode | Heavy / Reasoning Mode |
| :--- | :--- | :--- |
| **Google Cloud** | Gemini 2.5 Flash | Gemini 2.5 Pro |
| **Anthropic** | Claude 3.5 Haiku | Claude 3.5 Sonnet |
| **DeepSeek** | DeepSeek V3 (Chat) | DeepSeek R1 (Reasoner) |
| **xAI** | Grok Build 0.1 | Grok 4.3 |
| **Local (Offline)** | Ollama (Llama 3 - Default) | Ollama (DeepSeek R1 Local) |

---

<br>
<div align="center">
  <em>“The best way to predict the future is to build the tools that orchestrate it.”</em>
</div>
