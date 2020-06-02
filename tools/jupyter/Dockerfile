FROM jupyter/datascience-notebook

LABEL maintainer="Fjodor Schaefer <fjodor@schefa.com>"

COPY requirements.txt /tmp
#COPY jupyter_notebook_config.py /etc/jupyter/

RUN pip install -U pip 
RUN pip install -r /tmp/requirements.txt

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER