var express = require('express');
var router = express.Router();
var model = require('../Modele/Model')
var bcrypt = require('bcrypt')

router.post('/register', (req, res, next) => {

    let username = req.body.username
    let password = req.body.password
    let firstname = req.body.firstname
    let name = req.body.name


    model.register(username, password, firstname, name, (id) => {
        if (id !== undefined) {
            res.status(200).json({
                id_usr: id
            })
        } else {
            res.sendStatus(500)
        }
    })

})


router.post('/login', (req, res) => {

    let username = req.body.username
    let password = req.body.password

    model.login(username,(data) => {

        if(bcrypt.compareSync(password,data.pwd)){
            let token = model.createToken(data.id_usr,data.username)
            res.status(200).json({
                id_usr: data.id_usr,
                token: token,
                username: data.username,
                firstname: data.firstname,
                name: data.name
            })
        }
    })
})

module.exports = router;
