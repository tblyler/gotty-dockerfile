FROM golang:1-alpine AS builder

RUN apk add --no-cache git upx
RUN CGO_ENBALED=0 go get -ldflags '-w' github.com/yudai/gotty
RUN mv ${GOPATH}/bin/gotty /bin/ && \
        upx --brute /bin/gotty

FROM alpine:3.7

COPY --from=builder /bin/gotty /bin/gotty

ENTRYPOINT ["/bin/gotty"]
