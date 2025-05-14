# Use jupyter pytorch notebook with cuda as base image for llm with gpu acceleration
ARG BASE_IMAGE_NAME=quay.io/jupyter/pytorch-notebook
ARG BASE_IMAGE_TAG=cuda12-python-3.12.8

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG} AS base

# Root user for installing ollama cli
USER root

# Shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Ollama CLI and check version
RUN curl -fsSL https://ollama.com/install.sh | sh && \
    ollama --version

# Install Code Server
ARG CODE_VERSION=4.99.3
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v${CODE_VERSION}/code-server_${CODE_VERSION}_amd64.deb -o code-server.deb && \
    apt-get update && \
    apt-get install -y ./code-server.deb && \
    rm code-server.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# VS Code Extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension ms-toolsai.jupyter && \
    code-server --install-extension ms-azuretools.vscode-docker

# Copy environment.yaml
COPY environment.yaml environment.yaml

# Ensure Git is installed within container
RUN apt-get update && apt-get install -y \
    git \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN mamba env update --name base --file environment.yaml && \
    rm environment.yaml && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install PostgreSQL Server
RUN apt-get update && apt-get install -y postgresql && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a default PostgreSQL user and database
RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER jovyan WITH PASSWORD 'password';\"" && \
    su - postgres -c "createdb jovyan -O jovyan"

# Copy and enable the PostgreSQL startup script
COPY start_postgres.sh /usr/local/bin/start-notebook.d/start_postgres.sh
RUN chmod +x /usr/local/bin/start-notebook.d/start_postgres.sh

# Change to env variable user
USER ${NB_USER}

# Set work directory 
WORKDIR /home/${NB_USER}

# Expose jupyter port
EXPOSE 8888
# Expose Code Server port
EXPOSE 8080
#Expose PostgreSQL Port
EXPOSE 5432