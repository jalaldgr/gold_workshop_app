class tableData {
  String? status="";
  String? table1="";
  String? table2="";
  String? table3="";
  String? table41="";
  String? table42="";
  String? table5="";
  String? table6="";
  String? date="";
  String? createdAt="";
  String? updatedAt="";

  tableData(
      this.status,
      this.table1,
      this.table2,
      this.table3,
      this.table41,
      this.table42,
      this.table5,
      this.table6,
      this.date,
      this.createdAt,
      this.updatedAt
);

  tableData.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    table1 = json['table1'] ?? "";
    table2 = json['table2'] ?? "";
    table3 = json['table3'] ?? "";
    table41 = json['table41'] ?? "";
    table42 = json['table42'] ?? "";
    table5 = json['table5'] ?? "";
    table6 = json['table6'] ?? "";
    date = json['date'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedDate'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['table1'] = table1;
    data['table2'] = table2;
    data['table3']= table3;
    data['table41']= table41;
    data['table42']= table42;
    data['table5']= table5;
    data['table6']= table6;
    data['date']= date;
    data['createdAt']= createdAt;
    data['updatedAt']= updatedAt;
    return data;
  }
}