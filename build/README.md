# Tutorial: Building and Publishing the CrewAI Agents Docker Image to Docker Hub

This tutorial will guide you through the process of building and publishing the CrewAI Agents Docker Image to Docker Hub.

## Prerequisites
- **Docker**: Ensure Docker is installed on your machine. You can download it from the [Docker official website](https://www.docker.com/get-started).
- **Docker Hub Account**: You need an account on Docker Hub to push the image. Sign up [here](https://hub.docker.com/).

## Step 1: Cloning the Repository

1. Open your terminal or command prompt.
2. Clone the repository from GitHub using the following command:
   ```sh
   git clone https://github.com/sageil/crewai-docker-image
   ```
3. Navigate into the cloned repository directory:
   ```sh
   cd crewai-docker-image
   ```

## Step 2: Setting Environment Variables

1. Set the environment variables for the `CREWAI` and `TOOLS` versions you want to use. For example:
   ```sh
   export CREWAI=0.80.0
   export TOOLS=0.14.0
   ```
   Replace `0.80.0` and `0.14.0` with the actual versions you want to use.

## Step 3: Building the Docker Image

1. Build the Docker image by running the following command. Replace `DOCKER_USERNAME` with your Docker Hub username.
   ```sh
   docker build --build-arg CREWAI=${CREWAI} --build-arg TOOLS=${TOOLS} -t DOCKER_USERNAME/crewai-agents . 
   ```
   For example, if your Docker username is `mobydock`, you would run:
   ```sh
   docker build --build-arg CREWAI=${CREWAI} --build-arg TOOLS=${TOOLS} -t mobydock/crewai-agents . 
   ```

## Step 4: Verifying the Docker Image

1. Verify that the Docker image has been created successfully by listing the available images:
   ```sh
   docker image ls
   ```
   You should see output similar to the following:
   ```
   REPOSITORY                          TAG       IMAGE ID       CREATED          SIZE
   mobydock/crewai-agents              latest    1543656c9290   2 minutes ago    1.12GB
   ```

## Step 5: Pushing the Docker Image to Docker Hub

1. Log in to Docker Hub using the following command:
   ```sh
   docker login
   ```
   Enter your Docker Hub username and password when prompted.

2. Push the Docker image to Docker Hub using the following command:
   ```sh
   docker push DOCKER_USERNAME/crewai-agents
   ```
   For example, if your Docker username is `mobydock`, you would run:
   ```sh
   docker push mobydock/crewai-agents
   ```
   Depending on your upload speeds, this may take a moment to complete.

## Conclusion

Congratulations! You have successfully built and published the CrewAI Agents Docker Image to Docker Hub. You can now use this image to create and run CrewAI agents in a consistent and isolated environment.

For more information on how to use the CrewAI Agents Docker Image, refer to the [README.md](README.md) file.


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
  
### Conclusion
The CrewAI Agents Docker Image is a powerful and flexible development environment designed for creating and running CrewAI agents. It provides a consistent and isolated environment with a rich set of tools and dependencies, making it easy for developers to get started with AI-driven projects. The project's features and technical specifications ensure a smooth and efficient development workflow, from project setup to code execution and AI integration. The addition of the `tutorial.md` file further enhances the documentation, providing a detailed guide on how to build and publish the Docker image to Docker Hub.
