const express = require('express');
const router = express.Router();
var db = require('./db.js');

// registrar recordatorio
router.route('/register').post((req, res) => {
    //obtener parametros
    var diaSemana = req.body.diaSemana;
    var hora = req.body.hora;
    var fk_med = req.body.fk_med;

    var sql1 = "SELECT * FROM Recordatorios WHERE re_DiaSemana = ? and FK_Medicamento = ?;"
    db.query(sql1, [diaSemana, fk_med], function (error, data, fields) {
        if (error) {
            //Por si sale mal
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            if (data.length > 0) {

                res.send(JSON.stringify({ success: true, message: 'El recordatorio ese dia de la semana de este recordatorio ya esta agendado' }));
            } else {
                var sql2 = "INSERT INTO Recordatorios(re_DiaSemana, re_Hora, FK_Medicamento) VALUES (?, ?, ?)";
                //llamar a la base de datos para insertar
                db.query(sql2, [diaSemana, hora, fk_med], function (error, data, fields) {
                    if (error) {
                        //Por si sale mal
                        res.send(JSON.stringify({ success: false, message: error }));
                    } else {
                        //Por si sale bien
                        res.send(JSON.stringify({ success: true, message: 'recordatorio registrado ' }));
                    }
                });
            }
        }
    })



});

// ver recordatorios del usuario por dia de la semana
router.route('/dia/:idusuario/:diasemana').get((req, res) => {
    var userId = req.params.idusuario;
    var diaSemana = req.params.diasemana;

    var sql = "select Recordatorios.*, Medicamentos.med_Nombre, Medicamentos.med_Tipo, Medicamentos.med_Descripcion, Medicamentos.med_Dosis from Recordatorios, Medicamentos, Usuarios where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Usuarios.id_Usuario=Medicamentos.FK_Usuario and Usuarios.id_Usuario =? and Recordatorios.re_DiaSemana=? ;";
    db.query(sql, [userId, diaSemana], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            if (data.length > 0) {

                res.send(JSON.stringify({ success: true, recordatorio: data }));
            } else {
                res.send(JSON.stringify({ success: false, message: 'No hay recordatorios este dia de la semana' }));
            }

        }
    });
});

// ver recordatorios del usuario por id del medicamento
router.route('/medi/:idmed').get((req, res) => {
    var idMed = req.params.idmed;
    var sql1 = "SELECT * FROM Medicamentos Where Medicamentos.idMedicamento = ?;";
    db.query(sql1, [idMed], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            // verificar si existe ese medicamento
            if (data.length > 0) {
                var sql2 = "select Recordatorios.*, Medicamentos.med_Nombre, Medicamentos.med_Tipo, Medicamentos.med_Descripcion, Medicamentos.med_Dosis from Recordatorios, Medicamentos where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Medicamentos.idMedicamento =? ;";
                db.query(sql2, [idMed], function (err, data, fields) {
                    if (err) {
                        res.send(JSON.stringify({ success: false, message: err }));
                    } else {
                        if (data.length > 0) {
                            // existe el medicamento y tiene recordatorios
                            res.send(JSON.stringify({ success: true, recordatorio: data }));
                        } else {
                            res.send(JSON.stringify({ success: false, message: 'No hay recordatorios de este medicamento' }));
                        }

                    }
                });
                // No existe medicamento con ese id
            } else {
                res.send(JSON.stringify({ success: false, message: 'No se encontro medicamento con ese id' }));
            }
        }
    });
});

