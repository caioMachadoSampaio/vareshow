const http = require('http');
const express = require('express');
const app = express();
app.use(express.json());
const porta = 4000;
app.set('port', porta);
let contador =0;

let cliente = [
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
        cliente.push({id: contador += 1, 
            Nome: clientes.Nome, 
            Telefone: clientes.Telefone, 
            Email: clientes.Email, 
            CEP: clientes.CEP,
            Endereco: clientes.Endereco,
            Numero: clientes.Numero,  
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
                cliente.CEP = req.body.CEP;
                cliente.Endereco = req.body.Endereco;
                cliente.Numero = req.body.Numero;
                cliente.CPF = req.body.CPF;
                cliente.Senha = req.body.Senha;
            }
            }
        )
        res.status(200).json(cliente);
    })
 
    


    app.delete('/cliente/:id', (req, res, next) => {
        const idClienteDelete = req.params.id;
        cliente.forEach((clientes, index) => {
            if (clientes.id == idClienteDelete) cliente.splice(index, 1)
        })
        res.status(200).json(cliente);
    })



    const server = http.createServer(app);
    server.listen(4000);