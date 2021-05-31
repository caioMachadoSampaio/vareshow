const http = require('http');
const express = require('express');
const app = express();
app.use(express.json());
const porta = 10000;
app.set('port', porta);



const mysql = require('mysql');

const con = mysql.createConnection({
    host: 'localhost', 
    user: 'Vareshow', 
    password: '12345', 
    database: 'vareshow' 
});

con.connect((err) => {
    if (err) {
        console.log('Erro connecting to database...', err)
        return
    }
    console.log('Connection established!')
})

con.query('SELECT * FROM cliente', (err, rows) => {
  if (err) throw err

  console.log('Authors: ', rows, '\n\n')
})

con.end((err) => {
    if(err) {
        console.log('Erro to finish connection...', err)
        return 
    }
    console.log('The connection was finish...')
})

