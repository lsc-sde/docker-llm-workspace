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

# Copy environment.yaml and 
COPY environment.yaml environment.yaml
RUN mamba env update --name base --file environment.yaml && \
    rm environment.yaml && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Change to env variable user
USER ${NB_USER}

# Set work directory 
WORKDIR /home/${NB_USER}

# Expose default jupyter port
EXPOSE 8888