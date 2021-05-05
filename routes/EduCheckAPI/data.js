var express = require('express');
var router = express.Router();
var fs = require('fs')

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

//<------------------------------------- Teacher Resources -------------------------------->
router.get("/teacher", (req, res) => {
    let filter = req.query.filter
    if (filter !== undefined) {
        model.getAllTeacherFilter(filter, (data) => {
            res.status(200).json(data)
        })
    } else {
        model.getAllTeacher((data) => {
            res.status(200).json(data)
        })
    }
})


router.get('/teacher/:id', (req, res) => {
    let id_teacher = req.params.id
    model.getTeacher(id_teacher, (data) => {
        res.status(200).json(data)
    })
})


router.post('/teacher', (req, res) => {
    let data = req.body.data
    let sector = req.body.sector
    model.insertTeacher(data, sector, () => {
        res.sendStatus(201)
    })
})

router.patch("/teacher/:id", (req, res) => {
    let data = req.body.data
    let id = req.params.id

    model.updateTeacher(data, id, () => {
        res.sendStatus(200)
    })
})


router.delete('/teacher/:id', (req, res) => {
    let id = req.params.id
    model.deleteTeacher(id, () => {
        res.sendStatus(204)
    })
})


//<-------------------- Class Ressources ----------------------------->

router.get('/class', (req, res) => {

    let filter = req.query.filter
    let option = req.query.option !== undefined

    if (option) {
        if (filter !== undefined) {
            model.getAllClassFilterPP(filter, (data) => {
                res.status(200).json(data)
            })
        } else {
            model.getAllClassPP((data) => {
                res.status(200).json(data)
            })
        }
    } else {
        if (filter !== undefined) {
            model.getAllClassFilter(filter, (data) => {
                res.status(200).json(data)
            })
        } else {
            model.getAllClass((data) => {
                res.status(200).json(data)
            })
        }
    }

})


router.get('/class/:id', (req, res) => {
    let id_class = req.params.id
    model.getClass(id_class, (data) => {
        res.status(200).json(data)
    })
})


router.post("/class", (req, res) => {
    let data = req.body.data
    let sector = req.body.sector

    model.insertClass(data, sector, () => {
        res.sendStatus(201)
    })

})


router.patch("/class/:id", (req,res) => {
    let data = req.body.data
    let id = req.params.id
    model.updateClass(data,id,() => {
        res.sendStatus(200)
    })

})

router.delete('/class/:id', (req, res) => {
    let id = req.params.id
    model.deleteClass(id, () => {
        res.sendStatus(204)
    })
})


//<---------------------------- Subject Ressouces ----------------->

router.get("/subject", (req, res) => {
    let filter = req.query.filter
    if (filter !== undefined) {
        model.getAllSubjectFilter(filter, (data) => {
            res.status(200).json(data)
        })
    } else {
        model.getAllSubject((data) => {
            res.status(200).json(data)
        })
    }

})


router.get("/subject/:id", (req, res) => {
    let ref_code = req.params.id
    model.getSubject(ref_code, (data) => {
        res.status(200).json(data)
    })
})


router.post("/subject", (req, res) => {
    let data = req.body.data
    let sector = req.body.sector

    model.insertSubject(data, sector, () => {
        res.sendStatus(201)
    })
})

router.patch('/subject/:id', (req, res) => {
    let data = req.body.data
    let ref_code = req.params.id

    model.updateSubject(data, ref_code, () => {
        res.sendStatus(200)
    })
})


router.delete('/subject/:id', (req, res) => {
    let ref_code = req.params.id
    model.deleteSubject(ref_code, () => {
        res.sendStatus(204)
    })
})


module.exports = router;