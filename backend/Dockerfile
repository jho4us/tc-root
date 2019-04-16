############################
# Multi stage build:
# 1. build binary
############################
#FROM golang:alpine AS builder
FROM golang@sha256:1a5f8b6db670a7776ce5beeb69054a7cf7047a5d83176d39b94665a54cfb9756 AS builder

# Install git + SSL ca certificates.
# Git is required for fetching the dependencies.
# Ca-certificates is required to call HTTPS endpoints.
RUN apk update && apk add --no-cache git ca-certificates tzdata make && update-ca-certificates

# Create tcuser.
RUN adduser -D -g '' tcuser

COPY tc /go/src/github.com/jho4us/tc

WORKDIR /go/src/github.com/jho4us/tc

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 STATIC=1 make install

############################
# 2. build small image
############################
FROM scratch

# Import the user and group files from the builder.
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

# Copy our static executable.
COPY --from=builder /go/bin/tc /go/bin/tc
COPY --from=builder /go/bin/*.json /go/bin/

# Use an unprivileged user.
USER tcuser

# Run the binary.
ENTRYPOINT ["/go/bin/tc"]

EXPOSE 3001
