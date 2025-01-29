# Use jupyter pytorch notebook with cuda as base image for llm with gpu acceleration
ARG BASE_IMAGE_NAME=quay.io/jupyter/pytorch-notebook
ARG BASE_IMAGE_TAG=cuda12-python-3.11.8

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG} AS base

# Root user for installing ollama cli
USER root

# Shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Ollama CLI and check version
RUN curl -fsSL https://ollama.com/install.sh | sh && \
    ollama --version

# Change to env variable user
USER ${NB_USER}

# Set work directory 
WORKDIR /home/${NB_USER}

# Update pip and install dependencies/python libraries
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    llama-index \
    ollama \
    duckdb

# Expose default jupyter port
EXPOSE 8888