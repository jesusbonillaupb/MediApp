const express = require('express');
const router = express.Router();
var db = require('./db.js');

router.route('/register').post((req, res) => {
    //obtener parametros
    var nombreMed = req.body.nombreMed;
    var medTipo = req.body.medTipo;
    var fk_usuario = req.body.fk_usuario;
    var medDescripcion = req.body.medDescripcion;
    var medDosis = req.body.medDosis;
    //crear Query 
    var sqlQuery = "INSERT INTO Medicamentos(med_Nombre, med_Tipo, FK_Usuario, med_Descripcion, med_Dosis) VALUES (?, ?, ?,?,?)";

    //llamar a la base de datos para insertar
    db.query(sqlQuery, [nombreMed, medTipo, fk_usuario,medDescripcion,medDosis], function (error, data, fields) {
        if (error) {
            //Por si sale mal
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            //Por si sale bien
            var insertedId = data.insertId;
            res.send(JSON.stringify({ success: true, med: insertedId, }));
        }
    });

});

// ver todos los medicamentos de un usuario
router.route('/usermeds/:id').get((req, res) => {
    var userId = req.params.id;

    var sql = "SELECT * FROM Medicamentos Where Medicamentos.FK_Usuario = ?;";
    db.query(sql, [userId], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            if (data.length > 0) {

                res.send(JSON.stringify({ success: true, med: data }));
            } else {
                res.send(JSON.stringify({ success: false, message: 'No hay medicamentos' }));
            }

        }
    });
});


// Ver medicamento por id
router.route('/:id').get((req, res) => {
    var medId = req.params.id;

    var sql = "SELECT * FROM Medicamentos Where Medicamentos.idMedicamento = ?;";
    db.query(sql, [medId], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            if (data.length > 0) {

                res.send(JSON.stringify({ success: true, med: data }));
            } else {
                res.send(JSON.stringify({ success: false, message: 'No se encontro medicamento con ese id' }));
            }

        }
    });
});

// Borar medicamento junto con todos sus recordatorios
router.route('/:id').delete((req, res) => {
    var medId = req.params.id;
    // Verificar si el medicamento existe
    var sql1 = "SELECT * FROM Medicamentos Where Medicamentos.idMedicamento = ?;";
    db.query(sql1, [medId], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            // Existe el medicamento
            if (data.length > 0) {
                // Si existe el medicamento, se debe ver si tiene recordatorios
                var sql2 ="select Recordatorios.*, Medicamentos.med_Nombre, Medicamentos.med_Tipo, Medicamentos.med_Descripcion, Medicamentos.med_Dosis from Recordatorios, Medicamentos where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Medicamentos.idMedicamento =? ;"
                db.query(sql2, [medId], function (err, data, fields) { 
                    // Si hubo error al buscar el medicamento por id
                    if(err){
                        res.send(JSON.stringify({ success: false, message: err }));
                    } else {
                        // En caso de que tenga recordatorios 
                        if (data.length > 0){
                            // Se borran primero los recordatorios del medicamento
                            var sql3 ="DELETE FROM Recordatorios WHERE FK_Medicamento = ?;"
                            db.query(sql3,[medId], function (err, data, fields) {
                                // Si hubo error al borrar los recordatorios
                                if (err) {
                                    res.send(JSON.stringify({ success: false, message: err }));
                                } else {
                                    // Luego de borra el medicamento
                                    var sql4 ="DELETE FROM Medicamentos WHERE idMedicamento = ?;"  
                                    db.query(sql4, [medId], function(err, data, fields) {
                                        if (err) {
                                            res.send(JSON.stringify({ success: false, message: err }));
                                        } else {
                                            res.send(JSON.stringify({ success: true, message: 'Medicamento y sus recordatorios borrados', }));
                                        }
                                    });
                                }
                            });
                        // en caso de que no tenga recordatorios
                        } else {
                            // Luego de borra el medicamento
                            var sql5 ="DELETE FROM Medicamentos WHERE idMedicamento = ?;"  
                            db.query(sql5, [medId], function(err, data, fields) {
                                if (err) {
                                    res.send(JSON.stringify({ success: false, message: err }));
                                } else {
                                    res.send(JSON.stringify({ success: true, message: 'Medicamento borrado', }));
                                }
                            });
                        }
                    }

                });
            } else {
                res.send(JSON.stringify({ success: false, message: 'No se encontro medicamento con ese id' }));
            }

        }
    });
});
// editar medicamento
router.route('/cambiar/:idmed').put((req, res) => {
    //obtener parametros
    var idmed = req.params.idmed;
    var nombreMed = req.body.nombremed;
    var medTipo = req.body.medtipo;
    var medDescripcion = req.body.meddescripcion;
    var medDosis = req.body.meddosis;
    
    // se verifica que exista un medicamento con ese id
    var sql1= "Select * from Medicamentos WHERE idMedicamento = ?;"
    db.query(sql1, [idmed], function(error,data,fields){
        if (error) {
            //Por si sale mal
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            if (data.length > 0){
                var sql2= "UPDATE Medicamentos SET med_Nombre = ?, med_Tipo = ?, med_Descripcion = ?, med_Dosis = ? WHERE idMedicamento = ?;"
                db.query(sql2, [nombreMed,medTipo,medDescripcion,medDosis,idmed], function(error,data,fields){
                    if (error) {
                        //Por si sale mal
                        res.send(JSON.stringify({ success: false, message: error }));
                    }else{
                        res.send(JSON.stringify({ success: true, message: 'Medicamento actualizado correctamente' }));
                    }

                })

            } else {
                res.send(JSON.stringify({ success: false, message: 'No se encontro medicamento con ese id' }));
            }
        }

    })
});
module.exports = router;