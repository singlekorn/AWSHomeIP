# Official Python image
FROM python:3.11-rc-alpine

ENV PACKAGES \
  tzdata

COPY requirements.txt ./

RUN apk update && apk upgrade && \
    apk add --no-cache ${PACKAGES} && \
    pip install --no-cache-dir -r requirements.txt

RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN echo '*/1  *  *  *  *    /opt/update.sh' > /etc/crontabs/root

WORKDIR /opt
COPY ./scripts/ . 

# ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "sh" ]