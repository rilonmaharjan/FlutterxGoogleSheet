
class DepartureModel {
    String sn;
    String departureDate;
    String lastName;
    String firstName;
    String hotelDeparture;
    String flightTime;
    String airline;
    String flightNumber;
    String departureAirport;
    String vehicleType;
    String vip;
    String conf;
    String departureHotel;
    String status;
    String driverName;
    String driverNumber;
    String co;
    String notes;

  DepartureModel(    
    this.sn,
    this.departureDate,
    this.lastName,
    this.firstName,
    this.hotelDeparture,
    this.flightTime,
    this.airline,
    this.flightNumber,
    this.departureAirport,
    this.vehicleType,
    this.vip,
    this.conf,
    this.departureHotel,
    this.status,
    this.driverName,
    this.driverNumber,
    this.co,
    this.notes,
);

  factory DepartureModel.fromJson(dynamic json) {
    return DepartureModel(
      "${json['sn']}",
      "${json['departureDate']}",
      "${json['lastName']}",
      "${json['firstName']}",
      "${json['hotelDeparture']}",
      "${json['flightTime']}",
      "${json['airline']}",
      "${json['flightNumber']}",
      "${json['departureAirport']}",
      "${json['vehicleType']}",
      "${json['vip']}",
      "${json['conf']}",
      "${json['departureHotel']}",
      "${json['status']}",
      "${json['driverName']}",
      "${json['driverNumber']}",
      "${json['co']}",
      "${json['notes']}",
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
    "sn": sn,
    "departureDate": departureDate,
    "lastName": lastName,
    "firstName": firstName,
    "hotelDeparture": hotelDeparture,
    "flightTime": flightTime,
    "airline": airline,
    "flightNumber": flightNumber,
    "departureAirport": departureAirport,
    "vehicleType": vehicleType,
    "vip": vip,
    "conf": conf,
    "departureHotel": departureHotel,
    "status": status,
    "driverName": driverName,
    "driverNumber": driverNumber,
    "co": co,
    "notes": notes,
  };
}