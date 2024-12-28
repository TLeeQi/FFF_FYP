// To parse this JSON data, do
//
//     final wiringModel = wiringModelFromJson(jsonString);

import 'dart:convert';

WiringModel wiringModelFromJson(String str) =>
    WiringModel.fromJson(json.decode(str));

String wiringModelToJson(WiringModel data) => json.encode(data.toJson());

class WiringModel {
  bool? success;
  Data? data;
  String? error;

  WiringModel({
    this.success,
    this.data,
    this.error,
  });

  factory WiringModel.fromJson(Map<String, dynamic> json) => WiringModel(
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
  WiringList? wiringList;

  Data({
    this.wiringList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wiringList: json["wiring"] == null
            ? null
            : WiringList.fromJson(json["wiring"]),
      );

  Map<String, dynamic> toJson() => {
        "wiring": wiringList?.toJson(),
      };
}

class WiringList {
  int? currentPage;
  List<Wiring>? wiring;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  WiringList({
    this.currentPage,
    this.wiring,
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

  factory WiringList.fromJson(Map<String, dynamic> json) => WiringList(
        currentPage: json["current_page"],
        wiring: json["data"] == null
            ? []
            : List<Wiring>.from(json["data"]!.map((x) => Wiring.fromJson(x))),
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
        "data": wiring == null
            ? []
            : List<dynamic>.from(wiring!.map((x) => x.toJson())),
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

class Wiring {
  int? id;
  // int? Catid;
  String? type;
  List<String>? fixitem;
  bool? ishavepart;
  String? typesProperty;
  DateTime? appDate; // Changed to DateTime
  String? preferredTime;
  String? details; // Optional
  //String? photo; // Optional
  List<String>? photo;
  String? budget;
  DateTime? createdAt;
  DateTime? updatedAt;
  // String? categoryName;
  String? imageURL;
  bool? isSelected;
  int? productID;

  Wiring({
    this.id,
    // this.Catid,
    this.type,
    this.fixitem,
    this.ishavepart,
    this.typesProperty,
    this.appDate,
    this.preferredTime,
    this.details,
    this.photo,
    this.budget,
    this.createdAt,
    this.updatedAt,
    // this.categoryName,
    this.imageURL,
    this.isSelected = false,
    this.productID,
  });

  factory Wiring.fromJson(Map<String, dynamic> json) {
    print("Wiring JSON: $json");
    print("id: ${json["id"]}, type: ${json["id"]?.runtimeType}");
    // print("Catid: ${json["Catid"]}, type: ${json["Catid"]?.runtimeType}");
    print("type: ${json["type"]}, type: ${json["type"]?.runtimeType}");
    print("fixitem: ${json["fixitem"]}, type: ${json["fixitem"]?.runtimeType}");
    print("ishavepart: ${json["ishavepart"]}, type: ${json["ishavepart"]?.runtimeType}");
    print("typesProperty: ${json["typesProperty"]}, type: ${json["typesProperty"]?.runtimeType}");
    print("appDate: ${json["appDate"]}, type: ${json["appDate"]?.runtimeType}");
    print("preferredTime: ${json["preferredTime"]}, type: ${json["preferredTime"]?.runtimeType}");
    print("details: ${json["details"]}, type: ${json["details"]?.runtimeType}");
    print("photo: ${json["photo"]}, type: ${json["photo"]?.runtimeType}");
    print("budget: ${json["budget"]}, type: ${json["budget"]?.runtimeType}");
    print("createdAt: ${json["created_at"]}, type: ${json["created_at"]?.runtimeType}");
    print("updatedAt: ${json["updated_at"]}, type: ${json["updated_at"]?.runtimeType}");
    print("categoryName: ${json["category_name"]}, type: ${json["category_name"]?.runtimeType}");
    print("imageURL: ${json["image_url"]}, type: ${json["image_url"]?.runtimeType}");
    print("productID: ${json["id"]}, type: ${json["id"]?.runtimeType}");

    return Wiring(
        id: json["id"],
        // Catid: json["Catid"],
        type: json["type"],
        fixitem: json["fixitem"] == null ? null : List<String>.from(json["fixitem"]),
        ishavepart: json["ishavepart"],
        typesProperty: json["typesProperty"],
        appDate: json["appDate"] == null ? null : DateTime.parse(json["appDate"]),
        preferredTime: json["preferredTime"],
        details: json["details"],
        photo: json["photo"] == null ? null : List<String>.from(json["photo"]),
        //photo: json["photo"],
        budget: json["budget"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        //categoryName: json["category_name"],
        imageURL: jsonDecode(json["image_url"]),
        productID: json["id"],
      );      
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        // "Catid": Catid,
        "type": type,
        "fixitem": fixitem == null ? null : List<dynamic>.from(fixitem!),
        "ishavepart": ishavepart,
        "typesProperty": typesProperty,
        "appDate": appDate?.toIso8601String(),
        "preferredTime": preferredTime,
        "details": details,
        "photo": photo == null ? null : List<dynamic>.from(photo!),
        //"photo": photo,
        "budget": budget,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        //"category_name": categoryName,
        "image_url": imageURL,
        "product_id": productID,
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
