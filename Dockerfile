FROM python:3.13-slim-trixie

ARG TARGETPLATFORM
ARG RELEASE_DATE
ARG CREWAI=1.14.7
ARG APP_USER=appuser
ARG APP_UID=1000
ARG APP_GID=1000

ENV DEBIAN_FRONTEND=noninteractive \
    UV_NO_PROGRESS=1 \
    DISPLAY=:0 \
    P=default_crew \
    PATH="/home/${APP_USER}/.local/bin:/home/${APP_USER}/.local/node/bin:${PATH}"

LABEL crewai.version="${CREWAI}" \
      crewai-tools.version="${CREWAI}" \
      maintainedby="Sammy Ageil" \
      release-date="${RELEASE_DATE}"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bash \
      bash-completion \
      build-essential \
      ca-certificates \
      curl \
      git \
      fzf \
      jq \
      luarocks \
      nodejs \
      npm \
      ripgrep \
      tar \
      wget \
      xclip \
      unzip && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "${APP_GID}" appgroup && \
    useradd --uid "${APP_UID}" --gid "${APP_GID}" --create-home --shell /usr/bin/bash "${APP_USER}"

COPY install-tools.sh /tmp/install-tools.sh
RUN chmod +x /tmp/install-tools.sh && \
    /tmp/install-tools.sh "${TARGETPLATFORM}" && \
    rm -f /tmp/install-tools.sh

WORKDIR /home/${APP_USER}
COPY --chown=${APP_USER}:${APP_USER} entrypoint.sh /entrypoint.sh
COPY --chown=${APP_USER}:${APP_USER} shell_venv.sh /shell_venv.sh
COPY --chown=${APP_USER}:${APP_USER} add_crew.sh /add_crew.sh
RUN chmod +x /entrypoint.sh /shell_venv.sh /add_crew.sh

USER ${APP_USER}
RUN mkdir -p "/home/${APP_USER}/.local/bin" "/home/${APP_USER}/.local/node/bin"

RUN npm config set prefix "/home/${APP_USER}/.local/node" && \
    npm install -g --silent tree-sitter-cli fd-find

WORKDIR /home/${APP_USER}/apps
RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && uv pip install --prefix "/home/${APP_USER}/.local/" \
      crewai==${CREWAI} crewai-tools==${CREWAI} --no-cache-dir \
    && printf "%s\n" \
      "source /add_crew.sh" \
      "alias v='nvim'" \
      "alias vim='nvim'" \
      "alias lg='lazygit'" \
      "source /shell_venv.sh" >> /home/${APP_USER}/.bashrc

RUN git clone https://github.com/LazyVim/starter /home/${APP_USER}/.config/nvim && \
    rm -rf /home/${APP_USER}/.config/nvim/.git

COPY --chown=${APP_USER}:${APP_USER} options.lua /home/${APP_USER}/.config/nvim/lua/config/options.lua
COPY --chown=${APP_USER}:${APP_USER} which-key.lua /home/${APP_USER}/.config/nvim/lua/plugins/which-key.lua
COPY --chown=${APP_USER}:${APP_USER} toggle-term.lua /home/${APP_USER}/.config/nvim/lua/plugins/toggle-term.lua
COPY --chown=${APP_USER}:${APP_USER} lazyvim.json /home/${APP_USER}/.config/nvim/lazyvim.json

RUN timeout 200s nvim || true

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
