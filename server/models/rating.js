const mongoose = require('mongoose');


const ratingSchema=mongoose.Schema({
    userId:{
        type:String,
        requied:true,
    },
    rating:{
           type:Number,
           requied:true
    },
});

module.exports=ratingSchema;