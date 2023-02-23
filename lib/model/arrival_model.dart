/// FeedbackForm is a data class which stores data fields of Feedback.
class ArrivalModel {
  String sn;
  String date;
  String firstName;
  String lastName;
  String status;
  String arrivalTime;
  String airLine;
  String flight;
  String airport;
  String origin;
  String terminal;
  String vehicleType;
  String vip;
  String conf;
  String driverInfo;
  String driverNumber;
  String dropLocation;
  String careOf;

  ArrivalModel(    
    this.sn,
    this.date,
    this.firstName,
    this.lastName,
    this.status,
    this.arrivalTime,
    this.airLine,
    this.flight,
    this.airport,
    this.origin,
    this.terminal,
    this.vehicleType,
    this.vip,
    this.conf,
    this.driverInfo,
    this.driverNumber,
    this.dropLocation,
    this.careOf
    );

  factory ArrivalModel.fromJson(dynamic json) {
    return ArrivalModel(
      "${json['sn']}",
      "${json['date']}",
      "${json['firstName']}",
      "${json['lastName']}",
      "${json['status']}",
      "${json['arrivalTime']}",
      "${json['airline']}",
      "${json['flight']}",
      "${json['airport']}",
      "${json['origin']}",
      "${json['terminal']}",
      "${json['vehicleType']}",
      "${json['vip']}",
      "${json['conf']}",
      "${json['driverInfo']}",
      "${json['driverNumber']}",
      "${json['dropLocation']}",
      "${json['careOf']}",
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'sn' : sn,
        'date': date,
        'firstName': firstName,
        'lastName': lastName,
        'status' : status,
        'arrivalTime': arrivalTime,
        'airline': airLine,
        'flight': flight,
        'airport' : airport,
        'origin': origin,
        'terminal': terminal,
        'vehicleType': vehicleType,
        'vip' : vip,
        'conf': conf,
        'driverInfo': driverInfo,
        'driverNumber': driverNumber,
        'dropLocation' : dropLocation,
        'careOf': careOf,
      };
}