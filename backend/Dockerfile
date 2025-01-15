# Usar a imagem base do Node.js (versão 20)
FROM node:20

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar os arquivos necessários para instalar dependências
COPY package*.json ./

# Instalar as dependências do projeto
RUN npm install

# Copiar o restante dos arquivos do projeto para o contêiner
COPY . .

# Gerar o cliente Prisma
RUN npx prisma generate


# Instalar o script wait-for-it
RUN apt-get update && apt-get install -y wget && \
    wget -O /usr/local/bin/wait-for-it https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /usr/local/bin/wait-for-it

# Expor a porta em que a aplicação será executada
EXPOSE 8000

# Comando para esperar o banco de dados e executar migrações antes de iniciar o servidor
CMD ["sh", "-c", "wait-for-it db:5432 -- npx prisma migrate deploy && npm run dev"]
