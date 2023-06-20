class userData {
  String? username;
  String? fullName;
  String? role;
  String? id;
  String? password;
  String? isAdmin;

  userData(
      this.username,
      this.fullName,
      this.role,
      this.id,
      this.password,
      this.isAdmin
);

  userData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['fullName'];
    role = json['role'];
    id = json['id'];
    isAdmin = json['isAdmin'];

  }



  userData.fromSimpleJson(json) {
    username = json['username'];
    fullName = json['fullName'];
    role = json['role'];
    id = json['id'];
    isAdmin = json['isAdmin'];


  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['role'] = this.role;
    data['id'] = this.id;
    data['password']= this.password;
    data['isAdmin']= this.isAdmin;

    return data;
  }
}