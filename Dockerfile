# Usa como base a imagem alpine LTS do Node.js, por ser uma alpine ela é focada 
# em segurança e ser leve, evitando ao máximo qualquer overhead no container.
FROM node:lts-alpine

# Cria diretamente os diretórios da aplicação e setamos a propriedade deles para 
# o usuário node.
RUN mkdir -p /home/node/api/node_modules && chown -R node:node /home/node/api

# Seta o diretório de "trabalho" do nosso container.
# Isso define que qualquer instrução, como RUN, CMD, ENTRYPOINT, COPY e ADD 
# serão executadas dentro desse caminho.
WORKDIR /home/node/api

# Tira proveito do armazenamento em cache do Docker, com isso evitamos o 
# download de dependências desnecessários na execução do container.
COPY package.json yarn.* ./

# Seta o usuário.
# Isso define que as instruções RUN, CMD e ENTRYPOINT 
# serão executadas como o usuário node.
USER node

# Instala as dependências.
RUN yarn

# Faz a cópia dos arquivos restantes com as permissões apropriadas.
COPY --chown=node:node . .

# Expõe as portas padrão do container.
EXPOSE 3333 9000

# Executa este comando quando o container é criado, nesse caso executa a aplicação.
CMD ["node", "index"]
