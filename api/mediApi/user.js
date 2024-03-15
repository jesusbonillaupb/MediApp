const express=require('express');
const router= express.Router();
var db= require('./db.js');

router.route('/register').post((req,res)=>{
    //obtener parametros
    var nombre=req.body.nombre;
    var password=req.body.password;
    var correo=req.body.correo;
    var celular=req.body.celular;
    var edad=req.body.edad;
    var rol=req.body.rol;

    //crear Query 
    var sqlQuery="INSERT INTO usuarios(us_Nombre, us_Password, us_Correo, us_Celular, us_Edad, FK_Rol) VALUES (?, ?, ?, ?, ?, ?)";

    //llamar a la base de datos para insertar
    db.query(sqlQuery,[nombre,password,correo,celular,edad,rol],function(error,data,fields){
        if(error)
        {
            //Por si sale mal
            res.send(JSON.stringify({success:false,message:error}));
        }else{
            //Por si sale bien
            res.send(JSON.stringify({success:true,message:'register'}));
        }
    });

});

    router.route('/login').post((req,res)=>{
        var correo=req.body.correo;
        var password=req.body.password;
        
        var sql="SELECT * FROM usuarios WHERE us_Correo=? AND us_Password=?";
        db.query (sql,[correo,password],function(err,data,fields){
            if(err){
                res.send(JSON.stringify({success:false,message:err}));
            }else{
                if(data.length >0)
                {

                res.send(JSON.stringify({success:true,user:data}));
                }else{
                    res.send(JSON.stringify({success:false,message:'Empty Data'}));
                }

            }
        });
    });

module.exports =router;