# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    clang \
    make \
    musl-dev \
    cppcheck \
    curl \
    gnupg \
    openjdk-11-jdk \
    git && \
    ln -sf /usr/bin/clang++ /usr/bin/c++ && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app/

# Build the project
RUN make re

EXPOSE 80
