import 'dart:convert';

VendorModel vendorModelFromJson(String str) =>
    VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  bool? success;
  VendorData? data;
  String? error;

  VendorModel({
    this.success,
    this.data,
    this.error,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
        success: json["success"],
        data: json["data"]?["vendors"] == null
            ? null
            : VendorData.fromJson(json["data"]["vendors"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "error": error,
      };
}

class VendorData {
  int? currentPage;
  List<Vendor>? vendors;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  VendorData({
    this.currentPage,
    this.vendors,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) => VendorData(
        currentPage: json["current_page"],
        vendors: json["data"] == null
            ? []
            : List<Vendor>.from(json["data"].map((x) => Vendor.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": vendors == null
            ? []
            : List<dynamic>.from(vendors!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Vendor {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  double? rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;
  String? status;

  Vendor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.status,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        rating: json["rating"] != null
            ? double.tryParse(json["rating"].toString()) ?? 0.0
            : null,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "rating": rating,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
