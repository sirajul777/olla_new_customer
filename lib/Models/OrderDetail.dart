// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  OrderDetail({
    this.orderId,
    this.invoice,
    this.grandTotal,
    this.subTotal,
    this.adminFee,
    this.discount,
    this.statusOrder,
    this.orderSummary,
    this.payments,
    this.partner,
  });

  int? orderId;
  String? invoice;
  int? grandTotal;
  int? subTotal;
  int? adminFee;
  int? discount;
  int? statusOrder;
  OrderSummary? orderSummary;
  Payments? payments;
  dynamic? partner;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderId: json["order_id"],
        invoice: json["invoice"],
        grandTotal: json["grand_total"],
        subTotal: json["sub_total"],
        adminFee: json["admin_fee"],
        discount: json["discount"],
        statusOrder: json["status_order"],
        orderSummary: OrderSummary.fromJson(json["order_summary"]),
        payments: Payments.fromJson(json["payments"]),
        partner: json["partner"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "invoice": invoice,
        "grand_total": grandTotal,
        "sub_total": subTotal,
        "admin_fee": adminFee,
        "discount": discount,
        "status_order": statusOrder,
        "order_summary": orderSummary!.toJson(),
        "payments": payments!.toJson(),
        "partner": partner,
      };
}

class OrderSummary {
  OrderSummary({
    this.package,
    this.schedule,
  });

  List<Package>? package;
  Schedule? schedule;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        package:
            List<Package>.from(json["package"].map((x) => Package.fromJson(x))),
        schedule: Schedule.fromJson(json["schedule"]),
      );

  Map<String, dynamic> toJson() => {
        "package": List<dynamic>.from(package!.map((x) => x.toJson())),
        "schedule": schedule!.toJson(),
      };
}

class Package {
  Package({
    this.id,
    this.name,
    this.qty,
    this.price,
    this.isDone,
    this.partnerPackageId,
  });

  int? id;
  String? name;
  int? qty;
  int? price;
  int? isDone;
  int? partnerPackageId;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        qty: json["qty"],
        price: json["price"],
        isDone: json["is_done"],
        partnerPackageId: json["partner_package_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "qty": qty,
        "price": price,
        "is_done": isDone,
        "partner_package_id": partnerPackageId,
      };
}

class Schedule {
  Schedule({
    this.workingDate,
    this.workingTime,
    this.address,
  });

  DateTime? workingDate;
  String? workingTime;
  String? address;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        workingDate: DateTime.parse(json["working_date"]),
        workingTime: json["working_time"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "working_date":
            "${workingDate!.year.toString().padLeft(4, '0')}-${workingDate!.month.toString().padLeft(2, '0')}-${workingDate!.day.toString().padLeft(2, '0')}",
        "working_time": workingTime,
        "address": address,
      };
}

class Payments {
  Payments({
    this.type,
    this.methodPaymentId,
    this.methodPaymentName,
    this.status,
    this.image,
    this.phone,
  });

  String? type;
  dynamic methodPaymentId;
  dynamic methodPaymentName;
  dynamic status;
  String? image;
  String? phone;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        type: json["type"],
        methodPaymentId: json["method_payment_id"],
        methodPaymentName: json["method_payment_name"],
        status: json["status"],
        image: json["image"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "method_payment_id": methodPaymentId,
        "method_payment_name": methodPaymentName,
        "status": status,
        "image": image,
        "phone": phone,
      };
}
