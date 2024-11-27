The CrewAI Agents Docker Image is a containerized development environment designed to facilitate the creation and execution of CrewAI agents. The project leverages Docker to provide a consistent and isolated environment for developers working with CrewAI and related tools. This Docker image includes a variety of tools and dependencies necessary for developing, testing, and running CrewAI agents, including Neovim, a highly optimized Vim-like editor, and a dependency management tool for Python projects. The primary goal of this project is to provide a seamless and secure way to experiment with and develop AI-driven agents, particularly those using the Ollama code generation and execution framework or remote AI services like chatGPT.

#### Features

1. **Containerized Development Environment**:
   - **Python 3.11**: The image is based on the Python 3.11-slim-bookworm base image, ensuring compatibility with the latest Python features and performance optimizations.
   - **Neovim**: The latest stable version of Neovim is built from source and installed, providing a powerful and customizable text editor.
   - **Dependency Management**: The `uv` tool is used for dependency management, allowing for easy locking and synchronization of project dependencies.
   - **Virtual Environment Support**: The image sets up a virtual environment for each project, ensuring that project dependencies are isolated and managed effectively.

2. **Ease-of-Use**:
   - **Automated Setup**: The `entrypoint.sh` script automates the setup of the project environment, including creating directories, installing dependencies, and activating the virtual environment.
   - **Project Creation**: The `add_crew.sh` script provides a convenient function `newcrew` to create a new CrewAI project, install dependencies, and configure the virtual environment.
   - **Neovim Configuration**: The image includes a customized Neovim configuration with lazy.nvim, a highly optimized plugin manager, and a set of useful plugins for Python and YAML development.

3. **AI Integration**:
   - **Ollama Integration**: The project supports local Ollama code generation and execution. Users can configure their agents to use a local Ollama model by setting the appropriate parameters in their Python code.
   - **Remote AI Services**: The project also supports integration with remote AI services like chatGPT. Users can set their API keys and model preferences to use these services for their agents.

4. **Development Tools**:
   - **Git**: The image includes Git for version control, allowing developers to clone repositories, commit changes, and push updates.
   - **Ripgrep and Fzf**: The image includes ripgrep and fzf for efficient file and code searching.
   - **Xclip and Tree**: Tools like xclip and tree are included for clipboard management and file system navigation, respectively.

5. **Customization**:
   - **Neovim Plugins**: The Neovim configuration includes a set of core and extra plugins for language support, debugging, and refactoring.
   - **Environment Variables**: The image uses environment variables to control project setup and behavior, making it easy to customize the environment for different projects.

6. **Documentation and Examples**:
   - **README.md**: The project includes a comprehensive README file with detailed instructions on installation, usage, and tips for working with the Docker image.
   - **Example Projects**: The README provides links to example projects, such as the Veterinary Assistant Crew, to help users get started quickly.
   - **Tutorial for Building and Publishing**: The project includes a `tutorial.md` file that provides a step-by-step guide on how to build and publish the Docker image to Docker Hub.

#### Technical Specification

1. **Platform/Technologies**:
   - **Docker**: The project is containerized using Docker, ensuring a consistent and isolated development environment.
   - **Python 3.11**: The base image is based on Python 3.11-slim-bookworm, providing a lightweight and efficient environment.
   - **Neovim**: The latest stable version of Neovim is built from source and installed, offering advanced text editing capabilities.
   - **uv**: A dependency management tool for Python projects, used for locking and synchronizing dependencies.
   - **lazy.nvim**: A highly optimized plugin manager for Neovim, used to manage and load plugins.
   - **CrewAI and crewai-tools**: The project uses the CrewAI platform and its associated tools for multi-AI agent systems.

2. **Container Setup**:
   - **Base Image**: The Docker image is based on `python:3.11-slim-bookworm`.
   - **System Packages**: The image installs a variety of system packages and development tools, including `curl`, `bash-completion`, `ripgrep`, `fzf`, `xclip`, `tree`, `git`, `make`, `cmake`, `build-essential`, and others.
   - **Neovim Installation**: The `buildneovim.sh` script clones the Neovim repository from GitHub, builds the stable version, and installs it with a release build type that includes debugging information.
   - **User Management**: A non-root user `appuser` is created and added to the `appgroup`. The user's shell environment is set up with custom aliases and configurations.
   - **Virtual Environment**: The `shell_venv.sh` script defines a function `sv` to activate a virtual environment if it exists in the current working directory.

