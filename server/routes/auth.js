const express =require("express");
const User = require("../models/user");
const bcrypt = require('bcrypt');
const app=express();
const authRouter =express.Router();
const jwt=require('jsonwebtoken');
const auth = require("../middleware/auth");
app.use(express.json());



//Sign up
authRouter.post("/api/signup",async(req,res)=>{
  try {
    console.log("hi");
    const {name,email,password}=req.body;
    const existingUser=await User.findOne({ email });
    if(existingUser)
    {
      console.log("have");
     return res.json({msg:'User with same email already exists'});
    }
    const hashedPassword=await bcrypt.hash(password,8);
    let user =new User({
     email,
     password:hashedPassword,
     name,
    });
    console.log("hi");
    user=await user.save();
    res.json(user);
  }
   catch (e){
    console.log(e.message);
    res.status(500).json({error:e.message});
  }
});


authRouter.post("/api/signin",async(req,res)=>{
   try 
   {
    console.log("signin");
    const {email,password}=req.body;
    const user=await User.findOne({email});
   
    if(!user)
    {
       
        return res
        .status(400)
        .json({msg:"user with this email does not exist!"});
    }
    const isMatch = await bcrypt.compare(password,user.password);
    if(!isMatch)
    {
        return res
        .status(400)
        .json({msg:"password wrong"});
    }
    else
    {
        const token =jwt.sign({id:user._id},"passwordKey");
        console.log(token);
        return res
         .json({token,...user._doc});
   

    }
   } 
   catch (e) 
   {
    
   }
    });



authRouter.post("/tokenIsValid",async(req,res)=>{
      try 
      {
      const token =req.header('x-auth-token');
      if(!token) return res.json(false);
      const verified=jwt.verify(token,"passwordKey");
      if(!verified) return res.json(fasle);
      const user=await User.findById(verified.id);
      if(!user) return res.json(false);
      res.json(true);
      } 
      catch (e) 
      {
       
      }
    }
);



//get user

authRouter.get('/',auth,async(req,res)=>{
const user=await User.findById(req.user);
res.json({...user._doc,token:req.token});
});
       

    
module.exports=authRouter;