const http = require('http');
const express = require('express');
const app = express();
app.use(express.json());
const porta = 6000;
app.set('port', porta);
const db = require("../ConexaoDB/Conexao.js");


