import 'package:eco_world/screens/AccountScreen/components/pagination.dart';
import 'package:eco_world/screens/HomeScreen/components/advertisementbox.dart';
import 'package:eco_world/screens/HomeScreen/components/gallerybox.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  final ScrollController controller=ScrollController();
   List profile=[];
  bool isloading=false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState()  {
    loadNextBatch();
    controller.addListener((){
      if(controller.position.pixels>=controller.position.maxScrollExtent-200){
        loadNextBatch();
      }
    });
    super.initState();
  }
  Future<void>loadNextBatch()async{
    if(isloading) return;
    setState(() {
      isloading=true;
    });
      List newPost=await loadProfilePosts();
    setState(() {
      profile.addAll(newPost);
      isloading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
  var cs=Theme.of(context).colorScheme;
    return Container(
      color:cs.onPrimary ,
      child:  /* profile.isEmpty&&isloading? const Center(child: CircularProgressIndicator(),): */
      SingleChildScrollView(
          controller: controller,
          child: Column(
        children: [
          
          const Advertisementbox(),
          const GalleryboxAsset(postAsset: "IdaAndI.jpg"),
          const GalleryboxAsset(postAsset: "Waterfall.jpeg"),
          const GalleryboxAsset(postAsset: "Myanmar.jpeg"),
          const GalleryboxAsset(postAsset: "tripaGhana.jpg"),
          ...profile.map((element) =>  Gallerybox(postUrl:element["postUrl"] ,),),
          if(isloading)
         const Center(child: CircularProgressIndicator())
         
        ],
      )),
    );
  }
}
