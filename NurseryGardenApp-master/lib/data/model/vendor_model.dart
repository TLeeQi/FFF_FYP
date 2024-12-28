import 'dart:convert';

VendorModel vendorModelFromJson(String str) =>
    VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  bool? success;
  Data? data;
  String? error;

  VendorModel({
    this.success,
    this.data,
    this.error,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
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
  VendorsList? vendorsList;

  Data({
    this.vendorsList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        vendorsList: json["vendors"] == null
            ? null
            : VendorsList.fromJson(json["vendors"]),
      );

  Map<String, dynamic> toJson() => {
        "vendors": vendorsList?.toJson(),
      };
}

class VendorsList {
  int? currentPage;
  List<Vendor>? vendor;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String?  nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  VendorsList({
    this.currentPage,
    this.vendor,
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

  factory VendorsList.fromJson(Map<String, dynamic> json) => VendorsList(
        currentPage: json["current_page"],
        vendor: json["data"] == null
            ? []
            : List<Vendor>.from(json["data"]!.map((x) => Vendor.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": vendor == null
            ? []
            : List<dynamic>.from(vendor!.map((x) => x.toJson())),
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
  String? imageURL;
  String? status;
  String? description;

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
    this.imageURL,
    this.status,
    this.description,
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
        imageURL: jsonDecode(json["image_url"]),
        status: json["status"],
        description: json["description"],
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
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageURL,
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
