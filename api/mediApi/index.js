const express=require('express');
const app=express();
const userRouter=require('./user');

app.use(express.json());
app.use('/user',userRouter);
var db=require('./db.js');
app.listen(3000,()=>console.log("your server start on port 3000"));
