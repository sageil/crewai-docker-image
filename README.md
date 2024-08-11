# CrewAI Agents Docker Image
## Motivation

This Docker image provides a convenient way to create and run CrewAI agents without having to install Python dependencies or set up a virtual environment manually. It simplifies the process of managing agent projects by encapsulating all necessary components within a single container, making it easy to share and deploy across different environments.

It also provides a safe way to execute llms generated source code by providing a sandboxed environment where sensitive operations can be performed without affecting the host system's configuration or data.

## Overview

This Docker image is designed to create, edit, and run agents projects using the CrewAI framework. The container accepts an environment variable specifying the project name, with `default_crew` as the default name for the first project, if no project name is provided using the `-e P` enironment variable when the running the container.

The image includes all necessary dependencies required to create CrewAI agents, as well as other development tools and editors to ease the development of agents within the container without the need to mount local file system.

## Included Tools

- **neoVim** Latest stable version built from source [neovim](https://github.com/neovim/neovim)
- **poetry** Dependency management tool for Python projects [poetry](https://python-poetry.org/)
- **lazyVim** A highly optimized Vim-like editor for Neovim [lazyvim](https://www.lazyvim.org/)
- **crewAI** Platform for Multi AI Agents Systems [official CrewAI documentation](https://docs.crewai.com/)

## Using the image with local models
>
> [!IMPORTANT]  
> The steps below assume you have a local model available and configured for use with CrewAI. Ensure that your local model is accessible within the container's environment.
> [ollama](https://ollama.com/) is a great tool to use for local models.

1. Run the container using the following command:

```bash
docker run -it --network host --name <container-name> -e P=<project-name> sageil/crewai:<tag> bash
```

Replace `<container-name>` with a desired name for your container, and `<project-name>` with the name of the project you wish to create within CrewAI. If you do not provide a project name, the container will default to using `default_crew`. You can find the latest image tag by checking the Docker Hub repository [sageil/crewai](https://hub.docker.com/r/sageil/crewai/tags).

Replace `<tag>` with `latest` to get the latest version of the Docker image with the latest crewAI framework and tools. You can find other versions by checking the Docker Hub repository

> [!TIP]  
> If you prefer to work on your project using a locally installed editor, use the --mount option to bind your local directory to the container's workspace. This allows you to edit files directly within your local environment while still leveraging the container for development purposes.

> `docker container run -e P="myproject" --network host --name myproject -it --mount type=bind,source="$(pwd)",target=/app sageil/crewai:latest bash`


2. Add the following to the *top* of `crew.py` found in `<project-name>src/<project-name>crew.py` file to use the local model by replacing `base_url` and `model` with your local model name and path or IP address and port if needed. For example:

```python
from langchain_openai import ChatOpenAI

llm = ChatOpenAI(
    model="mistral:latest", base_url="http://host.docker.internal:11434/v1"
)
```

3. Add your llm to ***all*** agents

```python
 @agent
    def researcher(self) -> Agent:
        return Agent(
            config=self.agents_config["researcher"],
            verbose=False,
            llm=llm,
        )
  ```

4. From the terminal, run `poetry run <project-name>` to run your crew

5. You can start the container to resume working by running `docker container start -ai <container-name>`

## Using the image with remote models/APIs

1. Run the image using

```bash
docker container run -e P="myproject" --name myproject -it --mount type=bind,source="$(pwd)",target=/app sageil/crewai:latest bash
```

if you prefer to use your local filesystem or

```bash
docker run -it --network host --name <container-name> -e P=<project-name> sageil/crewai:<tag> bash
```
2. Edit the `.env` the `OPENAI_API_KEY` value to add your API_KEY (You can view dotfiles in neovim by pressing `H` on your keyboard)

3. Modify the default agents provided by crewai default project 

4. Run your agent using `poetry run <project-name>`

## Additional Tools

To create a new project while inside the container, run `newcrew <project_name>` command to create a new project inside the container workspace. This will generate all necessary files and directories for your project, including configuration files, source code, and other resources.

> [!TIP]  
> To use the installed nevim to edit your project, run `nvim .` inside your project directory to open the project in neovim editor. Use your `space` key followed by `e` to view the project tree structure.
>
## Supported Architectures

The image supports linux/amd64 and linux/arm64 architectures and was tested against MAC M2 with Apple silicon and multiple Linux distributions

## Screen Captures

![Editor](assets/nvim-main.png)
![Code](assets/code-action.png)

## License

This project is licensed under the [MIT License](https://github.com/sageil/crewai-docker-image/blob/main/LICENSE.md).

## Issues
1. Copying from nvim fails due to display driver

Please report other issues you encounter on the [Issues](https://github.com/sageil/crewai-docker-image/issues) including steps to reproduce them.


Enjoy using the CrewAI Agent Docker Image!

