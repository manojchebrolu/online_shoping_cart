const mongoose=require('mongoose');
const { productSchema } = require('./product');

const userSchema=mongoose.Schema({
    name:{
        require:true,
        type:String,
        trim:true,
    },
    email:{
        require:true,
        type:String,
        trim:true,
    },
    password:{
        require:true,
        type:String,
    },
    address:{
        
        type:String,
       default:"",
    },
    type:{
        type:String,
        default:"user",
    },
    cart:[
         {
            product:productSchema,
            quantity:{
                type:Number,
                required:true,
            }
         }
    ],
});
const User=mongoose.model("User",userSchema);
module.exports=User;