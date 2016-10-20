#FROM manastech/crystal
FROM greyltc/archlinux
MAINTAINER Arthur Poulet <arthur.poulet@mailoo.org>

# Install crystal
RUN pacman -Syu --noprogressbar --noconfirm crystal shards llvm35 llvm35-libs clang35 base-devel libxml2 curl wget

# Install shards
WORKDIR /usr/local
#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl git libssl-dev
#RUN curl -Lo bin/shards.gz https://github.com/crystal-lang/shards/releases/download/v0.6.3/shards-0.6.3_linux_x86_64.gz; gunzip bin/shards.gz; chmod 755 bin/shards

# Add this directory to container as /app
ADD . /downloadwx
WORKDIR /downloadwx

# Install dependencies
RUN shards install

# Build our app
RUN crystal build --release src/downloadwx.cr

# Run the tests
#RUN crystal spec

EXPOSE 3000

ENTRYPOINT ./downloadwx --port 3000
