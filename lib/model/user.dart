class User {
  List<Users>? users;

  User({this.users});

  User.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Users {
  int? id;
  String? name;
  String? slug;
  int? isAdmin;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? isSuperUser;

  Users(
      {this.id,
      this.name,
      this.slug,
      this.isAdmin,
      this.email,
  
      this.createdAt,
      this.updatedAt,

      this.isSuperUser});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    isAdmin = json['is_admin'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSuperUser = json['is_super_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['is_admin'] = isAdmin;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_super_user'] = isSuperUser;
    return data;
  }
}
