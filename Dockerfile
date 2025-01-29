# Use jupyter pytorch notebook with cuda as base image for llm with gpu acceleration
ARG BASE_IMAGE_NAME=quay.io/jupyter/pytorch-notebook
ARG BASE_IMAGE_TAG=cuda12-python-3.11.8

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG} AS base

# Root user for installing ollama cli
USER root

# Install ollama cli
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#RUN curl -fsSL https://ollama.com/install.sh | sh
#RUN ollama --version

# Change to env variable user
USER ${NB_USER}

# Set work directory 
WORKDIR /home/${NB_USER}

# Update pip if necessary
RUN pip install --no-cache-dir --upgrade pip

# Install the required python libraries 
RUN pip install --no-cache-dir \
    llama-index \
    ollama \
    duckdb

# Expose default jupyter port
EXPOSE 8888