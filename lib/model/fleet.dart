class Fleet {
  int? id;
  String? fleetno;
  String? fleetDescription;
  String?createdAt;
  String? updatedAt;
  String? slug;

  Fleet( 
      {this.id,
      required this.fleetno,
      required this.fleetDescription,
      this.createdAt,
      this.updatedAt,
      this.slug,});

  Fleet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fleetno = json['fleetno'];
    fleetDescription = json['fleet_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fleetno'] = fleetno;
    data['fleet_description'] = fleetDescription;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['slug'] = slug;
    return data;
  }
}
