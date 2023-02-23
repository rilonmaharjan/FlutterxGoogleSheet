import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet/controller/manifest_controller.dart';
import 'package:sheet/model/departure_model.dart';
import 'package:sheet/view/care_of.dart';

import 'edit_manifest.dart';

class DepartureView extends StatefulWidget {
  final String? url, editUrl;
  const DepartureView({ Key? key, this.url, this.editUrl }) : super(key: key);

  @override
  State<DepartureView> createState() => _DepartureViewState();
}

class _DepartureViewState extends State<DepartureView> {
  List<DepartureModel> items = [];
  Timer? timer;
    
  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
   if(mounted){
      timer = Timer.periodic(const Duration(milliseconds: 3000), (Timer t) => getDepartureList());
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    timer; 
    super.dispose();
  }


  getDepartureList(){
    ManifestController().getDepartureList(widget.url).then((departureList) {
      setState(() {
        items = departureList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Departure List", style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: widget.url == "" || widget.url == null
      ? SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
            child: Text("No Data")
        ),
      )
      : SingleChildScrollView(
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
              if(index != 0 && items[index].co == ""){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ListTile(
                    tileColor: Colors.grey.withOpacity(0.15),
                    onTap: (){
                      Get.to(()=> CareOf(
                        title: "Departure",
                        url: widget.url,
                        editDepUrl: widget.editUrl, 
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
                        careOf:  items[index].co, 
                        sn:  items[index].sn, 
                        update: "Departure", 
                        depUrl: widget.editUrl,
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
                          child: Text(items[index].airline.toString()),
                        )
                      ],
                    ),
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