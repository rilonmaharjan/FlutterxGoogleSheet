import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet/view/act_view.dart';
import 'package:sheet/view/add_manifest.dart';
import 'package:sheet/view/bottom_nav.dart';

class ManifestList extends StatefulWidget {
  const ManifestList({ Key? key }) : super(key: key);

  @override
  State<ManifestList> createState() => _ManifestListState();
}

class _ManifestListState extends State<ManifestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manifest List', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=> const AddManifest());
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('manifest').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                    return const Text(
                      'Loading...',
                    );
                  } else {
                    List<QueryDocumentSnapshot<Object?>> firestoreItems = snapshot.data!.docs;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top:8),
                        itemCount: firestoreItems.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)
                        {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                Get.to(() => 
                                  firestoreItems[index]['actUrl'] != "" 
                                  ? ActivityView( 
                                      url: firestoreItems[index]['actUrl'],
                                      editUrl: firestoreItems[index]['editActUrl'],
                                  )

                                  : firestoreItems[index]['arvUrl']  != "" && firestoreItems[index]['depUrl'] != "" 
                                  ? BottomNav(
                                      index: 0,
                                      arvUrl: firestoreItems[index]['arvUrl'],
                                      depUrl:firestoreItems[index]['depUrl'],
                                      editArvUrl: firestoreItems[index]['editArvUrl'],
                                      depEditUrl: firestoreItems[index]['editDepUrl'],
                                  )
                                  
                                  : firestoreItems[index]['arvUrl']  != "" 
                                  ? BottomNav(
                                      index: 0,
                                      arvUrl: firestoreItems[index]['arvUrl'],
                                      editArvUrl: firestoreItems[index]['editArvUrl'],
                                  )

                                  : BottomNav(
                                      index: 1,
                                      depUrl: firestoreItems[index]['depUrl'],
                                      depEditUrl: firestoreItems[index]['editDepUrl'],
                                  )
                                );
                              },
                              onLongPress: (){
                                Get.bottomSheet(
                                  deleteBottomSheet(firestoreItems[index])
                                );
                              },
                              child: Container(
                                padding:const EdgeInsets.all(20.0) ,
                                color: const Color.fromARGB(151, 76, 175, 79),
                                child: Text(firestoreItems[index]['title']),
                              ),
                            ),
                          );
                        }
                      ),
                    );
                  }
              }
            ),
            const SizedBox(height: 60,)
          ],
        ),
      ),
    );
  }

  deleteBottomSheet(data) {
    return Container(
      height: 136.0,
      decoration: const BoxDecoration(
        color: Color(0xfff5f5f5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0) ,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.back();
                Get.to(()=> AddManifest(
                  update: true,
                  editArvUrl: data["editArvUrl"],
                  editDepUrl: data["editDepUrl"],
                  editActUrl: data["editActUrl"],
                  getActUrl: data["actUrl"],
                  getArvUrl: data["arvUrl"],
                  getDepUrl: data["depUrl"],
                  title: data["title"],
                  id: data['id'] == "" ? data['title'].toString() : data['id'].toString(),
                ));
              },
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                width: 300.0,
                height: 42.0,
                child: const Center(
                  child: Text('Update',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: () {
                delete(data['id'] == "" ? data['title']:data['id']);
                Get.back();
              },
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                width: 300.0,
                height: 42.0,
                child: const Center(
                  child: Text('Delete',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<void> delete(id) async{
    try{
      await FirebaseFirestore.instance
        .collection("manifest")
        .doc(id)
        .delete()
        .then((value) => Get.snackbar(
        "Deleted", "User Deleted Succesfully",
        )
      );
    } on FirebaseException catch (e){
      debugPrint(e.toString());
    }
  }
}