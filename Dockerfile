FROM golang:alpine as builder

RUN apk update && \
    apk add --no-cache git bash

COPY . /go/src/gitlab.webtv-solution.com/webtvpro/jitsi_meet_config_api
WORKDIR /go/src/gitlab.webtv-solution.com/webtvpro/jitsi_meet_config_api

RUN go get
RUN go get github.com/gravityblast/fresh

CMD ["fresh"]