
class ActivityModel {
  String sn;
  String date;
  String lastName;
  String firstName;
  String status;
  String pickUpTime;
  String returnTime;
  String activity;
  String vehicleType;
  String vip;
  String conf;
  String driverInfo;
  String driverNumber;
  String pickUpLocation;
  String careOf;

  ActivityModel(    
    this.sn,
    this.date,
    this.lastName,
    this.firstName,
    this.status,
    this.pickUpTime,
    this.returnTime,
    this.activity,
    this.vehicleType,
    this.vip,
    this.conf,
    this.driverInfo,
    this.driverNumber,
    this.pickUpLocation,
    this.careOf
  );

  factory ActivityModel.fromJson(dynamic json) {
    return ActivityModel(
      "${json['sn']}",
      "${json['date']}",
      "${json['lastName']}",
      "${json['firstName']}",
      "${json['status']}",
      "${json['pickUpTime']}",
      "${json['runTime']}",
      "${json['activity']}",
      "${json['vehicleType']}",
      "${json['vip']}",
      "${json['conf']}",
      "${json['driverInfo']}",
      "${json['driverNumber']}",
      "${json['pickUpLocation']}",
      "${json['careOf']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
    "sn": sn,
    "date": date,
    "lastName": lastName,
    "firstName": firstName,
    "status": status,
    "pickUpTime": pickUpTime,
    "returnTime": returnTime,
    "activity": activity,
    "vehicleType": vehicleType,
    "vip": vip,
    "conf": conf,
    "driverInfo": driverInfo,
    "driverNumber": driverNumber,
    "pickUpLocation": pickUpLocation,
    "careOf": careOf
  };
}