// Eliminar recordatorio medicamento segun su dia
router.route('/quitardia/:idmed/:diasemana').delete((req, res) => {
    var idMed = req.params.idmed;
    var diaSemana = req.params.diasemana;
    // verificar si ese medicamento existe
    var sql1 = "SELECT * FROM Medicamentos WHERE Medicamentos.idMedicamento = ?;";
    db.query(sql1, [idMed], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            if (data.length > 0) {
                // hay un recordatorio de ese medicamento, ese dia de la semana?
                var sql2 = "select Recordatorios.*, Medicamentos.med_Nombre, Medicamentos.med_Tipo, Medicamentos.med_Descripcion, Medicamentos.med_Dosis from Recordatorios, Medicamentos where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Recordatorios.FK_Medicamento=? and Recordatorios.re_DiaSemana=? ;";
                db.query(sql2, [idMed, diaSemana], function (err, data, fields) {
                    if (err) {
                        res.send(JSON.stringify({ success: false, message: err }));
                    } else {
                        // En caso de que si haya, borrarlo
                        if (data.length > 0) {
                            var sql3 = "DELETE FROM Recordatorios WHERE FK_Medicamento = ? and re_DiaSemana = ?"
                            db.query(sql3, [idMed, diaSemana], function (err, data, fields) {
                                if (err) {
                                    res.send(JSON.stringify({ success: false, message: err }));
                                } else {
                                    res.send(JSON.stringify({ success: true, message: 'Recordatorio borrado con exito' }));
                                }
                            })


                        } else {
                            // se devuelve true para que cuente como que se quito y en el front sea mas facil de procesar
                            res.send(JSON.stringify({ success: true, message: 'No hay recordatorios de este medicamento ese dia de la semana' }));
                        }

                    }
                });

            } else {
                res.send(JSON.stringify({ success: false, message: 'No se encontro medicamento con ese id' }));
            }
        }
    });
});

// cambiar hora recordatorios
router.route('/cambiar/:idmed').put((req, res) => {
    //obtener parametros
    var idmed = req.params.idmed;
    var hora = req.body.hora;

    // verificar que el medicamento exista

    var sql1 = "SELECT * FROM Medicamentos Where Medicamentos.idMedicamento = ?;";
    db.query(sql1, [idmed], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            if (data.length > 0) {
                // se verifica que el medicamento tenga recordatorios
                var sql2 = "select Recordatorios.*, Medicamentos.med_Nombre, Medicamentos.med_Tipo, Medicamentos.med_Descripcion, Medicamentos.med_Dosis from Recordatorios, Medicamentos where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Medicamentos.idMedicamento =? ;";
                db.query(sql2, [idmed], function (error, data, fields) {
                    if (error) {
                        //Por si sale mal
                        res.send(JSON.stringify({ success: false, message: error }));
                    } else {
                        if (data.length > 0) {
                            var sql3 = "UPDATE Recordatorios SET re_hora = ? WHERE FK_Medicamento= ?;";
                            db.query(sql3, [hora, idmed], function (error, data, fields) {
                                if (error) {
                                    //Por si sale mal
                                    res.send(JSON.stringify({ success: false, message: error }));
                                } else {
                                    res.send(JSON.stringify({ success: true, message: 'Hora recordatorio actualizada con exito' }));
                                }
                            });

                        } else {
                            res.send(JSON.stringify({ success: false, message: 'El medicamento no tiene recordatorios' }));
                        }
                    }
                })


            } else {
                res.send(JSON.stringify({ success: false, message: 'No se encontro medicamento con ese id' }));
            }

        }
    });


});

// dar hora toma medicamentos
router.route('/hora/:idmed').get((req, res) => {
    var idMed = req.params.idmed;
    var sql1 = "SELECT * FROM Medicamentos Where Medicamentos.idMedicamento = ?;";
    db.query(sql1, [idMed], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            // verificar si existe ese medicamento
            if (data.length > 0) {
                var sql2 = "select Recordatorios.re_Hora, Medicamentos.med_Nombre from Recordatorios, Medicamentos where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Medicamentos.idMedicamento =? limit 1 ;";
                db.query(sql2, [idMed], function (err, data, fields) {
                    if (err) {
                        res.send(JSON.stringify({ success: false, message: err }));
                    } else {
                        if (data.length > 0) {
                            // existe el medicamento y tiene recordatorios
                            res.send(JSON.stringify({ success: true, recordatorio: data }));
                        } else {
                            res.send(JSON.stringify({ success: false, message: 'No hay recordatorios de este medicamento' }));
                        }

                    }
                });
                // No existe medicamento con ese id
            } else {
                res.send(JSON.stringify({ success: false, message: 'No se encontro medicamento con ese id' }));
            }
        }
    });
});

module.exports = router;