3. **Project Initialization**:
   - **Entry Point**: The `entrypoint.sh` script sets up the project environment by creating directories, installing dependencies, and activating the virtual environment.
   - **Project Creation**: The `add_crew.sh` script defines a function `newcrew` to create a new CrewAI project, install dependencies, and configure the virtual environment.
   - **Neovim Configuration**: The `lazy.lua` and `options.lua` files configure Neovim with the lazy.nvim plugin manager and set global variables for LSP and linting tools.
   - **Treesitter Configuration**: The `treesitter.lua` file configures Neovim's `nvim-treesitter` plugin for syntax highlighting, indentation, and other language-aware features.

4. **AI Integration**:
   - **Ollama**: The project supports local Ollama code generation and execution. Users can import the `Ollama` class from `langchain_community.llms` and configure their agents to use a local Ollama model.
   - **Remote AI Services**: The project supports integration with remote AI services like chatGPT. Users can set their API keys and model preferences to use these services for their agents.

5. **Development Workflow**:
   - **Running the Docker Container**: Users can run the Docker container with the `docker run` command, specifying the project name and the tag of the desired image.
   - **Project Directory**: The `entrypoint.sh` script sets up the project directory, installs dependencies, and activates the virtual environment.
   - **Code Execution**: Users can navigate to the project directory, import the `Ollama` class, configure their agents, and run the crew using `crewai run`.

6. **Customization**:
   - **Environment Variables**: Users can customize the project setup by setting environment variables, such as `P` for the project name.
   - **Neovim Configuration**: Users can customize the Neovim configuration by modifying the `lazy.lua`, `options.lua`, and `treesitter.lua` files.
   - **Plugin Management**: The `lazy.lua` file manages the installation and configuration of Neovim plugins, allowing users to add or remove plugins as needed.

7. **Documentation and Support**:
   - **README.md**: The project includes a comprehensive README file with detailed instructions on installation, usage, and tips for working with the Docker image.
   - **Example Projects**: The README provides links to example projects, such as the Veterinary Assistant Crew, to help users get started quickly.
   - **Issue Tracking**: Users can report issues and request features on the project's GitHub repository.
   - **Tutorial for Building and Publishing**: The `tutorial.md` file provides a step-by-step guide on how to build and publish the Docker image to Docker Hub.

   **Tutorial for Building and Publishing the Docker Image to Docker Hub**:
   - **Cloning the Project**:
     ```sh
     git clone https://github.com/your-repo/crewai-agents
     cd crewai-agents
     ```
   - **Building the Docker Image**:
     ```sh
     docker build -t DOCKER_USERNAME/crewai-agents .
     ```
     For example, if your Docker username was `mobydock`, you would run:
     ```sh
     docker build -t mobydock/crewai-agents .
     ```
   - **Verifying the Image**:
     ```sh
     docker image ls
     ```
     You will see output similar to:
     ```
     REPOSITORY              TAG       IMAGE ID       CREATED          SIZE
     mobydock/crewai-agents  latest    1543656c9290   2 minutes ago    1.12GB
     ```
   - **Pushing the Image to Docker Hub**:
     ```sh
     docker push DOCKER_USERNAME/crewai-agents
     ```
     Depending on your upload speeds, this may take a moment to push.

### Conclusion


# CrewAI Agents Docker Image

