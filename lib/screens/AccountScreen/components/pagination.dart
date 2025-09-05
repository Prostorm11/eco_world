import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot? lastReelDoc;
Future<List<String>> loadReels(String userID) async {
  Query query = FirebaseFirestore.instance
      .collection("reels")
      .where('userId', isEqualTo: userID)
      .limit(8)
      .orderBy("timestamp", descending: true);

  if (lastReelDoc != null) {
    query = query.startAfterDocument(lastReelDoc!);
  }
  QuerySnapshot snapshot = await query.get();

  if (snapshot.docs.isNotEmpty) {
    lastReelDoc = snapshot.docs.last;
  }

  return snapshot.docs.map((doc) => doc["url"] as String).toList();
}

DocumentSnapshot? lastPostdoc;
Future<List<String>> loadPosts(String userID)async{
  Query query=FirebaseFirestore.instance.collection("posts").limit(8).where("userId",isEqualTo: userID).orderBy("timestamp",descending: true);
  if(lastPostdoc!=null){
    query=query.startAfterDocument(lastPostdoc!);
  }
  QuerySnapshot snapshot=await query.get();

  if(snapshot.docs.isNotEmpty){
    lastPostdoc=snapshot.docs.last;
  }
  return snapshot.docs.map((doc)=>doc["url"] as String).toList();
}

DocumentSnapshot? lastUserProfilePost;

Future<List<Map>> loadProfilePosts() async {
  Query query = FirebaseFirestore.instance
      .collection("posts")
      .orderBy("timestamp", descending: true)
      .limit(6);

  if (lastUserProfilePost != null) {
    query = query.startAfterDocument(lastUserProfilePost!);
  }

  QuerySnapshot snapshot = await query.get();

  if (snapshot.docs.isNotEmpty) {
    lastUserProfilePost = snapshot.docs.last;
  }

  // We'll store handle -> postUrl
 /*  Map<String, String> handleToPostMap = {}; */
  List<Map>  handleToPost=[];

  for (var doc in snapshot.docs) {
    final String postUrl = doc["url"];
    final String userId = doc["userId"];

    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();

    if (userDoc.exists) {
      final String? handle = userDoc.data()?["handle"];
      if (handle != null) {
        handleToPost.add({"handle":handle,"postUrl":postUrl});
      }
    }
  }

  return handleToPost;
}

Future<List<Map>> loadUserPosts(String uid) async {
  Query query = FirebaseFirestore.instance
      .collection("posts")
      .orderBy("timestamp", descending: true)
      .where("userId", isEqualTo: uid)
      .limit(12);

  if (lastUserProfilePost != null) {
    query = query.startAfterDocument(lastUserProfilePost!);
  }

  QuerySnapshot snapshot = await query.get();

  if (snapshot.docs.isNotEmpty) {
    lastUserProfilePost = snapshot.docs.last;
  }

  // We'll store handle -> postUrl
 /*  Map<String, String> handleToPostMap = {}; */
  List<Map>  handleToPost=[];

  handleToPost= snapshot.docs.map((doc) => {"url": doc["url"], "type": doc["mediaType"]}).toList();

  return handleToPost;
}
