const express = require('express');
const router = express.Router();
var db = require('./db.js');

// registrar recordatorio
router.route('/register').post((req, res) => {
    //obtener parametros
    var diaSemana = req.body.diaSemana;
    var hora = req.body.hora;
    var fk_med = req.body.fk_med;

    //crear Query 
    var sqlQuery = "INSERT INTO Recordatorios(re_DiaSemana, re_Hora, FK_Medicamento) VALUES (?, ?, ?)";

    //llamar a la base de datos para insertar
    db.query(sqlQuery, [diaSemana, hora, fk_med], function (error, data, fields) {
        if (error) {
            //Por si sale mal
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            //Por si sale bien
            res.send(JSON.stringify({ success: true, message: 'recordatorio registrado ' }));
        }
    });

});

// ver recordatorios por dia de la semana
router.route('/dia/:idusuario/:diasemana').get((req, res) => {
    var userId = req.params.idusuario;
    var diaSemana = req.params.diasemana;


    var sql = "select Recordatorios.*, Medicamentos.med_Nombre, Medicamentos.med_Tipo from Recordatorios, Medicamentos, Usuarios where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Usuarios.id_Usuario=Medicamentos.FK_Usuario and Usuarios.id_Usuario =? and Recordatorios.re_DiaSemana=? ;";
    db.query(sql, [userId,diaSemana], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            if (data.length > 0) {

                res.send(JSON.stringify({ success: true, recordatorio: data }));
            } else {
                res.send(JSON.stringify({ success: false, message: 'No hay recordatorios este dia' }));
            }

        }
    });
});

// ver recordatorios por dia de la medicamento
router.route('/medi/:idusuario/:idmed').get((req, res) => {
    var userId = req.params.idusuario;
    var idMed = req.params.idmed;


    var sql = "select Recordatorios.*, Medicamentos.med_Nombre, Medicamentos.med_Tipo from Recordatorios, Medicamentos, Usuarios where Medicamentos.idMedicamento=Recordatorios.FK_Medicamento and Usuarios.id_Usuario=Medicamentos.FK_Usuario and Usuarios.id_Usuario =? and Medicamentos.idMedicamento =? ;";
    db.query(sql, [userId,idMed], function (err, data, fields) {
        if (err) {
            res.send(JSON.stringify({ success: false, message: err }));
        } else {
            if (data.length > 0) {

                res.send(JSON.stringify({ success: true, recordatorio: data }));
            } else {
                res.send(JSON.stringify({ success: false, message: 'No hay recordatorios de este medicamento' }));
            }

        }
    });
});

module.exports = router;