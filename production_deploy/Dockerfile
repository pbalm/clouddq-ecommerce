
# Use the offical golang image to create a binary.
# This is based on Debian and sets the GOPATH to /go.
# https://hub.docker.com/_/golang
FROM golang:1.14-buster as builder

# Create and change to the app directory.
WORKDIR /app

# Retrieve application dependencies.
# This allows the container build to reuse cached dependencies.
# Expecting to copy go.mod and if present go.sum.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY invoke.go ./

# Build the binary.
RUN go build -mod=readonly -v -o server

# Use the official Debian slim image for a lean production container.
# https://hub.docker.com/_/debian
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM debian:11-slim

RUN set -x

# Python install etc
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq \
        --no-install-recommends \
        curl git wget make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
        libffi-dev liblzma-dev  \
        zip unzip git python3-distutils python3-apt \
        ca-certificates && \
        rm -rf /var/lib/apt/lists/*

#COPY ./scripts .
#RUN ./install_python3.sh "3.9.7"

# Install gcloud CLI
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Start Go server

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /app/server
COPY ./run_clouddq_prod.sh ./script.sh

# Run the web service on container startup.
CMD ["/app/server"]
