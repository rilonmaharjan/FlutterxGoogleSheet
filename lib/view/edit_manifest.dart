import 'package:flutter/material.dart';
import 'package:sheet/controller/manifest_controller.dart';

class EditManifest extends StatefulWidget {
  final String firstName, lastName, status, vehicelType, vip, careOf;
  final String sn, update;
  final String? arvUrl, actUrl, depUrl;
  const EditManifest(
      {Key? key, 
        required this.firstName, 
        required this.lastName, 
        required this.status, 
        required this.vehicelType, 
        required this.vip, 
        required this.careOf, 
        required this.sn, 
        required this.update,
        this.arvUrl, 
        this.actUrl, 
        this.depUrl})
      : super(key: key);

  @override
  State<EditManifest> createState() => _EditManifestState();
}

class _EditManifestState extends State<EditManifest> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vipController = TextEditingController();
  TextEditingController careOfController = TextEditingController();

  @override
  void initState() {
    firstNameController.text =widget.firstName;
    lastNameController.text = widget.lastName;
    statusController.text = widget.status;
    vehicleTypeController.text =widget.vehicelType;
    vipController.text = widget.vip;
    careOfController.text = widget.careOf;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit", style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
        child: Column(
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(
              height: 20,
            ),TextFormField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: vehicleTypeController,
              decoration: const InputDecoration(labelText: 'Vehicle Type'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: vipController,
              decoration: const InputDecoration(labelText: 'VIP'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: careOfController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Care Of'),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: updateForm, 
              child: const Text("Submit")
            ),
          ],
        ),
          ),
      ));
  }

    // Method to Submit and save it in Google Sheets
  void updateForm() {
      ManifestController mainController = ManifestController();
      // Submit 'form' and save it in Google Sheets.
      widget.update == "Arrival" ?
      mainController.updateArrival(
        context,
        widget.arvUrl ?? "",
        widget.sn,
        widget.firstName,
        firstNameController.text,
        widget.lastName,
        lastNameController.text,
        widget.status,
        statusController.text,
        widget.vehicelType,
        vehicleTypeController.text,
        widget.vip,
        vipController.text,
        widget.careOf,
        careOfController.text,
    ) 
    : widget.update == "Activity"
    ? mainController.updateActivity(
        context,
        widget.actUrl ?? "",
        widget.sn,
        widget.firstName,
        firstNameController.text,
        widget.lastName,
        lastNameController.text,
        widget.status,
        statusController.text,
        widget.vehicelType,
        vehicleTypeController.text,
        widget.vip,
        vipController.text,
        widget.careOf,
        careOfController.text,
    ) 
    : mainController.updateDeparture(
        context,
        widget.depUrl ?? "",
        widget.sn,
        widget.firstName,
        firstNameController.text,
        widget.lastName,
        lastNameController.text,
        widget.status,
        statusController.text,
        widget.vehicelType,
        vehicleTypeController.text,
        widget.vip,
        vipController.text,
        widget.careOf,
        careOfController.text,
    );
  }
}
