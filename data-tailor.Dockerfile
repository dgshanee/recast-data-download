FROM anaconda/miniconda

RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

RUN conda create -c conda-forge -y -n env python=3.12 eumetsat::epct eumetsat::epct_restapi \
  eumetsat::epct_webui

SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "env", "epct_webui"]

# ENV PATH=/opt/miniconda3/envs/env/bin:$PATH
#
# RUN epct_webui
