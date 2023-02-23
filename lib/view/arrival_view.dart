import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet/controller/manifest_controller.dart';
import 'package:sheet/model/arrival_model.dart';
import 'package:sheet/view/care_of.dart';
import 'package:sheet/view/edit_manifest.dart';
class ArrivalView extends StatefulWidget {
  final String? url;
  final String editUrl;
  const ArrivalView({ Key? key, this.url, required this.editUrl }) : super(key: key);

  @override
  State<ArrivalView> createState() => _ArrivalViewState();
}

class _ArrivalViewState extends State<ArrivalView> {
  List<ArrivalModel> items = [];
    
  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    ManifestController().getArrivalList(widget.url).then((arrivalList) {
      setState(() {
        items = arrivalList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arrival List", style: TextStyle(color: Colors.black),),
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
              if(index != 0 && items[index].careOf == ""){
                return ListTile(
                  onTap: (){
                    Get.to(()=> CareOf(
                      title: "Arrival",
                      url: widget.url,
                      editArvUrl: widget.editUrl, 
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
                      update: "Arrival", 
                      arvUrl: widget.editUrl,
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
                        child: Text(items[index].flight.toString()),
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