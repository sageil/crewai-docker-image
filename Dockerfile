FROM python:3.12-slim-bookworm
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
RUN apt-get update -y && apt-get install \
    curl=7.88.1-10+deb12u12 \
    bash-completion=1:2.11-6 \
    ripgrep=13.0.0-4+b2 \
    fzf=0.38.0-1+b1 \
    xclip=0.13-2 \
    tree=2.1.0-1 \
    git=1:2.39.5-0+deb12u2 \
    make=4.3-4.1 \
    cmake=3.25.1-1 \
    build-essential=12.9 \
    libutf8proc-dev=2.8.0-1 \
    gettext=0.21-12 \
    libunibilium-dev=2.1.0-1 \
    gperf=3.1-1 \
    luajit=2.1.0~beta3+git20220320+dfsg-4.1 \
    luarocks=3.8.0+dfsg1-1 \
    libuv1-dev=1.44.2-1+deb12u1 \
    libmsgpack-dev=4.0.0-3 \
    libtermkey-dev=0.22-1 \
    libvterm-dev=0.1.4-1 \
    libtermkey-dev=0.22-1 \
    -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* && \
    groupadd appgroup && useradd -m -s /usr/bin/bash -G appgroup appuser
COPY buildneovim.sh /buildneovim.sh
COPY entrypoint.sh /entrypoint.sh
COPY shell_venv.sh /shell_venv.sh
RUN chmod +x /entrypoint.sh && chmod +x /shell_venv.sh
RUN chmod +x /buildneovim.sh && bash /buildneovim.sh
RUN rm -rf /nvimbuild
COPY add_crew.sh /add_crew.sh
RUN apt-get remove --purge --auto-remove \
    make=4.3-4.1 \
    build-essential=12.9 \
    libutf8proc-dev=2.8.0-1 \
    gettext=0.21-12 \
    libunibilium-dev=2.1.0-1 \
    gperf=3.1-1 \
    luajit=2.1.0~beta3+git20220320+dfsg-4.1 \
    luarocks=3.8.0+dfsg1-1 \
    libuv1-dev=1.44.2-1+deb12u1 \
    libmsgpack-dev=4.0.0-3 \
    libtermkey-dev=0.22-1 \
    libvterm-dev=0.1.4-1 \
    libtermkey-dev=0.22-1 -y && apt-get clean
SHELL [ "ln", "-sf","/usr/bin/bash","bin/sh" ]
USER appuser
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
RUN nvm install 20
RUN mkdir -p "/home/appuser/.local/bin"
ENV PATH="/home/appuser/.local/bin:$PATH"
WORKDIR /app/
RUN chown -R appuser:appgroup "/app/"
SHELL ["/bin/bash", "-c"]
RUN python -m pip install --upgrade pip  && curl -LsSf https://astral.sh/uv/install.sh | sh \
    && pip install crewai==${CREWAI} crewai-tools==${TOOLS} --no-cache-dir && \
    echo "source /add_crew.sh" >> ~/.bashrc && echo "alias v='nvim'" >> ~/.bashrc && \
    echo "alias vim='nvim'" >> ~/.bashrc && echo "source /shell_venv.sh" >> ~/.bashrc
RUN git clone https://github.com/LazyVim/starter /home/appuser/.config/nvim && rm -rf /home/appuser/.config/nvim/.git
COPY options.lua /home/appuser/.config/nvim/lua/config/options.lua
COPY lazy.lua /home/appuser/.config/nvim/lua/config/lazy.lua
COPY treesitter.lua /home/appuser/.config/nvim/lua/plugins/treesitter.lua
COPY mason-workaround.lua /home/appuser/.config/nvim/lua/plugins/mason-workaround.lua
RUN timeout 200s nvim || true
ENTRYPOINT [ "/entrypoint.sh" ]
