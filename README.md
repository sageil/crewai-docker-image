# CrewAI Agents Docker Image

![Docker Image Version](https://img.shields.io/docker/v/sageil/crewai)
![Docker Pulls](https://img.shields.io/docker/pulls/sageil/crewai.svg)
![GitHub Issues](https://img.shields.io/github/issues/sageil/crewai-docker-image)
![GitHub Stars](https://img.shields.io/github/stars/sageil/crewai-docker-image?style=flat-square)

## TL;DR

1. Build image:

```bash
docker build --platform linux/amd64 --build-arg CREWAI=1.14.7 -t crewai:1.14.7 .
```

2. Start container with a project mount:

```bash
mkdir -p projects && \
docker run -it --rm --network host \
  -v "$PWD/projects:/home/appuser/apps" \
  -e P=my_project \
  crewai:1.14.7 \
  bash
```

3. Inside container, open your project:

```bash
v .
crewai run
```

## Why this image

This image is a ready-to-use local environment for building and running CrewAI agents without local dependency setup.

It includes:

- neovim + LazyVim
- uv and `crewai` / `crewai-tools`
- `fd`, `rg`, `fzf`, and `lazygit`
- shell helpers (`v`, `lg`, `sv`, `newcrew`)

## Prerequisites

- Docker
- Docker Compose (optional, for repeatable local deployment)
- Basic Python/CrewAI familiarity
- Ollama locally or remote API credentials (optional)

## Quick start

### Build the image

```bash
docker build \
  --platform linux/amd64 \
  --build-arg CREWAI=1.14.7 \
  -t sageil/crewai:1.14.7 .
```

### Run a container

```bash
mkdir -p projects
docker run -it --rm --network host \
  -v "$PWD/projects:/home/appuser/apps" \
  -e P=my_project \
  sageil/crewai:1.14.7 \
  bash
```

The image defaults to `P=default_crew` if not provided.

### Run with Compose

```bash
docker compose up -d
docker compose exec crewai bash
```

You can override image and project name:

```bash
IMAGE=sageil/crewai:latest \
CREWAI_PROJECT=my_project \
docker compose up -d
```

## Working inside the container

Projects are created with `crewai create crew` on first startup (based on `P`).

Useful commands:

- `v .` → open current project in neovim
- `newcrew <project_name>` → create a new CrewAI project in current directory
- `sv` → activate `.venv` in current project (auto-run when present)
- `crewai run` → run the current project

## LLM provider setup

### Ollama on host

1. Open project in neovim (`v .`).
2. Open LazyVim explorer (`SPACE+e`) and show hidden files (`SHIFT+H`).
3. Update model/base settings to use your host endpoint (example: `http://host.docker.internal:11434`).

### Remote providers (OpenAI/others)

1. Open your config in neovim.
2. Set `OPENAI_API_KEY` and model values in `.env` or crew config.
3. Run `crewai run`.

### Code-based LLM override

```python
from crewai.llm import LLM

myllm = LLM(
    model='ollama/deepseek-r1:7b',
    base_url='http://localhost:11434',
    temperature=0.2,
)
```

Assign `llm=myllm` in `Agent(...)` where needed.

## Deployment notes

- Persist project outputs with `./projects:/home/appuser/apps`.
- Remove `network_mode: host` in `docker-compose.yml` only when using external APIs and no host networking is required.
- Restart a stopped container with `docker container start -ai <container_name>`.

## Supported versions

Recent and commonly used tags:

- `1.15.0`
- `1.14.7`
- `1.14.6`
- `1.14.3`
- `1.14.2`
- `1.12.2`
- `1.11.0`
- `1.10.0`
- `1.9.0`
- `1.8.1`
- `1.8.0`
- `1.7.2`
- `1.7.1`
- `1.7.0`

Full version history is available on Docker Hub:

- https://hub.docker.com/r/sageil/crewai/tags

## Known issues

- Clipboard integration in neovim may require X11/display setup.
- Icon fonts may render inconsistently in some terminals.

## File tree example

```text
my_project/
├── .gitignore
├── .env
├── knowledge/
├── pyproject.toml
├── README.md
└── src/
    └── my_project/
        ├── __init__.py
        ├── main.py
        ├── crew.py
        ├── tools/
        │   ├── custom_tool.py
        │   └── __init__.py
        └── config/
            ├── agents.yaml
            └── tasks.yaml
```

## Issues and support

- Report issues: https://github.com/sageil/crewai-docker-image/issues

## License

- MIT: https://github.com/sageil/crewai-docker-image/blob/main/LICENSE.md
