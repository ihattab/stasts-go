FROM golang:alpine as builder

RUN apk update && \
    apk add --no-cache git

ENV GO111MODULE=on

WORKDIR /go/src/github.com/gobuffalo/gobuffalo/

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o /bin/app .

FROM alpine
RUN apk add --no-cache bash  --no-cache ca-certificates  rm -rf /var/cache/apk/*

COPY --from=builder /bin/app /bin/app

EXPOSE 3000

CMD ["/bin/app"]