class userData {
  String? username;
  String? fullName;
  String? role;

  userData(
      this.username,
      this.fullName,
      this.role,
);

  userData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['fullName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['role'] = this.role;
    return data;
  }

  userData.fromSimpleJson( json) {
    username = json['username'];
    fullName = json['fullName'];
    role = json['role'];
  }

}