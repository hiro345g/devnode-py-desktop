FROM mcr.microsoft.com/devcontainers/typescript-node:18-bullseye

COPY ./menu /home/node/.fluxbox/menu
COPY ./startup /home/node/.fluxbox/startup
COPY ./node.dot.bashrc /home/node/.bashrc

RUN apt-get update && apt-get -y upgrade \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install task-japanese fonts-vlgothic firefox-esr-l10n-ja chromium chromium-l10n ibus bash-completion iproute2 iputils-ping dnsutils \
    && sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen \
    && rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && mkdir -p /home/node/repo /home/node/.vscode-server/extensions \
    && chown -R node:node /home/node/repo /home/node/.vscode-server /home/node/.fluxbox /home/node/.bashrc
