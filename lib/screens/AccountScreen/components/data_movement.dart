import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

Future<String?> uploadFileToFirebase(
    File file, String storagePath, ValueNotifier<double>? notifier) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(storagePath);
    final uploadTask = ref.putFile(file); // Don't await yet

    // Track progress
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      final progress = snapshot.bytesTransferred / snapshot.totalBytes * 100;
      if (notifier != null) {
        notifier.value = progress;
      }
      print('Upload is ${progress.toStringAsFixed(2)}% complete');
    });

    // Wait for completion
    final snapshot = await uploadTask;
    final downloadedUrl = await snapshot.ref.getDownloadURL();
    return downloadedUrl;
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
    'userId': userID,
    "comments": [],
    "likes": 0,
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
    "caption": caption ?? " ",
    'userId': userID,
    "likes": 0,
    "location": location ?? "Unknown",
    "thumbnail": thumbnail ?? " ",
    "comments": [],
    "tags": [],
    'timestamp': FieldValue.serverTimestamp(),
  });
}
