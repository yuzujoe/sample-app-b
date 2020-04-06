FROM golang:1.13 as builder

ENV GO111MODULE=on

WORKDIR /app/

COPY go.mod .
COPY go.sum .

RUN go mod download
COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o ./build/gitops ./main.go

FROM alpine:3.10

EXPOSE 8080
RUN apk update \
  && apk --no-cache add tzdata \
  && apk add --no-cache ca-certificates

ENV GIN_MODE=release
COPY --from=builder /app/build /app/build

ENTRYPOINT ["app/build/gitops"]
