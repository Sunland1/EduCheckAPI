const connection = require('../bin/bdd')
const bcrypt = require('bcrypt')
const TOKEN = require('../bin/token.json').TOKEN_SECRET

const jwt = require('jsonwebtoken')
const fs = require('fs')


class Model {


    static register(username, pwd, firstname, name, cb) {
        const hash = bcrypt.hashSync(pwd, 10);
        connection.query("INSERT INTO user (username,pwd,firstname,name) VALUES (?,?,?,?)", [username, hash, firstname, name],
            (err, row) => {
                if (err) throw err
                cb(row.insertId)
            })
    }


    static login(username, cb) {
        connection.query("SELECT * FROM user WHERE username=?", [username], (err, row) => {
            if (err) throw err
            cb(row[0])
        })
    }


    //A voir pour coder le propre module de TOKEN
    static createToken(id, username) {
        return jwt.sign(username, TOKEN);
    }


    //<------------------ Teacher SECTION --------------------------------------------->
    static getAllTeacher(cb) {
        connection.query("SELECT * FROM teacher", (err, rows) => {
            if (err) throw err
            cb(rows)
        })
    }

    static getAllTeacherFilter(filter, cb) {
        connection.query("SELECT teacher.id_teacher,civility,name,firstname,graduation,ts.sector\n" +
            "FROM teacher JOIN teach_sector ts\n" + "" +
            "on teacher.id_teacher = ts.id_teacher WHERE ts.sector = ?",
            [filter], (err, rows) => {
                if (err) throw err
                cb(rows)
            }
        )
    }

    static getTeacher(id, cb) {
        connection.query("SELECT * FROM teacher WHERE id_teacher=?", [id], (err, rows) => {
            if (err) throw err
            cb(rows[0])
        })
    }

    static insertTeacher(data, sector, cb) {
        connection.query("INSERT INTO teacher (civility,name,firstname,graduation) VALUES (?)", [data], (err, rows) => {
            if (err) throw err
            connection.query("INSERT INTO teach_sector (id_teacher,sector) VALUES (?,?)",
                [rows.insertId, sector], (err) => {
                    if (err) throw err
                    cb(rows.insertId)
                }
            )
        })
    }

    static insertTeacherSector(sector,id_teacher,cb){
        connection.query("INSERT INTO teach_sector (id_teacher,sector) VALUES (?,?)",
                [id_teacher, sector], (err) => {
                    if (err) throw err
                    cb()
                }
        )
    }

    static updateTeacher(data, id, cb) {
        connection.query("UPDATE teacher SET civility = ?, name = ?, firstname = ?, graduation = ? WHERE id_teacher=?;",
            [data.civility, data.name, data.firstname, data.graduation, id], (err, row) => {
                if (err) throw err
                cb(row)
            }
        )
    }


    static deleteTeacher(id, cb) {
        connection.query("DELETE FROM teacher WHERE id_teacher=?", [id], (err) => {
            if (err) throw err
            cb()
        })
    }


    //<------------------------ Class Section ----------------------->
    static getAllClass(cb) {
        connection.query('SELECT * FROM class', (err, rows) => {
            if (err) throw err
            cb(rows)
        })
    }

    static getAllClassFilter(filter, cb) {
        connection.query('SELECT * FROM class WHERE sector=?', [filter], (err, rows) => {
            if (err) throw err
            cb(rows)
        })
    }

    static getAllClassPP(cb) {
        connection.query('SELECT class.id_class,class.name as division,teacher.civility,teacher.name,teacher.id_teacher FROM class\n' +
            'JOIN teacher_class_p tcp on class.id_class = tcp.id_class\n' +
            'JOIN teacher on teacher.id_teacher = tcp.id_teacher',
            (err, rows) => {
                if (err) throw err
                cb(rows)
            }
        )
    }

    static getAllClassFilterPP(filter, cb) {
        connection.query('SELECT class.id_class,class.name as division,teacher.civility,teacher.name,teacher.id_teacher FROM class\n' +
            'JOIN teacher_class_p tcp on class.id_class = tcp.id_class\n' +
            'JOIN teacher on teacher.id_teacher = tcp.id_teacher WHERE class.sector=?', [filter],
            (err, rows) => {
                if (err) throw err
                cb(rows)
            }
        )
    }


