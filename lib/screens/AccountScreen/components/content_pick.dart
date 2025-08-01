import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery()async{
  final ImagePicker picker=ImagePicker();
  try{
    final XFile? pickedfile=await picker.pickImage(source: ImageSource.gallery);
  if(pickedfile!=null){
    return File(pickedfile.path);
  }else{
    print("No Image Selected");
  }
  }catch(e){
    print("Error picking media: $e");
  }
  
  return null;

}
Future<File?> pickVideoFromGallery()async{
  final ImagePicker picker=ImagePicker();
  try{
    final XFile? pickedfile=await picker.pickVideo(source: ImageSource.gallery);
  if(pickedfile!=null){
    return File(pickedfile.path);
  }else{
    print("No Video Selected");
  }
  }catch(e){
    print("Error picking media: $e");
  }
  return null;

}

Future<File?> pickMediaFromGallery()async{
  final ImagePicker picker=ImagePicker();
 try{
    final XFile? pickedfile=await picker.pickMedia();
  if(pickedfile!=null){
    return File(pickedfile.path);
  }else{
    print("No Media Selected");
  }
  }catch(e){
    print("Error picking media: $e");
  }
  return null;

}