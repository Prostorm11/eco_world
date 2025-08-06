 import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadFileToFirebase(File file, String storagePath) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(storagePath);
    final uploadTask = await ref.putFile(file);
    final downloadedUrl = await ref.getDownloadURL();
    return downloadedUrl; // Use this to save in Firestore or anywhere
  } catch (e) {
    print('Upload failed: $e');
    return null;
  }
}

Future<void> saveToFirestorePosts({
  required String url,
  required String type,
  String? caption, // "image" or "video"
  required String userID,
}) async {
  await FirebaseFirestore.instance.collection('posts').add({
    'url': url,
    'mediaType': type,
    'userId': userID ,
    "comments":[],
    "likes":0,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

Future<void> saveToFirestoreReels({
  String? caption,
  String? location,
  String? thumbnail,
  required String userID,
  required String videoUrl,
}) async {
  await FirebaseFirestore.instance.collection('reels').add({
    'url': videoUrl,
    "caption":caption??" ",
    'userID': userID,
    "likes":0,
    "location":location??"Unknown",
    "thumbnail":thumbnail??" ",
    "comments":[],
    "tags":[],
    'timestamp': FieldValue.serverTimestamp(),
  });
}








