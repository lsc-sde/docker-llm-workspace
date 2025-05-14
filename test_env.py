# test_env.py
# Used to verify dependencies in environment.yaml file are installed correctly

print("Starting environment check...")

try:
    import mkdocs
except ImportError:
    print("uv not found")

# Conda dependencies
import jupyterlab
import pydantic
import sqlalchemy
import ibis
import psycopg2
import duckdb
import yaml
import pydantic_settings
import loguru
import rich
import pytest
import pytest_asyncio
import black
import isort
import pre_commit
import mkdocs

# Environment config
from dotenv import load_dotenv

# Pip dependencies 
import jupyter_server_proxy
import jupyter_vscode_proxy
import mcp
import fastapi
import uvicorn
import httpx
import jose
import passlib
import ruff
import ollama
import llama_index
import openai

# GitHub installs — test if present
try:
    import uv  # astral-sh/uv       #temporarily removed
except ImportError:
    print("uv not found")

try:
    import prefixPythonPackage  # A2A GitHub project
except ImportError:
    print("A2A module not found")

print("All dependencies imported successfully.")