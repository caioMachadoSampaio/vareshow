const http = require('http');
const express = require('express');
const app = express();
app.use(express.json());
const porta = 5000;
app.set('port', porta);
let contador =0;

let id = 1;

let estoque = [{
        id: Number,
        Nome: String,
        Quantidade: Number,
        Descricao: String,
        Categoria: String,
        Preco: Number,
        id_lojista: Number,
    },

    /*
      referenciasLojista: "Ponto Frio",
      produto: "Televisão",
      tipo: "oled",
      unidadesAdquiridas: 10,
      saida: 5,
      controle: unidadesAdquiridas - saida,
      */
];
let estoque_ativo = [];

app.get("/estoque", (req, res, next) => {
    res.json(estoque);
});

app.post("/estoque", (req, res, next) => {
    const estoque_ativo = req.body;
    estoque.push({
        id: contador += 1,
        Nome: estoque_ativo.Nome,
        Quantidade: estoque_ativo.Quantidade,
        Descricao: estoque_ativo.Descricao,
        Categoria: estoque_ativo.Categoria,
        Preco: estoque_ativo.Preco,
        id_lojista: estoque_ativo.id_lojista
    });
    console.log(estoque);
    res.status(201).json(estoque)
})

app.put("/estoque/:id", (req, res, next) => {
    const idEstoqueAlterado = req.params.id;
    console.log(req.body);
    estoque.forEach((estoque) => {
        if(estoque.id == idEstoqueAlterado){
            estoque.Nome = req.body.Nome;
            estoque.Quantidade = req.body.Quantidade;
            estoque.Descricao = req.body.Descricao;
            estoque.Categoria = req.body.Categoria;
            estoque.Preco = req.body.Preco;
        }
        }
    )
    res.status(200).json(estoque);
})

/*
app.delete("/estoque", (req, res, next) => {
    estoque.forEach((estoque_ativo) => {
        if (estoque_ativo.id != req.body.id) {
            const estoque_ativo = {
                id: estoque_ativo.id,
                minimoEstoque: estoque_ativo.minimoEstoque,
                referenciasLojista: estoque_ativo.referenciasLojista,
                produto: estoque_ativo.produto,
                tipo: estoque_ativo.tipo,
                unidadesAdquiridas: estoque_ativo.unidadesAdquiridas,
                saida: estoque_ativo.saida,
                total: estoque_ativo.total,
            };
            estoque_ativo.push(estoque_ativo);
        }
    });
    estoque = estoque_ativo;
    res.status(204).end();
});
*/

app.delete('/estoque/:id', (req, res, next) => {
    const idEstoqueDelete = req.params.id;
    estoque.forEach((estoques, index) => {
        if (estoques.id == idEstoqueDelete) estoque.splice(index, 1)
    })
    res.status(200).json(estoque);
})


const server = http.createServer(app);
    server.listen(5000);