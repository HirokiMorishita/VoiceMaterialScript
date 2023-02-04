ARG VARIANT=3.10-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}


RUN apt update && apt install -y ffmpeg

RUN apt install fzf fd-find

RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
RUN dpkg -i ripgrep_13.0.0_amd64.deb

RUN pip install --upgrade pip
RUN pip3 install --user -U demucs
RUN pip3 install git+https://github.com/openai/whisper.git
RUN pip3 install pykakasi natsort