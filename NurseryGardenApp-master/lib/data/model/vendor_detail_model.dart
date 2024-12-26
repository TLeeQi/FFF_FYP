// To parse this JSON data, do
//
//     final biddingDetailModel = biddingDetailModelFromJson(jsonString);

import 'dart:convert';

VendorDetailModel vendorDetailModelFromJson(String str) =>
    VendorDetailModel.fromJson(json.decode(str));

String vendorDetailModelToJson(VendorDetailModel data) =>
    json.encode(data.toJson());

class VendorDetailModel {
  bool? success;
  Data? data;
  String? error;

  VendorDetailModel({
    this.success,
    this.data,
    this.error,
  });

  factory VendorDetailModel.fromJson(Map<String, dynamic> json) =>
      VendorDetailModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  Vendor? vendor;

  Data({
    this.vendor,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor?.toJson(),
      };
}

class Vendor {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vendor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.image,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "image": image,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}