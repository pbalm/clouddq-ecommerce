FROM debian:11-slim

WORKDIR .

# install python3
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq curl git wget make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev  \
        zip unzip git python3-distutils python3-apt

COPY scripts .
RUN ./install_python3.sh "3.9.7"

# test it
RUN python3 --version

# Install gcloud CLI
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# test it
RUN gcloud --help | cat

# execute CloudDQ when running the container
CMD ./run_clouddq_prod.sh
