FROM anaconda/miniconda

RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

RUN conda install -y -c conda-forge --override-channels eumetsat::eumdac eumetsat::epct_plugin_umarf

ARG DATA_RETRIEVAL_MAX_JOBS

WORKDIR /scripts

ENTRYPOINT ["./seviri_download_parallel.sh", "/bin/bash", "-c"]