    static getClass(id, cb) {
        connection.query('SELECT * FROM class WHERE id_class=?', [id], (err, row) => {
            if (err) throw err
            cb(row[0])
        })
    }

    static insertClass(data, sector, cb) {
        connection.query('INSERT INTO class (sector,name) VALUES (?,?)', [sector, data[0]], (err, row) => {
            if (err) throw err
            let id_class = row.insertId
            connection.query('INSERT INTO teacher_class_p (id_teacher,id_class) VALUES (?,?)',
                [data[1], row.insertId], (err) => {
                    if (err) throw err
                    cb(id_class)
                }
            )
        })
    }

    static updateClass(data, id, cb) {
        connection.query('UPDATE class SET name=? WHERE id_class=?', [data.name, id], (err) => {
            if (err) throw err
            connection.query('UPDATE teacher_class_p SET id_teacher=? WHERE id_class=?', [data.id_teacher, id], (err) => {
                if (err) throw err
                cb()
            })
        })
    }


    static deleteClass(id, cb) {
        connection.query('DELETE FROM class WHERE id_class=?', [id], (err) => {
            if (err) throw err
            cb()
        })
    }


    //<----------------------- Subject section ---------------------------------------->

    static getAllSubject(cb) {
        connection.query("SELECT * FROM subject", (err, rows) => {
            if (err) throw err
            cb(rows)
        })
    }

    static getAllSubjectFilter(filter, cb) {
        connection.query("SELECT id_subject,ref_code,subject_code,name FROM subject WHERE sector=?", [filter], (err, rows) => {
            if (err) throw err
            cb(rows)
        })
    }

    static getSubject(ref_code, cb) {
        connection.query("SELECT * FROM subject WHERE id_subject=?;", [ref_code], (err, row) => {
            if (err) throw err
            cb(row[0])
        })
    }

    static insertSubject(data, sector, cb) {
        connection.query("INSERT INTO subject (ref_code,subject_code,name,sector) VALUES (?,?)", [data, sector], (err,rows) => {
            if (err) throw err
            cb(rows.insertId)
        })
    }


    static isPond(id_subject,isPond, cb){
        let value = 1
        if(!isPond){
            value = 0
        }
        connection.query("INSERT INTO ponderate (id_subject,isPonderate) VALUES (?,?)" , [id_subject,value],
            (err) => {
                if(err) throw err
                cb()
            }
        )
    }

    static updateSubject(data, id_subject, cb) {
        connection.query("UPDATE subject SET ref_code=?,subject_code=?,sector=?,name=? WHERE id_subject=?",
            [data.ref_code,data.subject_code,data.sector, data.name, id_subject], (err) => {
                if (err) throw err
                cb()
            }
        )
    }


    static deleteSubject(id_subject, cb) {
        connection.query("DELETE FROM subject WHERE id_subject=?", [id_subject], (err) => {
            if (err) throw err
            cb()
        })
    }


    //<------------------------------ Methode Fiche ------------------------------------->

    static insertUsualFiche(data, cb) {
        connection.query('INSERT INTO table_fiche (id_subject,id_class,nb_heure) VALUES (?,?,?)',
            [data.id_subject, data.id_class, data.heure], (err) => {
                if (err) throw err
                cb()
            }
        )
    }

    static getAllUsualFiche(cb) {
        connection.query('SELECT * FROM table_fiche', (err, rows) => {
            if (err) throw err
            cb(rows)
        })
    }

    static getAllUsualFicheFilter(filter, cb) {
        connection.query('SELECT table_fiche.id_class,ref_code,heure,heure_double FROM table_fiche \n' +
            'JOIN class c on table_fiche.id_class = c.id_class\n' +
            'WHERE sector = ?',
            [filter], (err, rows) => {
                if (err) throw err
                cb(rows)
            }
        )
    }

