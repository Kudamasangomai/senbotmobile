// import 'package:senbot/model/fleet.dart';

class Repair {
  int? id;
  int? jobnumber;
  int? fleetId;
  int? faultId;
  int? userId;
  String? status;
  String? solved;
  String? workdone;
  // ignore: non_constant_identifier_names
  String? created_at;
  // String? updated_at;
  int? closeby;
  final String fleetNo;
  final String name;
  final String username;

  Repair({
    required this.name,
    required this.fleetNo,
    required this.username,
    this.id,
    this.jobnumber,
    this.fleetId,
    this.faultId,
    this.userId,
    this.status,
    this.solved,
    this.workdone,
    this.closeby,
  });

  Repair.fromJson(Map<String, dynamic> json, this.fleetNo, this.name ,this.username) {
    id = json['id'];
    jobnumber = json['jobnumber'];
    fleetId = json['fleet_id'];
    faultId = json['fault_id'];
    userId = json['user_id'];
    status = json['status'];
    solved = json['solved'];
    workdone = json['workdone'];
    created_at = json['created_at'];
    // updated_at = json['updated_at'];
    closeby = json['closeby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobnumber'] = jobnumber;
    data['fleet_id'] = fleetId;
    data['fault_id'] = faultId;
    data['user_id'] = userId;
    data['status'] = status;
    data['solved'] = solved;
    data['workdone'] = workdone;
    data['closeby'] = closeby;
    return data;
  }

  void add(Repair repairs) {}
}
