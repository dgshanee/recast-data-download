FROM anaconda/miniconda

RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

RUN conda create -c conda-forge -y -n env python=3.12 eumetsat::epct eumetsat::epct_restapi \
  eumetsat::epct_webui eumetsat::eumdac eumetsat::epct_plugin_umarf

RUN apt-get update && apt-get install -y curl

ENTRYPOINT conda run --no-capture-output -n env epct_webui
