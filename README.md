# CrewAI Agents Docker Image

- [Motivation](#motivation)
- [prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Tools](#tools)
- [Tips](#tips)
- [Example Projects](#examples)
- [Screen Captures](#ScreenCaptures)
- [Issues](#issues)
- [License](#license)

## Motivation

This Docker image provides a convenient way to create and run CrewAI agents without having to install Python dependencies or set up a virtual environment manually. It simplifies the process of managing agent projects by encapsulating all necessary components within a single container, making it easy to share and deploy across different environments and makes an ideal environment in which to run agents to generate and execute code. I used [ollama](https://ollama.com/)

## Prerequisites
- Docker
- Basic knowledge of python
- Basic knowledge of crewAI and langchain
- Desire to learn and have fun
- Ollama installed locally or access to remote AI services like chatGPT

## Usage
#### Method 1: using a ollama locally
1. Run the following command after replacing <container-name> with the name of your container, <project-name> with the name of your project and <tag> with the tag of the image you want to use. [available tags](https://hub.docker.com/r/sageil/crewai/tags)

```bash
docker run -it --network host --name <container-name> -e P=<project-name> sageil/crewai:<tag> bash
```
2. From your container shell, navigate to your project directory/src/crew.py and import `Ollama` by adding `from langchain_community.llms import Ollama`
3. Configure your crew to use your local llm by adding 

```python
 myllm = Ollama(model="openhermes:v2.5", base_url="http://host.docker.internal:11434", temperature=0)
```
4. Change the model and the temperature in the above snippet to your desired llm model
5. Add the llm property to your agents by adding `llm=myllm` 
```python
    @agent
    def researcher(self) -> Agent:
        return Agent(
            config=self.agents_config['researcher'],
            # tools=[MyCustomTool()], # Example of custom tool, loaded on the beginning of file
            verbose=True, # Print out all actions
            llm=myllm
        )

```
6. Run your crew by executing `poetry run <project_name>`

#### Method 2: using remote services like chatGPT
1. Set your OPENAI API key `os.environ["OPENAI_API_KEY"] = "YOUR_KEY"`
2. Set your chatGPT model `os.environ["CHATGPT_MODEL"] = "YOUR_MODEL`
3. Add the llm property to your agents by adding `llm=ChatOpenAI()`
4. Run your crew by executing `poetry run <project_name>`

In both methods, you can also use a local mount from your host to the container by change the docker container run command with 
`docker container run -e P="myproject" --network host --name myproject -it --mount type=bind,source="$(pwd)",target=/app sageil/crewai:latest bash`

> [!TIP]  
> When working with remote services, you can also remove the --network host part of the command as its only required to allow
> the container access to the host's network.

## Tools

- **neoVim** Latest stable version built from source [neovim](https://github.com/neovim/neovim)
- **poetry** Dependency management tool for Python projects [poetry](https://python-poetry.org/)
- **lazyVim** A highly optimized Vim-like editor for Neovim [lazyvim](https://www.lazyvim.org/)
- **crewAI** Platform for Multi AI Agents Systems [official CrewAI documentation](https://docs.crewai.com/)

## Tips 
- v: `alias v='nvim` & `alias vim='nvim'`
- Running `newcrew <project_name>` will create a new crew project with the provided name.
- You can restart a container after stopping it by using `docker container start -ai <container-name>`

## Example

[Veterinary Assistant Crew](https://github.com/sageil/veterinary_assistant)

## ScreenCaptures

![Editor](assets/nvim-main.png)
![Code](assets/code-action.png)

## Issues
Known issues:

1. Copying from nvim fails due to display driver
2. Icon fonts are not rendered correctly in the container's terminal? [Watch](https://www.youtube.com/watch?v=mQdB_kHyZn8)

New Issues:

Please report other issues you encounter on the [Issues](https://github.com/sageil/crewai-docker-image/issues) including steps to reproduce them.

## License
This project is licensed under the [MIT License](https://github.com/sageil/crewai-docker-image/blob/main/LICENSE.md).