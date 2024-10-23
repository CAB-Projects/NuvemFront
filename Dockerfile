# Etapa 1: Construir o projeto Flutter
FROM cirrusci/flutter:stable AS build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o arquivo de dependências e instalar
COPY pubspec.yaml .
RUN flutter pub get

# Copiar o código fonte do projeto
COPY . .

# Construir o projeto para a web
RUN flutter build web --release

# Etapa 2: Configurar o NGINX para servir o app Flutter
FROM nginx:alpine

# Remover a configuração padrão do NGINX
RUN rm /etc/nginx/conf.d/default.conf

# Copiar a configuração customizada do NGINX
COPY nginx.conf /etc/nginx/conf.d/

# Copiar o build da etapa anterior para o diretório do NGINX
COPY --from=build /app/build/web /usr/share/nginx/html

# Expor a porta onde o NGINX vai rodar
EXPOSE 80

# Iniciar o NGINX
CMD ["nginx", "-g", "daemon off;"]
