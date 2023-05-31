class userData {
  String? username;
  String? fullName;
  String? role;
  String? id;
  String? password;

  userData(
      this.username,
      this.fullName,
      this.role,
      this.id,
      this.password
);

  userData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['fullName'];
    role = json['role'];
    id = json['id'];
  }



  userData.fromSimpleJson(json) {
    username = json['username'];
    fullName = json['fullName'];
    role = json['role'];
    id = json['id'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['role'] = this.role;
    data['id'] = this.id;
    data['password']= this.password;
    return data;
  }
}