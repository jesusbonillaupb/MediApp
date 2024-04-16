const express = require('express');
const router = express.Router();
var db = require('./db.js');

router.route('/register').post((req, res) => {
    //obtener parametros
    var nombreMed = req.body.nombreMed;
    var medTipo = req.body.medTipo;
    var fk_usuario = req.body.fk_usuario;

    //crear Query 
    var sqlQuery = "INSERT INTO Medicamentos(med_Nombre, med_Tipo, FK_Usuario) VALUES (?, ?, ?)";

    //llamar a la base de datos para insertar
    db.query(sqlQuery, [nombreMed, medTipo, fk_usuario], function (error, data, fields) {
        if (error) {
            //Por si sale mal
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            //Por si sale bien
            res.send(JSON.stringify({ success: true, message: 'medicamento registrado ', }));
        }
    });

});

router.route('/:id').get((req, res) => {
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

module.exports = router;