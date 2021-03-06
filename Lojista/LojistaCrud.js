const http = require('http');
const express = require('express');
const app = express();
app.use(express.json());
const porta = 3000;
app.set('port', porta);
let contador =0;
const lojista = [
    {
        id: Number, 
        CNPJ: String,
        Telefone: Array, 
        Email: String,
        Endereco: Array,
        Nome_fantasia: String,
        Razao_social: String,
        Senha: String
    },
];
    app.set('port', porta);
    app.get('/lojista', (req, res, next) => {
        res.json(lojista);
    })

    app.post('/lojista', (req, res, next) => {
        const lojistas = req.body;
        lojista.push({id: contador += 1, 
            Telefone: lojistas.Telefone, 
            Email: lojistas.Email,
            Endereco: lojista.Endereco,   
            CNPJ: lojistas.CNPJ,
            Nome_fantasia: lojistas.Nome_fantasia, 
            Razao_social: lojistas.Razao_social, 
            Senha: lojistas.Senha}); 
            console.log(lojistas);
        res.status(201).json(lojista)
    })

    app.put("/lojista/:id", (req, res, next) => {
        const idlojistaAlterado = req.params.id;
        console.log(req.body);
        lojista.forEach((lojista) => {
            if(lojista.id == idlojistaAlterado){
                lojista.Telefone = req.body.Telefone;
                lojista.Email = req.body.Email;
                lojista.Endereco = req.body.Endereco;
                lojista.CNPJ = req.body.CNPJ;
                lojista.Nome_fantasia = req.body.Nome_fantasia;
                lojista.Razao_social = req.body.Razao_social;
                lojista.Senha = req.body.Senha;
            }
            }
        )
        res.status(200).json(lojista);
    })
 
    app.delete('/lojista/:id', (req, res, next) => {
        const idLojistaDelete = req.params.id;
        lojista.forEach((lojistas, index) => {
            if (lojistas.id == idLojistaDelete) lojista.splice(index, 1)
        })
        res.status(200).json(lojista);
    })

    const server = http.createServer(app);
    server.listen(3000);