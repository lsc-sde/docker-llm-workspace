# Use jupyter scipy notebook as base image for ml
ARG BASE_IMAGE_NAME=jupyter/scipy-notebook
ARG BASE_IMAGE_TAG=latest

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG} AS base

# Work directory currently inside container - change later
WORKDIR /workspace

# Update pip if necessary
RUN pip install --no-cache-dir --upgrade pip

# Install the required python libraries 
RUN pip install --no-cache-dir \
    llama-index \
    ollama \
    duckdb

# Expose default jupyter port
EXPOSE 8888