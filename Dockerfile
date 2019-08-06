FROM golang:1.12-alpine AS go-build

WORKDIR /go/src/github.com/urlooker/agent
COPY . .
RUN go build

FROM alpine:3.9 AS prod
WORKDIR /app
COPY --from=go-build  /go/src/github.com/urlooker/agent/agent /app/agent
COPY --from=go-build  /go/src/github.com/urlooker/agent/cfg.example.json /app/cfg.json
RUN chmod +x /app/agent
CMD ["/app/agent"]
