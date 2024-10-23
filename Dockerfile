# Stage 1: Build the Flutter application
FROM debian:bullseye-slim AS builder

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    wget \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN groupadd -r flutter && useradd -r -g flutter -m -d /home/flutter flutter

# Set up Flutter environment
ENV FLUTTER_HOME=/home/flutter/sdk
ENV PATH=$FLUTTER_HOME/bin:$PATH

# Download Flutter SDK as non-root user
USER flutter
RUN mkdir -p $FLUTTER_HOME && \
    wget -O flutter.tar.xz "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz" && \
    tar -xf flutter.tar.xz --strip-components=1 -C $FLUTTER_HOME && \
    rm flutter.tar.xz

# Configure Flutter
RUN cd $FLUTTER_HOME && \
    git config --global --add safe.directory $FLUTTER_HOME && \
    flutter config --no-analytics && \
    flutter config --enable-web && \
    flutter doctor -v

# Set the working directory
WORKDIR /home/flutter/app

# Copy the Flutter project files with correct ownership
COPY --chown=flutter:flutter . .

# Get Flutter dependencies and build
RUN flutter pub get && \
    flutter build web --release

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Copy the built Flutter web app to Nginx's serve directory
COPY --from=builder /home/flutter/app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]