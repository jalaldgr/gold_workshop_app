class orderData {
  String? clientFullName="";
  String? plateName="";
  String? description="";
  String? image="";
  String? code="";
  String? weight="";
  String? status="";
  // status:{type:String,enum: ['pending', 'discarded', 'inDesign','inWorkshop1','inWorkshop2','completed','completeDesign','completeWorkshop1','completeWorkshop2' ]},
  String? workshop1fullName="";
  String? workshop1Id="";
  String? workshop1File="";
  String? workshop2fullName="";
  String? workshop2Id="";
  String? workshop2File="";
  String? designerFullName="";
  String? designerId="";
  String? designerFile="";
  String? createdDate="";
  String? id="";
  String? instantDelivery="";
  String? customerDelivery="";
  String? paperDelivery="";
  String? feeOrder="";
  String? orderMeta="";
  String? woocommerceOrderId="";
  String? clientType="";
  String? clientMobile="";
  String? productType="";
  String? deliveryDate="";
  String? orderDate="";
  String? orderType="";
  String? orderRecipient = "";
  String? deficiency = "";

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
      this.productType,
      this.deliveryDate,
      this.orderDate,
      this.orderType,
      this.orderRecipient,
      this.deficiency
);

  orderData.fromJson(Map<String, dynamic> json) {
    clientFullName = json['clientFullName'] !=null ? json['clientFullName']:"";//bellow lines is simplified
    plateName = json['plateName'] ?? "";
    description = json['description'] ?? "";
    image = json['image'] ?? "";
    code = json['code'] ?? "";
    weight = json['weight'] ?? "";
    status = json['status'] ?? "";
    workshop1fullName = json['workshop1fullName'] ?? "";
    workshop1Id = json['workshop1Id'] ?? "";
    workshop1File = json['workshop1File'] ?? "";
    workshop2fullName = json['workshop2fullName'] ?? "";
    workshop2Id = json['workshop2Id'] ?? "";
    workshop2File = json['workshop2File'] ?? "";
    designerFullName = json['designerFullName'] ?? "";
    designerId = json['designerId'] ?? "";
    designerFile = json['designerFile'] ?? "";
    createdDate = json['createdDate'] ?? "";
    id = json['id'] ?? "";
    woocommerceOrderId = json['woocommerceOrderId'] ?? "";
    instantDelivery = json['instantDelivery'] ?? "";
    customerDelivery = json['customerDelivery'] ?? "";
    paperDelivery = json['paperDelivery'] ?? "";
    feeOrder = json['feeOrder'] ?? "";
    orderMeta = json['orderMeta'] ?? "";
    clientMobile = json['clientMobile'] ?? "";
    clientType = json['clientType'] ?? "";
    productType = json['productType'] ?? "";
    deliveryDate = json['deliveryDate'] ?? "";
    orderDate = json['orderDate'] ?? "";
    orderType = json['orderType'] ?? "";
    orderRecipient = json['orderRecipient'] ?? "";
    deficiency = json['deficiency'] ?? "";




  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientFullName'] = clientFullName;
    data['plateName'] = plateName;
    data['id'] = id;
    data['description']= description;
    data['image']= image;
    data['code']= code;
    data['weight']= weight;
    data['status']= status;
    data['workshop1fullName']= workshop1fullName;
    data['workshop1Id']= workshop1Id;
    data['workshop1File']= workshop1File;
    data['workshop2fullName']= workshop2fullName;
    data['workshop2Id']= workshop2Id;
    data['workshop2File']= workshop2File;
    data['designerFullName']= designerFullName;
    data['designerId']= designerId;
    data['designerFile']= designerFile;
    data['createdDate']= createdDate;
    data['woocommerceOrderId']= woocommerceOrderId;
    data['instantDelivery']= instantDelivery;
    data['customerDelivery'] = customerDelivery;
    print(customerDelivery);
    data['paperDelivery']= paperDelivery;
    data['feeOrder']= feeOrder;
    data['orderMeta']= orderMeta;
    data['clientMobile']= clientMobile;
    data['clientType']= clientType;
    data['productType']= productType;
    data['deliveryDate']= deliveryDate;
    data['orderDate']= orderDate;
    data['orderType']= orderType;
    data['orderRecipient']= orderRecipient;
    data['deficiency']= deficiency;




    return data;
  }
}