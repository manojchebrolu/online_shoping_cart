import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>>  pickImages() async{
  List<File> image=[];
  try{

  var files =await FilePicker.platform.pickFiles(
    type: FileType.any,
    allowMultiple: true
  );
  if(files !=null && files.files.isNotEmpty)
    {
      for(int i=0;i<files.files.length;i++)
        {
          image.add(File(files.files[i].path!));
        }
    }
  print("file added");
  }
  catch(e)
  {
    print("file not added");
    debugPrint(e.toString());
  }
  return image;
}