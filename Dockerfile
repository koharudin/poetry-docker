FROM python:3.11.3-slim-bullseye

ARG VERSION=${VERSION}

RUN  apt-get update -y && \
     apt-get upgrade -y && \
     apt-get dist-upgrade -y && \
     apt-get install -y git && \
     apt-get install -y curl

     # Install Poetry
ENV  PYTHONFAULTHANDLER=1 \
     PYTHONUNBUFFERED=1 \
     PYTHONHASHSEED=random \
     PIP_NO_CACHE_DIR=off \
     PIP_DISABLE_PIP_VERSION_CHECK=on \
     PIP_DEFAULT_TIMEOUT=100 \
     # Poetry's configuration:
     POETRY_NO_INTERACTION=1 \
     POETRY_VIRTUALENVS_CREATE=false \
     POETRY_CACHE_DIR='/var/cache/pypoetry' \
     POETRY_HOME='/usr/local'\
     POETRY_VERSION=1.7.1
RUN curl -sSL https://install.python-poetry.org | python3 - 

WORKDIR /home/belajar/app
COPY app/pyproject.toml app/poetry.lock ./
RUN poetry install 