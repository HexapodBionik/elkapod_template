FROM ubuntu:24.04

SHELL ["/bin/bash", "-lc"]

WORKDIR /ws/

# Install other some dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    ccache \
    clang \
    git \
    libboost-all-dev \
    libtbb-dev \
    gdb \
    nano \
    curl \
    ca-certificates \
    python3-pip \
    python3.12-venv \
    clang-format \
    && rm -rf /var/lib/apt/lists/*

ENV VIRTUAL_ENV=/ws/.venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install ruff

# Colors in terminal
RUN echo 'source /usr/lib/git-core/git-sh-prompt 2>/dev/null' >> ~/.bashrc && \
    echo "PROMPT_COMMAND='PS1_CMD1=\$(__git_ps1 \" (%s)\")'" >> ~/.bashrc && \
    echo 'export PS1="\[\033[01;32m\]\u@\H\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]\${PS1_CMD1}\[\033[00m\]$ "' >> ~/.bashrc

RUN echo "source $VIRTUAL_ENV/bin/activate" >> /root/.bashrc
CMD ["bash"]