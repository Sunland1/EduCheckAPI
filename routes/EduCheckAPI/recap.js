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

router.get('/ref_code' , (req, res) => {
    let filter = req.query.filter
    if(filter !== undefined){
        model.getRecapRef_codeFilter(filter,(data) => {
            res.status(200).json(data)
        })
    }else{
        model.getRecapRef_code((data) => {
            res.status(200).json(data)
        })
    }
})


router.get('/hsa' , (req,res) => {
    let filter = req.query.filter
    model.getRecapDataHSA(filter , (data) => {
        res.status(200).json(data)
    })
})


router.get('/teacher' , (req, res) => {
    let filter = req.query.filter
    if(filter !== undefined){
        model.getRecapTeacherFilter(filter,(data) => {
            res.status(200).json(data)
        })
    }else{
        model.getRecapTeacher((data) => {
            res.status(200).json(data)
        })
    }
})


router.get('/teacher/:id' , (req,res) => {
    let id_teacher = req.params.id
    model.getRecapTeacherID(id_teacher,(data) => {
        res.status(200).json(data)
    })
})

router.get('/teacherAll/:id' , (req,res) => {
    let id_teacher = req.params.id
    model.getAllRecapTeacherID(id_teacher,(data) => {
        res.status(200).json(data)
    })
})


router.get('/teacherMax',(req, res) => {
    let filter = req.query.filter
    let subjectFilter = req.query.subjectFilter
    if(filter !== undefined){
        model.getMaxTeacherFilter(filter,subjectFilter,(data) => {
            res.status(200).json(data)
        })
    }else{
        model.getMaxTeacher((data) => {
            res.status(200).json(data)
        })
    }
})


router.get('/class' , (req,res) => {
    let sector = req.query.sector
    if(sector !== undefined) {
        model.getTotHoureClassALL((data) => {
            res.status(200).json(data)
        } , sector )
    }else{
        model.getTotHoureClassALL((data) => {
            res.status(200).json(data)
        })
    }
})



router.get('/class/:id' , (req,res) => {
    let id_class = req.params.id
    model.getTotHoureClass(id_class , (data) => {
        res.status(200).json(data)
    })
})


module.exports = router;