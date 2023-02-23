import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet/model/activiry_model.dart';
import 'package:sheet/model/arrival_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sheet/model/departure_model.dart';

class ManifestController{
  List arrivalList=[];
  List departureList=[];
  List activityList=[];

  //GetArrivalData
  Future<List<ArrivalModel>> getArrivalList(arrivalUrl) async {
    return await http.get(Uri.parse(arrivalUrl)).then((response) {
      arrivalList = convert.jsonDecode(response.body) as List;
      var data =  arrivalList.map((json) => ArrivalModel.fromJson(json)).toList();
      return data;
    });
  }

  //GetDepartureData
  Future<List<DepartureModel>> getDepartureList(departureUrl) async {
    return await http.get(Uri.parse(departureUrl)).then((response) {
      departureList = convert.jsonDecode(response.body) as List;
      var data =  departureList.map((json) => DepartureModel.fromJson(json)).toList();
      return data;
    });
  }

  //GetActivityData
  Future<List<ActivityModel>> getActivityList(activityUrl) async {
    return await http.get(Uri.parse(activityUrl)).then((response) {
      activityList= convert.jsonDecode(response.body) as List;
      var data =  activityList.map((json) => ActivityModel.fromJson(json)).toList();
      return data;
    });
  }

  //updateArrival
  Future updateArrival(
    context,
    String arvUpdateUrl,
    sn,
    oldFirstName,
    firstName,
    oldLastName, 
    lastName, 
    oldStatus,
    status,
    oldVehicleType,
    vehicleType, 
    oldVip,
    vip,
    oldCareOf,
    careOf
    ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
      );
      await http.get(Uri.parse("$arvUpdateUrl?Sn=$sn&DeleteLastName=$oldLastName&UpdateLastName=$lastName&DeleteFirstName=$oldFirstName&UpdateFirstName=$firstName&DeleteStatus=$oldStatus&UpdateStatus=$status&DeleteVehicleType=$oldVehicleType&UpdateVehicleType=$vehicleType&DeleteVip=$oldVip&UpdateVip=$vip&DeleteCareOf=$oldCareOf&UpdateCareOf=$careOf"), headers: {})
      .then((value) => Get.back())
      .then((value) => Get.snackbar("Success", "Updated Successfully"));
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", e.toString());
      Get.back();
    }
  }

  //updateACtivity
  Future updateActivity(
    context,
    String actUpdateUrl,
    sn,
    oldFirstName,
    firstName,
    oldLastName, 
    lastName, 
    oldStatus,
    status,
    oldVehicleType,
    vehicleType, 
    oldVip,
    vip,
    oldCareOf,
    careOf
    ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
      );
      await http.get(Uri.parse("$actUpdateUrl?Sn=$sn&DeleteLastName=$oldLastName&UpdateLastName=$lastName&DeleteFirstName=$oldFirstName&UpdateFirstName=$firstName&DeleteStatus=$oldStatus&UpdateStatus=$status&DeleteVehicleType=$oldVehicleType&UpdateVehicleType=$vehicleType&DeleteVip=$oldVip&UpdateVip=$vip&DeleteCareOf=$oldCareOf&UpdateCareOf=$careOf"), headers: {})
      .then((value) => Get.back())
      .then((value) => Get.snackbar("Success", "Updated Successfully"));
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", e.toString());
      Get.back();
    }
  }

  //updateDepartue
  Future updateDeparture(
    context,
    String depUpdateUrl,
    sn,
    oldFirstName,
    firstName,
    oldLastName, 
    lastName, 
    oldStatus,
    status,
    oldVehicleType,
    vehicleType, 
    oldVip,
    vip,
    oldCareOf,
    careOf
    ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
      );
      await http.get(Uri.parse("$depUpdateUrl?Sn=$sn&DeleteLastName=$oldLastName&UpdateLastName=$lastName&DeleteFirstName=$oldFirstName&UpdateFirstName=$firstName&DeleteStatus=$oldStatus&UpdateStatus=$status&DeleteVehicleType=$oldVehicleType&UpdateVehicleType=$vehicleType&DeleteVip=$oldVip&UpdateVip=$vip&DeleteCareOf=$oldCareOf&UpdateCareOf=$careOf"), headers: {})
      .then((value) => Get.back())
      .then((value) => Get.snackbar("Success", "Updated Successfully"));
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", e.toString());
      Get.back();
    }
  }
}