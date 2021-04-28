const mysql = require('mysql')

let connection = mysql.createConnection({
    host: "mysql-sunland.alwaysdata.net",
    user: "sunland",
    password: "Metallica7793290$$",
    database: "sunland_educhecktest",
    insecureAuth: true,
});


connection.connect( (err) => {
    if(err) throw err
    console.log("BDD CONNECTER")
})



module.exports = connection;