    static getUsualFiche(id, cb) {
        connection.query('SELECT id_class , s.id_subject,s.name,s.ref_code , name , nb_heure FROM table_fiche\n' +
            'JOIN subject s on s.id_subject = table_fiche.id_subject WHERE id_class=?', [id], (err, row) => {
            if (err) throw err
            cb(row)
        })
    }

    static updateUsualFiche(id_class,id_subject, data, cb) {
        connection.query('UPDATE table_fiche SET nb_heure=? WHERE id_class=? AND id_subject=?',
            [data.nb_heure , id_class , id_subject], (err) => {
                if (err) throw err
                cb()
            }
        )
    }

    static deleteUsualFiche(id_class,id_subject, cb) {
        connection.query('DELETE FROM table_fiche WHERE id_class=? AND id_subject=?', [id_class,id_subject], (err) => {
            if (err) throw err
            cb()
        })
    }


    static getAllAllocateFiche(cb) {
        connection.query('SELECT * FROM table_fiche_affecter', (err, rows) => {
            if (err) throw err
            cb(rows)
        })
    }

    static getAllAllocateFicheFilter(filter, cb) {
        connection.query('SELECT table_fiche_affecter.id_class,id_teacher,heure_affecter,heure_double_affecter  ' +
            'FROM table_fiche_affecter\n' +
            'JOIN class c on c.id_class = table_fiche_affecter.id_class\n' +
            'WHERE sector = ?',
            [filter], (err, rows) => {
                if (err) throw err
                cb(rows)
            }
        )
    }

    static getAllocateFiche(id_class, cb) {
        connection.query('SELECT table_fiche_affecter.id_subject,s.ref_code,s.name as subject_name,t.civility,t.name as teacher_name,nb_heure_affecter,t.id_teacher FROM table_fiche_affecter\n'+
            'JOIN subject s on table_fiche_affecter.id_subject = s.id_subject\n'+
            'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher\n'+
            'WHERE id_class = ?', [id_class], (err, row) => {
            if (err) throw err
            cb(row)
        })
    }

    static insertAllocateFiche(data, cb) {
        connection.query('INSERT INTO table_fiche_affecter (id_class,id_subject,id_teacher,nb_heure_affecter) ' +
            'VALUES (?,?,?,?)',
            [data.id_class, data.id_subject, data.id_teacher, data.nb_heure_affecter], (err) => {
                if (err) throw err
                cb()
            }
        )
    }


    static updateAllocateFiche(data, cb) {
        connection.query('UPDATE table_fiche_affecter SET nb_heure_affecter = ? WHERE id_class = ? AND id_subject = ? AND id_teacher = ?',
            [data.nb_heure_affecter, data.id_class, data.id_subject, data.id_teacher], (err) => {
                if (err) throw err
                cb()
            }
        )
    }

    static deleteAllocateFiche(ids, cb) {
        connection.query('DELETE FROM sunland_educhecktest.table_fiche_affecter WHERE id_class = ? AND id_subject = ? AND id_teacher = ?', 
        [ids.id_class,ids.id_subject,ids.id_teacher], (err) => {
            if (err) throw err
            cb()
        })
    }


    static deleteAllocateFicheAll(sector,cb){
        connection.query('DELETE table_fiche_affecter FROM table_fiche_affecter\n'+
            'JOIN class c on c.id_class = table_fiche_affecter.id_class\n'+
            'WHERE c.sector = ?' , [sector] , (err) => {
                if(err) throw err
                cb()
            })
    }


    //<------------------- Recap Methode ------------------------------------------------>

