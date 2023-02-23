import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet/controller/manifest_controller.dart';
import 'package:sheet/model/activiry_model.dart';
import 'package:sheet/view/care_of.dart';

import 'edit_manifest.dart';

class ActivityView extends StatefulWidget {
  final String? url;
  final String editUrl;
  const ActivityView({ Key? key, this.url, required this.editUrl }) : super(key: key);

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  List<ActivityModel> items = [];
    
  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    ManifestController().getActivityList(widget.url).then((activityList) {
      setState(() {
        items = activityList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity List", style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: items.isEmpty ? SizedBox(
          height: MediaQuery.of(context).size.height-kToolbarHeight,
          child: const Center(child: CircularProgressIndicator(),)
        ) :
        Container(
          padding: const EdgeInsets.fromLTRB(5,10,10,10),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if(index != 0 && items[index].careOf == ""){
                return ListTile(
                  onTap: (){
                    Get.to(()=> CareOf(
                      title: "Activity",
                      url: widget.url,
                      editActUrl: widget.editUrl, 
                      sn: items[index].sn
                    ));
                  },
                  onLongPress: () {
                    Get.to(()=> EditManifest(
                      firstName: items[index].firstName, 
                      lastName: items[index].lastName, 
                      status:  items[index].status,
                      vehicelType:  items[index].vehicleType, 
                      vip:  items[index].vip, 
                      careOf:  items[index].careOf, 
                      sn:  items[index].sn, 
                      update: "Activity", 
                      actUrl: widget.editUrl,
                    ));
                  },
                  title: Padding(
                    padding: const EdgeInsets.only(bottom:3.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.person),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Text("${items[index].firstName} ${items[index].lastName}"),
                        )
                      ],
                    ),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      const Icon(Icons.email),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Text(items[index].pickUpTime.toString()),
                      )
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      )
    );
  }
}