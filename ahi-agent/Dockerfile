FROM mcr.microsoft.com/powershell:lts-7.2-alpine-3.14

RUN pwsh -Command Install-Module -Name AWS.Tools.Common -Force
RUN pwsh -Command Install-Module -Name AWS.Tools.EventBridge -Force

RUN echo '*/1  *  *  *  *    /opt/update.sh' > /etc/crontabs/root
RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
WORKDIR /opt
COPY ./scripts/ . 

ENTRYPOINT [ "/opt/entrypoint.sh" ]
# CMD [ "sh" ]