- [Motivation](#motivation)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Tools](#tools)
- [Supported Versions](#versions)
- [Tips](#tips)
- [Example Projects](#examples)
- [Screen Captures](#screencaptures)
- [Issues](#issues)
- [License](#license)

## Motivation

This Docker image provides a convenient & secure way to create and run CrewAI agents without having to install any dependencies locally. I created the image to experiment with [ollama](https://ollama.com/) code generation and execution.

## Prerequisites

- Docker
- Basic knowledge of python
- Basic knowledge of crewAI and langchain
- Ollama installed locally or access to remote AI services like chatGPT
- Desire to learn and have fun

## Usage

#### Method 1: using a ollama locally

1. Run the following command after replacing `container-name` with the name of your container, `project-name` with the name of your project and `tag` with the [tag](https://hub.docker.com/r/sageil/crewai/tags) of the image you want to use.

```bash
docker run -it --network host --name <container-name> -e P=<project-name> sageil/crewai:<tag> bash
```

> [!TIP]
> if you leave out the `P` completely `-e P=<project_name>` from the command, a default crew will be created with the name default_crew.

2. Once the container starts, from your container shell, navigate to your project directory/src/crew.py and import `Ollama` by adding `from langchain_community.llms import Ollama`
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

6. Run your crew by executing `crewai run`

#### Method 2: using remote services like chatGPT

1. Set your OPENAI API key `os.environ["OPENAI_API_KEY"] = "YOUR_KEY"`
2. Set your chatGPT model `os.environ["CHATGPT_MODEL"] = "YOUR_MODEL`
3. Add the llm property to your agents by adding `llm=ChatOpenAI()`
4. Run your crew by executing `crewai run`

> [!TIP]
> When working with remote services, you can also remove the --network host part of the command as its only required to allow
> the container access to the host's network.

## Tools

- **neoVim** Latest stable version built from source [neovim](https://github.com/neovim/neovim)
- **uv** Dependency management tool for Python projects [uv](https://github.com/astral-sh/uv/)
- **lazyVim** A highly optimized Vim-like editor for Neovim [lazyvim](https://www.lazyvim.org/)
- **crewAI** Platform for Multi AI Agents Systems [official CrewAI documentation](https://docs.crewai.com/)

## Versions

[Available Versions](https://hub.docker.com/r/sageil/crewai/tags)

- **crewAI** 0.80.0 **crewai-tools** 0.14.0
- **crewAI** 0.79.4 **crewai-tools** 0.14.0
- **crewAI** 0.76.9 **crewai-tools** 0.13.4
- **crewAI** 0.76.2 **crewai-tools** 0.13.2
- ~~**crewAI** 0.74.1 **crewai-tools** 0.13.2~~
- ~~**crewAI** 0.70.1 **crewai-tools** 0.12.1~~
- ~~**crewAI** 0.65.2 **crewai-tools** 0.12.1~~
- ~~**crewAI** 0.64.0 **crewai-tools** 0.12.1~~
- ~~**crewAI** 0.61.0 **crewai-tools** 0.12.1~~
- ~~**crewAI** 0.55.2 **crewai-tools** 0.8.3~~
- ~~**crewAI** 0.51.0 **crewai-tools** 0.8.3~~
- ~~**crewAI** 0.41.1 **crewai-tools** 0.4.26~~
- ~~**crewAI** 0.36.0 && **crewai-tools** 0.4.26~~

## Tips

- v: `alias v='nvim` & `alias vim='nvim'`
- Running `newcrew <project_name>` will create a new crew project with the provided name, install dependencies and configure the project virtual environment.
- You can restart a container after stopping it by using `docker container start -ai <container-name>`

## Example

[Veterinary Assistant Crew](https://github.com/sageil/veterinary_assistant)

## ScreenCaptures

![Editor](assets/nvim-main.png)
![Code](assets/code-action.png)

## Issues

Known issues:

1. Copying from nvim fails due to display driver
2. Icon fonts are not rendered correctly in the container's terminal? [Watch](https://www.youtube.com/watch?v=mQdB_kHyZn8). if the video peaked your interest in [Wezterm](https://wezfurlong.org/wezterm/index.html), you can use my configuration from [Wezterm configs](https://github.com/sageil/wezterm)

New Issues:

Please report other issues you encounter on the [Issues](https://github.com/sageil/crewai-docker-image/issues) including steps to reproduce them.

## License

This project is licensed under the [MIT License](https://github.com/sageil/crewai-docker-image/blob/main/LICENSE.md).
