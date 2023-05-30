class orderData {
  String? clientFullName;
  String? plateName;
  String? description;
  String? image;
  String? code;
  String? weight;
  String? status;
  // status:{type:String,enum: ['pending', 'discarded', 'inDesign','inWorkshop1','inWorkshop2','completed','completeDesign','completeWorkshop1','completeWorkshop2' ]},
  String? workshop1fullName;
  String? workshop1Id;
  String? workshop1File;
  String? workshop2fullName;
  String? workshop2Id;
  String? workshop2File;
  String? designerFullName;
  String? designerId;
  String? designerFile;
  String? createdDate;
  String? id;
  String? instantDelivery;
  String? customerDelivery;
  String? paperDelivery;
  String? feeOrder;
  String? orderMeta;
  String? woocommerceOrderId;
  String? clientType;
  String? clientMobile;
  String? productType;


  orderData(
      this.clientFullName,
      this.plateName,
      this.description,
      this.image,
      this.code,
      this.weight,
      this.status,
      this.workshop1fullName,
      this.workshop1Id,
      this.workshop1File,
      this.workshop2fullName,
      this.workshop2Id,
      this.workshop2File,
      this.designerFullName,
      this.designerId,
      this.designerFile,
      this.createdDate,
      this.id,
      this.instantDelivery,
      this.customerDelivery,
      this.paperDelivery,
      this.feeOrder,
      this.orderMeta,
      this.woocommerceOrderId,
      this.clientMobile,
      this.clientType,
      this.productType
);

  orderData.fromJson(Map<String, dynamic> json) {
    clientFullName = json['clientFullName'];
    plateName = json['plateName'];
    description = json['description'];
    image = json['image'];
    code = json['code'];
    weight = json['weight'];
    status = json['status'];
    workshop1fullName = json['workshop1fullName'];
    workshop1Id = json['workshop1Id'];
    workshop1File = json['workshop1File'];
    workshop2fullName = json['workshop2fullName'];
    workshop2Id = json['workshop2Id'];
    workshop2File = json['workshop2File'];
    designerFullName = json['designerFullName'];
    designerId = json['designerId'];
    designerFile = json['designerFile'];
    createdDate = json['createdDate'];
    id = json['id'];
    woocommerceOrderId = json['woocommerceOrderId'];
    instantDelivery = json['instantDelivery'];
    customerDelivery = json['customerDelivery'];
    paperDelivery = json['paperDelivery'];
    feeOrder = json['feeOrder'];
    orderMeta = json['orderMeta'];
    clientMobile = json['clientMobile'];
    clientType = json['clientType'];
    productType = json['productType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientFullName'] = this.clientFullName;
    data['plateName'] = this.plateName;
    data['id'] = this.id;
    data['description']= this.description;
    data['image']= this.image;
    data['code']= this.code;
    data['weight']= this.weight;
    data['status']= this.status;
    data['workshop1fullName']= this.workshop1fullName;
    data['workshop1Id']= this.workshop1Id;
    data['workshop1File']= this.workshop1File;
    data['workshop2fullName']= this.workshop2fullName;
    data['workshop2Id']= this.workshop2Id;
    data['workshop2File']= this.workshop2File;
    data['designerFullName']= this.designerFullName;
    data['designerId']= this.designerId;
    data['designerFile']= this.designerFile;
    data['createdDate']= this.createdDate;
    data['woocommerceOrderId']= this.woocommerceOrderId;
    data['instantDelivery']= this.instantDelivery;
    data['customerDelivery'] = this.customerDelivery;
    data['paperDelivery']= this.paperDelivery;
    data['feeOrder']= this.feeOrder;
    data['orderMeta']= this.orderMeta;
    data['clientMobile']= this.clientMobile;
    data['clientType']= this.clientType;
    data['productType']= this.productType;


    return data;
  }
}