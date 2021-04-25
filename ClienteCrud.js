const http = require('http');
const express = require('express');
const app = express();
const bodyParser = require ('body-parser');
app.use (bodyParser.json())
const porta = 4000;
app.set('port', porta);
let contador =0;
const cliente = [
    {
        id: Number, 
        Nome: String, 
        Telefone: String, 
        Email: String,
        Endereco: String,
        Numero: Number,
        CEP: String,
        CPF: String,
        Senha: String,
    },
];
    app.set('port', porta);
    app.get('/cliente', (req, res, next) => {
        res.json(cliente);
    })

    app.post('/cliente', (req, res, next) => {
        const clientes = req.body;
        lojista.push({id: contador += 1, 
            Nome: clientes.Nome, 
            Telefone: clientes.Telefone, 
            Email: clientes.Email, 
            Numero: clientes.Numero, 
            CEP: clientes.CEP, 
            CPF: clientes.CPF,
            Senha: clientes.Senha}); 
            console.log(clientes);
        res.status(201).json(cliente)
    })

    app.put("/cliente/:id", (req, res, next) => {
        const idClienteAlterado = req.params.id;
        console.log(req.body);
        cliente.forEach((cliente) => {
            if(cliente.id == idClienteAlterado){
                cliente.Nome = req.body.Nome;
                cliente.Telefone = req.body.Telefone;
                cliente.Email = req.body.Email;
                cliente.Endereco = req.body.Endereco;
                cliente.Numero = req.body.Numero;
                cliente.CEP = req.body.CEP;
                cliente.Senha = req.body.Senha;
            }
            }
        )
        res.status(200).json(cliente);
    })
 
    app.delete('/cliente/:id', (req,res,next) =>{
        const clientestatus = [];
        contador = 1; 
        const idClieneteDeletado = req.params.id;
        cliente.forEach((cliente, index) =>{
            if(cliente.id != idClienteDeletado){
                
            }
    
        })
        res.status(200).json(cliente);
    })
    const server = http.createServer(app);
    server.listen(4000);