    static getRecapDataHSA(filter,cb){
        if(filter === "LUFA"){
            connection.query("SELECT p.isPonderate,c.sector,c.id_class,c.name,table_fiche_affecter.id_teacher,t.graduation,table_fiche_affecter.id_subject, SUM(nb_heure_affecter) as tot_class FROM table_fiche_affecter\n"+
            "JOIN class c on table_fiche_affecter.id_class = c.id_class\n"+
            "JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher\n"+
            "JOIN ponderate p on p.id_subject = table_fiche_affecter.id_subject\n"+
            "WHERE sector='LYC' OR sector='UFA' GROUP BY table_fiche_affecter.id_teacher,c.sector,c.id_class,table_fiche_affecter.id_subject \n" , 
                (err,rows) => {
                    if(err) throw err
                    cb(rows)
                }
            
            )
        }else{
            connection.query("SELECT table_fiche_affecter.id_teacher,t.graduation, SUM(nb_heure_affecter) as tot_HPDE FROM table_fiche_affecter\n"+
            "JOIN class c on table_fiche_affecter.id_class = c.id_class\n"+
            "JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher\n"+
            "WHERE sector='COL' GROUP BY table_fiche_affecter.id_teacher" , 
                (err,rows) => {
                    if(err) throw err
                    cb(rows)
                }
            
            )
        }
    }

    static getRecapRef_code(cb) {
        connection.query("SELECT s.ref_code,s.subject_code,s.name,SUM(nb_heure_affecter) as totals FROM table_fiche_affecter\n"+
            "JOIN subject s on table_fiche_affecter.id_subject = s.id_subject\n"+
            "WHERE sector='LYC' OR sector='UFA' GROUP BY s.ref_code;",
            (err, rows) => {
                if (err) throw err
                cb(rows)
            })
    }

    static getRecapRef_codeFilter(filter, cb) {
        connection.query('SELECT s.ref_code,s.subject_code,s.name,SUM(nb_heure_affecter) as totals FROM table_fiche_affecter\n'+
            'JOIN subject s on table_fiche_affecter.id_subject = s.id_subject\n' +
            'WHERE sector=? GROUP BY s.ref_code;',
            [filter], (err, rows) => {
                if (err) throw err
                cb(rows)
            }
        )
    }

    static getRecapTeacher(cb){
        connection.query('SELECT table_fiche_affecter.id_teacher,t.name as teacher_name,c.id_class,c.name as class_name,c.sector,SUM(nb_heure_affecter) as tot_class FROM table_fiche_affecter\n'+
        'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher\n' +
        'JOIN class c on table_fiche_affecter.id_class = c.id_class\n'+
        'GROUP BY table_fiche_affecter.id_teacher',
            (err,rows) => {
                if(err) throw err
                cb(rows)
            }
        )
    }

    static getRecapTeacherID(id,cb){
        connection.query('SELECT t.id_teacher,t.name as teacher_name,c.id_class,c.sector,c.name as class_name,SUM(nb_heure_affecter) as tot_class FROM table_fiche_affecter\n' +
            'JOIN class c on c.id_class = table_fiche_affecter.id_class\n' +
            'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher\n'+
            'WHERE t.id_teacher = ? GROUP BY c.id_class',[id],
            (err,rows) => {
                if(err) throw err
                cb(rows)
            }
        )
    }

    static getAllRecapTeacherID(id,cb){
        connection.query('SELECT s.subject_code, p.isPonderate,table_fiche_affecter.id_subject,t.id_teacher,t.name as teacher_name,c.id_class,c.sector,c.name as class_name,SUM(nb_heure_affecter) as tot_class FROM table_fiche_affecter\n' +
            'JOIN class c on c.id_class = table_fiche_affecter.id_class\n' +
            'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher\n'+
            'JOIN ponderate p on p.id_subject = table_fiche_affecter.id_subject\n'+
            'JOIN subject s on s.id_subject = table_fiche_affecter.id_subject\n'+
            'WHERE t.id_teacher = ? GROUP BY table_fiche_affecter.id_subject,c.id_class',[id],
            (err,rows) => {
                if(err) throw err
                cb(rows)
            }
        )
    }

    static getRecapTeacherFilter(filter,cb){
        connection.query('SELECT table_fiche_affecter.id_teacher,t.name as teacher_name,c.id_class,c.name as class_name,c.sector,SUM(nb_heure_affecter) as tot_class FROM table_fiche_affecter\n'+
        'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher\n' +
        'JOIN class c on table_fiche_affecter.id_class = c.id_class\n'+
        'GROUP BY table_fiche_affecter.id_teacher WHERE sector=?' ,[filter],
            (err,rows) => {
                if(err) throw err
                cb(rows)
            }
        )
    }

