const express=require('express');
const app=express();

var bodyParser=require('body-parser');


app.use(express.json());
app.use(bodyParser.urlencoded({extended:true}));
const userRouter=require('./user');
const medRouter= require('./med');
const recRouter= require('./rec');
app.use('/user',userRouter);
app.use('/med',medRouter);
app.use('/rec',recRouter);

var db=require('./db.js');

app.listen(3000,()=>console.log("your server start on port 3000"));
