var express = require('express');
var router = express.Router();

const model = require('../../model/Model')
const jwt = require('jsonwebtoken')
const TOKEN = require('../../bin/token.json').TOKEN_SECRET

// a middleware function with no mount path. This code is executed for every request to the router and check TOKEN ACCESS
router.use(function authenticateToken(req, res, next) {


    // Gather the jwt access token from the request header
    const authHeader = req.headers['authorization']
    const token = authHeader

    if (token == null) return res.sendStatus(401) // if there isn't any token
    jwt.verify(token, TOKEN, (err, user) => {
        if (err) return res.sendStatus(403)
        req.user = user
        next() // pass the execution off to whatever request the client intended
    });
});


//<------------------------- UsualFiche ressouces -------------------------------------------->

router.post('/usual', (req, res) => {
    let data = req.body
    model.insertUsualFiche(data, () => {
        res.sendStatus(201)
    })
})

router.get('/usual', (req, res) => {
    let filter = req.query.filter
    if (filter !== undefined) {
        model.getAllUsualFicheFilter(filter, (data) => {
            res.status(200).json(data)
        })
    } else {
        model.getAllUsualFiche((data) => {
            res.status(200).json(data)
        })
    }

})

router.get('/usual/:id',(req, res) => {
    let id_class = req.params.id
    model.getUsualFiche(id_class,(data) => {
        res.status(200).json(data)
    })
})

router.patch('/usual/:id_class/:id_subject',(req, res) => {
    let id_class = req.params.id_class
    let id_subject = req.params.id_subject
    let data = req.body
    model.updateUsualFiche(id_class,id_subject,data,() => {
        res.sendStatus(200)
    })
})

router.delete('/usual/:id_class/:id_subject',(req,res) => {
    let id_class = req.params.id_class
    let id_subject = req.params.id_subject
    model.deleteUsualFiche(id_class,id_subject,() => {
        res.sendStatus(204)
    })
})



//<--------------------- Allocate resource -------------------------->

router.get('/allocate' , (req,res) => {
    let filter = req.query.filter
    if(filter !== undefined){
        model.getAllAllocateFicheFilter(filter,(data) => {
            res.status(200).json(data)
        })
    }else{
        model.getAllAllocateFiche((data) => {
            res.status(200).json(data)
        })
    }
})

router.get('/allocate/:id' , (req, res) => {
    let id_class = req.params.id
    model.getAllocateFiche(id_class,(data) => {
        res.status(200).json(data)
    })
})


router.post('/allocate', (req, res) => {
    let data = req.body
    model.insertAllocateFiche(data,() => {
        res.sendStatus(201)
    })
})


router.patch('/allocate',(req, res) => {
    let data = req.body
    console.log(data)
    model.updateAllocateFiche( data,() => {
        res.sendStatus(200)
    })
})

router.delete('/allocate' , (req, res) => {
    let ids = req.body
    console.log(ids)
    model.deleteAllocateFiche(ids,() => {
        res.sendStatus(204)
    })
})


router.delete('/allocateAll/:sector' , (req,res) => {
    let sector = req.params.sector
    model.deleteAllocateFicheAll(sector, () => {
        res.sendStatus(204)
    })
})






module.exports = router;