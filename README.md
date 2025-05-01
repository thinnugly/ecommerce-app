# Compras por Aplicativo

Este projeto representa uma aplicação de compras desenvolvida como parte da unidade curricular **Desenvolvimento de Aplicações Móveis**, do curso de **Mestrado em Engenharia Informática e Tecnologia Web**.

## Autores

- Renato Madeia Muiambo  <renatomuiambo24@gmail.com>
- Alberto Fanheiro

## Tecnologias Utilizadas

- Node.js  
- Express  
- MongoDB (com Mongoose)  
- Multer  
- Swagger (para documentação da API)

## Estrutura de Pastas

```bash
Comprasporplicativo/backend
│
├── config/
│   └── app.config.js
│
├── controllers/
│   └── categories.controller.js
│
├── middleware/
│   ├── errors.js
│   └── category.upload.js
│
├── models/
│   └── category.model.js
│
├── routes/
│   └── app.routes.js
│
├── services/
│   └── category.service.js
│
├── uploads/
│   ├── categories/
│   └── productos/
│
├── swagger.json
├── index.js
├── .env
└── .env.example
```

## Requisitos

- [Node.js](https://nodejs.org/) v18 ou superior  
- [MongoDB](https://www.mongodb.com/try/download/community) instalado e rodando localmente ou em ambiente configurado  
- npm (gerenciador de pacotes do Node.js)

## Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/thinnugly/ecommerce-app.git
   cd comprasporplicativo/backend
   ```

2. Instale as dependências:
   ```bash
   npm install
   ```

### Configuração do Ambiente

3. Crie um arquivo `.env` na raiz do projeto com base no arquivo `.env.example`.  
   Substitua o valor da variável `MONGO_DB_URI` pela string de conexão apropriada, por exemplo:

   ```env
   MONGO_DB_URI=mongodb://localhost/ecommerce-app
   ```

### Executar o Servidor

4. Inicie o servidor:
   ```bash
   npm run start
   ```

A API estará disponível em:  
📍 `http://localhost:4000`

## Documentação da API

Após iniciar o servidor, a documentação da API estará disponível via Swagger em:  
📄 `http://localhost:4000/api-docs`

## Observações

- Certifique-se de que o MongoDB esteja ativo e acessível pela URI definida no arquivo `.env`.
- As imagens enviadas via upload são armazenadas nas pastas:
  - `uploads/categories/`
  - `uploads/productos/`

---

> Projeto acadêmico – 2025 | Mestrado em Engenharia Informática e Tecnologia Web