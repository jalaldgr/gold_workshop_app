class tableData {
  String? status="";
  String? table1="";
  String? table2="";
  String? table3="";
  String? table4="";
  String? table5="";
  String? table6="";



  tableData(
      this.status,
      this.table1,
      this.table2,
      this.table3,
      this.table4,
      this.table5,
      this.table6

);

  tableData.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    table1 = json['table1'] ?? "";
    table2 = json['table2'] ?? "";
    table3 = json['table3'] ?? "";
    table4 = json['table4'] ?? "";
    table5 = json['table5'] ?? "";
    table6 = json['table6'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['table1'] = table1;
    data['table2'] = table2;
    data['table3']= table3;
    data['table4']= table4;
    data['table5']= table5;
    data['table6']= table6;


    return data;
  }
}