    static getMaxTeacher(cb){
        connection.query('SELECT t.graduation,t.id_teacher,t.civility,t.name,SUM(nb_heure_affecter) as MaxTOT FROM table_fiche_affecter\n' +
            'JOIN class c on c.id_class = table_fiche_affecter.id_class\n' +
            'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher GROUP BY t.id_teacher',
            (err,rows) => {
                if(err) throw err
                cb(rows)
            }
        )
    }


    static getMaxTeacherFilter(filter,subjectFilter,cb){
        if(subjectFilter === undefined){
            connection.query('SELECT t.graduation,t.id_teacher,t.civility,t.name,SUM(nb_heure_affecter) as MaxTOT FROM table_fiche_affecter\n' +
            'JOIN class c on c.id_class = table_fiche_affecter.id_class\n' +
            'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher WHERE sector=? GROUP BY t.id_teacher',
                [filter],(err,rows) => {
                    if(err) throw err
                    cb(rows)
                }
            )
        }else{
            connection.query('SELECT t.graduation,t.id_teacher,t.civility,t.name,SUM(nb_heure_affecter) as MaxTOT FROM table_fiche_affecter\n' +
                'JOIN class c on c.id_class = table_fiche_affecter.id_class\n' +
                'JOIN teacher t on t.id_teacher = table_fiche_affecter.id_teacher \n' +
                'WHERE c.sector = ? AND table_fiche_affecter.id_subject = ? GROUP BY t.id_teacher',
                [filter,subjectFilter],(err,rows) => {
                    if(err) throw err
                    cb(rows)
                }
            )
        }

    }


    static getRefCodeRecap(ref_code,cb){
        connection.query("SELECT table_fiche_affecter.id_subject,s.subject_code,s.name,SUM(nb_heure_affecter) as TOT FROM table_fiche_affecter\n"+
        "JOIN subject s on table_fiche_affecter.id_subject = s.id_subject\n"+
        "WHERE s.ref_code = ? GROUP BY s.id_subject" , [ref_code] , 
            (err,rows) => {
                if(err) throw err
                cb(rows)
            }
        )
    }



    static updateDHG(sector,DHG,cb){
        connection.query("UPDATE sector SET DHG=? WHERE sector=?" , [sector,DHG] , (err) => {
            if(err) throw err
            cb(true)
        })
    }


    static getDHG(sector,cb){
        connection.query("SELECT DHG FROM sector WHERE sector=?" , [sector] , (err,row) => {
            if(err) throw err
            cb(row)
        })
    }


    static getTotHoureClassALL(cb,sector = undefined){
        if(sector === undefined){
            connection.query("SELECT c.id_class,c.name, SUM(heure_double_affecter+heure_affecter) as tot_class FROM table_fiche_affecter\n" +
                "JOIN class c on table_fiche_affecter.id_class = c.id_class\n" +
                "GROUP BY id_class" ,
                (err,rows) => {
                    if(err) throw err
                    cb(rows)
                }

            )
        }else{
            connection.query("SELECT c.id_class,c.name, SUM(heure_double_affecter+heure_affecter) as tot_class FROM table_fiche_affecter\n" +
                "JOIN class c on table_fiche_affecter.id_class = c.id_class\n" +
                "WHERE c.sector = ? GROUP BY id_class",[sector],
                (err,rows) => {
                    if(err) throw err
                    cb(rows)
                }

            )
        }
    }

    static getTotHoureClass(id_class,cb){
        connection.query("SELECT s.ref_code, s.name as matiere,c.name, table_fiche_affecter.heure_affecter , table_fiche_affecter.heure_double_affecter\n" +
            "    FROM table_fiche_affecter\n" +
            "    JOIN class c on table_fiche_affecter.id_class = c.id_class\n" +
            "    JOIN subject s on table_fiche_affecter.ref_code = s.ref_code\n" +
            "    WHERE table_fiche_affecter.id_class = ?" , [id_class] ,
                (err,rows) => {
                    if(err) throw err
                    cb(rows)
                }

            )
    }





}


module.exports = Model;