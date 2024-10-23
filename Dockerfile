# Stage 1: Build the Flutter application
FROM ubuntu:22.04 AS builder

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-11-jdk \
    wget \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up Flutter environment
ENV FLUTTER_HOME=/usr/local/flutter
ENV PATH=$FLUTTER_HOME/bin:$PATH

RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz \
    && tar xf flutter_linux_3.24.3-stable.tar.xz -C /usr/local/ \
    && rm flutter_linux_3.24.3-stable.tar.xz \
    && flutter doctor \
    && flutter config --no-analytics \
    && flutter config --enable-web

# Download and setup Flutter SDK
#RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME && \
#    cd $FLUTTER_HOME && \
#    git checkout 3.24.3 && \
#    flutter doctor && \
#    flutter config --no-analytics && \
#    flutter config --enable-web

# Criar um novo usuário não-root
RUN useradd -ms /bin/bash flutteruser

# Set the working directory
WORKDIR /app

# Ajustar permissões para o novo usuário
RUN chown -R flutteruser:flutteruser /app

# Alterar para o novo usuário
USER flutteruser

# Copy the Flutter project files
COPY . .

# Get Flutter dependencies
#RUN flutter pub cache repair
RUN flutter pub get

# Build for web
RUN flutter build web --release

# Stage 2: Serve the application using Nginx
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
