const connection = require('../bin/bdd')
const bcrypt = require('bcrypt')


const jwt = require('jsonwebtoken')
const fs = require('fs')



class Model {


    static register(username,pwd,firstname,name,cb) {
        const hash = bcrypt.hashSync(pwd, 10);
        connection.query("INSERT INTO user (username,pwd,firstname,name) VALUES (?,?,?,?)",[username,hash,firstname,name],
            (err,row) => {
                if(err) throw err
                cb(row.insertId)
            })
    }


    static login(username,cb){
        connection.query("SELECT * FROM user WHERE username=?" , [username] , (err,row) => {
            if(err) throw err
            cb(row[0])
        })
    }

    static createToken(id,username){
        let private_key = fs.readFileSync('./private.key')
        return jwt.sign(id+username,private_key,{algorithm: 'RS256'})
    }



}


module.exports = Model;