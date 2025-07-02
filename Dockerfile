FROM python:3.12-slim-bookworm
ARG TARGETPLATFORM
ARG RELEASE_DATE
ARG CREWAI
ARG TOOLS
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0
ENV P=default_crew
LABEL crewai.version=${CREWAI}
LABEL crewai-tools.version=${TOOLS}
LABEL maintainedby="Sammy Ageil"
LABEL release-date=${RELEASE_DATE}
RUN apt update -y
RUN apt install curl=7.88.1-10+deb12u12 \
    xclip=0.13-2 \
    git=1:2.39.5-0+deb12u2 \
    bash-completion=1:2.11-6 \
    ripgrep=13.0.0-4+b2 \
    build-essential=12.9 \
    bash=5.2.15-2+b8 \
    build-essential \
    unzip=6.0-28 \
    luarocks=3.8.0+dfsg1-1 \
    wget=1.21.3-1+deb12u1 -y

COPY ./install-tools.sh .
RUN  groupadd appgroup && useradd -m -s /usr/bin/bash -G appgroup appuser
RUN chmod +x ./install-tools.sh
RUN ./install-tools.sh "${TARGETPLATFORM}"
COPY entrypoint.sh /entrypoint.sh
COPY shell_venv.sh /shell_venv.sh
RUN chmod +x /entrypoint.sh && chmod +x /shell_venv.sh
COPY add_crew.sh /add_crew.sh
USER appuser
RUN mkdir -p "/home/appuser/.local/bin"
ENV PATH="/home/appuser/.local/bin:$PATH"
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN nvm install --lts
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
RUN npm install -g npm@latest && npm install -g fd-find
WORKDIR /home/appuser/app
SHELL ["/bin/bash", "-c"]
RUN python -m pip install --upgrade pip  && curl -LsSf https://astral.sh/uv/install.sh | sh \
    && uv pip install --prefix "/home/appuser/.local/" crewai==${CREWAI} crewai-tools==${TOOLS} --no-cache-dir && \
    echo "source /add_crew.sh" >> ~/.bashrc && echo "alias v='nvim'" >> ~/.bashrc && \
    echo "alias vim='nvim'" >> ~/.bashrc && echo "alias lg='lazygit'" >> ~/.bashrc && echo "source /shell_venv.sh" >> ~/.bashrc
RUN git clone https://github.com/LazyVim/starter /home/appuser/.config/nvim && rm -rf /home/appuser/.config/nvim/.git

COPY --chown=appuser options.lua /home/appuser/.config/nvim/lua/config/options.lua
COPY --chown=appuser which-key.lua /home/appuser/.config/nvim/lua/plugins/whick-key.lua
COPY --chown=appuser toggle-term.lua /home/appuser/.config/nvim/lua/plugins/toggle-term.lua
COPY --chown=appuser lazyvim.json /home/appuser/.config/nvim/lazyvim.json
RUN timeout 200s nvim || true
ENTRYPOINT [ "/entrypoint.sh" ]
