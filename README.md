# LLM Analytics Workspace
A GPU accelerated workspace designed for Large Language Model (LLM) research.

## Running Locally
### Prerequisites 
Ensure the following are installed before running the workspace locally:
- [Nvidia Toolkit](https://developer.nvidia.com/cuda-toolkit)
- [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Docker Desktop](https://app.docker.com/) (Enable WSL Integration under Docker settings → Resources → WSL Integration)

### 1. Clone The Repository
``` 
git clone https://github.com/lsc-sde/docker-llm-workspace.git
cd docker-llm-workspace
``` 

### 2. Build The Docker Image
``` 
docker build -t llm-workspace .
``` 

### 3. Run The Container With GPU Support
``` 
docker run --gpus all -it -p 8888:8888 llm-workspace
``` 

### 4. Access Jupyter Notebook
Once the container starts, open the JupyterLab in your browser (token can be found in the terminal):
``` 
http://127.0.0.1:8888/lab?token=[TOKEN]
``` 

### 5. Verify GPU Access
Inside Jupyter Notebook, run:
``` 
!nvidia-smi
``` 