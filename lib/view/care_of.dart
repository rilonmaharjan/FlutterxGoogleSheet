import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet/controller/manifest_controller.dart';
import 'package:sheet/model/activiry_model.dart';
import 'package:sheet/model/arrival_model.dart';
import 'package:sheet/model/departure_model.dart';
import 'package:sheet/view/edit_manifest.dart';

class CareOf extends StatefulWidget {
  final String? url, title, editArvUrl, editActUrl, editDepUrl;
  final String sn;
  const CareOf({ Key? key, this.url, required this.sn, required this.title, this.editArvUrl, this.editActUrl, this.editDepUrl }) : super(key: key);

  @override
  State<CareOf> createState() => _CareOfState();
}

class _CareOfState extends State<CareOf> {
  List<ArrivalModel> items = [];
  List<ActivityModel> activityItems = [];
  List<DepartureModel> departureItems = [];
    
  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    ManifestController().getArrivalList(widget.url).then((arrivalList) {
      setState(() {
        items = arrivalList;
      });
    });
    ManifestController().getActivityList(widget.url).then((activityList) {
      setState(() {
        activityItems = activityList;
      });
    });
    ManifestController().getDepartureList(widget.url).then((departureList) {
      setState(() {
        departureItems = departureList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title == "Arrival"
          ? "Care Of Arrvial List"
          : widget.title == "Activity"
          ? "Care of Activity List"
          : "Care of Departure List", 
          style: const TextStyle(color: Colors.black),
        ),
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
          child: widget.title == "Departure" ?
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: departureItems.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if(index != 0 && departureItems[index].co == widget.sn){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ListTile(
                    tileColor: Colors.blue.withOpacity(0.25),
                    onLongPress: () {
                      Get.to(()=> EditManifest(
                        firstName: departureItems[index].firstName, 
                        lastName: departureItems[index].lastName, 
                        status:  departureItems[index].status,
                        vehicelType:  departureItems[index].vehicleType, 
                        vip:  departureItems[index].vip, 
                        careOf:  departureItems[index].co, 
                        sn:  departureItems[index].sn, 
                        update: "Departure", 
                        depUrl: widget.editDepUrl ?? "",
                      ));
                    },
                    title: Padding(
                      padding: const EdgeInsets.only(bottom:3.0),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.person),
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Text("${departureItems[index].firstName} ${departureItems[index].lastName}"),
                          )
                        ],
                      ),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        const Icon(Icons.email),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Text(departureItems[index].status.toString()),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
          :
          widget.title == "Activity" ?
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activityItems.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if(index != 0 && activityItems[index].careOf == widget.sn){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ListTile(
                    tileColor: Colors.blue.withOpacity(0.25),
                    onLongPress: () {
                      Get.to(()=> EditManifest(
                        firstName: activityItems[index].firstName, 
                        lastName: activityItems[index].lastName, 
                        status:  activityItems[index].status,
                        vehicelType:  activityItems[index].vehicleType, 
                        vip:  activityItems[index].vip, 
                        careOf:  activityItems[index].careOf, 
                        sn:  activityItems[index].sn, 
                        update: "Activity", 
                        actUrl: widget.editActUrl ?? "",
                      ));
                    },
                    title: Padding(
                      padding: const EdgeInsets.only(bottom:3.0),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.person),
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Text("${activityItems[index].firstName} ${activityItems[index].lastName}"),
                          )
                        ],
                      ),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        const Icon(Icons.email),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Text(activityItems[index].status.toString()),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
          :ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if(index != 0 && items[index].careOf == widget.sn){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ListTile(
                    tileColor: Colors.blue.withOpacity(0.25),
                    onLongPress: () {
                      Get.to(()=> EditManifest(
                        firstName: items[index].firstName, 
                        lastName: items[index].lastName, 
                        status:  items[index].status,
                        vehicelType:  items[index].vehicleType, 
                        vip:  items[index].vip, 
                        careOf:  items[index].careOf, 
                        sn:  items[index].sn, 
                        update: "Arrival", 
                        arvUrl: widget.editArvUrl ?? "",
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
                          child: Text(items[index].status.toString()),
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