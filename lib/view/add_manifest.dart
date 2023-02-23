import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddManifest extends StatefulWidget {
  final bool? update;
  final String? id;
  const AddManifest({ Key? key, this.update, this.id }) : super(key: key);

  @override
  State<AddManifest> createState() => _AddManifestState();
}

class _AddManifestState extends State<AddManifest> {
  TextEditingController titleController = TextEditingController();
  TextEditingController actController = TextEditingController();
  TextEditingController arvController = TextEditingController();
  TextEditingController depController = TextEditingController();
  TextEditingController editActController = TextEditingController();
  TextEditingController editArvController = TextEditingController();
  TextEditingController editDepController = TextEditingController();
  var manifest = "Act";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.update == true ? 'Update Manifest' : 'Add Manifest', 
        style: const TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title'
                ),
              ),
              const SizedBox(height: 20,),
              widget.update == true ? const SizedBox() :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        manifest = "Act";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: manifest == "Act" ? Colors.blue : Colors.grey,
                      padding: const EdgeInsets.all(12),
                    ), 
                    child: const Text("Activity"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        manifest = "Dep";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: manifest == "Dep" ? Colors.blue : Colors.grey,
                      padding: const EdgeInsets.all(12),
                    ), 
                    child: const Text("Arrival/Departure"),
                  )
                ],
              ),
              const SizedBox(height: 10,), 
              widget.update == true ? const SizedBox() :
              manifest == "Act"
              ? Column(
                children: [
                  TextFormField(
                    controller: actController,
                    decoration: const InputDecoration(
                      labelText: 'Get Activity Url'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: editActController,
                    decoration: const InputDecoration(
                      labelText: 'Update Activity Url'
                    ),
                  ),
                ],
              )
              : Column(
                children: [
                  TextFormField(
                    controller: arvController,
                    decoration: const InputDecoration(
                      labelText: 'Get Arrival Url'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: depController,
                    decoration: const InputDecoration(
                      labelText: 'Get Departure Url'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: editArvController,
                    decoration: const InputDecoration(
                      labelText: 'Update Arrival Url'
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: editDepController,
                    decoration: const InputDecoration(
                      labelText: 'Update Departure Url'
                    ),
                  )
                ],
              ),
              widget.update == true ? const SizedBox() :
              const SizedBox(height: 25,),
              ElevatedButton(
                onPressed: widget.update == true ? 
                (){
                  update(widget.id); 
                } 
                : upload, 
                child: const Text("Submit")
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  upload() async{
    var time = DateTime.now().toString();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection("manifest").doc(time);
      Map<String, dynamic> data = {
        'title' : titleController.text,
        'actUrl' : actController.text,
        'arvUrl' : arvController.text,
        'depUrl' : depController.text,
        'editActUrl' : editActController.text,
        'editArvUrl' : editArvController.text,
        'editDepUrl' : editDepController.text,
        'id' : time,
      };
      await documentReferencer.set(data).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));
    
  }
  
  Future<void> update(id) async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection("manifest").doc(id.toString());
      Map<String, dynamic> data = {
        'title' : titleController.text,
      };
      await documentReferencer.set(data).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context)); 
  }
}