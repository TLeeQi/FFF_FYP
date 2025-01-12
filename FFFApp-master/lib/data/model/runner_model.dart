// To parse this JSON data, do
//
//     final wiringModel = wiringModelFromJson(jsonString);

import 'dart:convert';

RunnerModel runnerModelFromJson(String str) =>
    RunnerModel.fromJson(json.decode(str));

String runnerModelToJson(RunnerModel data) => json.encode(data.toJson());

class RunnerModel {
  bool? success;
  Data? data;
  String? error;

  RunnerModel({
    this.success,
    this.data,
    this.error,
  });

  factory RunnerModel.fromJson(Map<String, dynamic> json) => RunnerModel(
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
  RunnersList? runnersList;

  Data({
    this.runnersList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        runnersList: json["runners"] == null
            ? null
            : RunnersList.fromJson(json["runners"]),
      );

  Map<String, dynamic> toJson() => {
        "runners": runnersList?.toJson(),
      };
}

class RunnersList {
  int? currentPage;
  List<Runner>? runner;
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

  RunnersList({
    this.currentPage,
    this.runner,
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

  factory RunnersList.fromJson(Map<String, dynamic> json) => RunnersList(
        currentPage: json["current_page"],
        runner: json["data"] == null
            ? []
            : List<Runner>.from(json["data"]!.map((x) => Runner.fromJson(x))),
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
        "data": runner == null
            ? []
            : List<dynamic>.from(runner!.map((x) => x.toJson())),
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

class Runner {
  int? id;
  //int? Catid;
  String? type;
  String? area;
  DateTime? appDate; // Changed to DateTime
  String? preferredTime;
  String? details; // Optional
  String? photo; // Optional
  String? budget;
  DateTime? createdAt;
  DateTime? updatedAt;
  //String? categoryName;
  String? imageURL;
  bool? isSelected;
  int? productID; // Optional

  Runner({
    this.id,
    //this.Catid,
    this.type,
    this.area,
    this.appDate,
    this.preferredTime,
    this.details,
    this.photo,
    this.budget,
    this.createdAt,
    this.updatedAt,
    //this.categoryName,
    this.imageURL,
    this.isSelected = false,
    this.productID,
    });

  factory Runner.fromJson(Map<String, dynamic> json) {
    print("Runner JSON: $json");
    print("id: ${json["id"]}, type: ${json["id"]?.runtimeType}");
    // print("Catid: ${json["Catid"]}, type: ${json["Catid"]?.runtimeType}");
    print("type: ${json["type"]}, type: ${json["type"]?.runtimeType}");
    print("area: ${json["area"]}, type: ${json["area"]?.runtimeType}");
    print("appDate: ${json["app_date"]}, type: ${json["app_date"]?.runtimeType}");
    print("preferredTime: ${json["preferred_time"]}, type: ${json["preferred_time"]?.runtimeType}");
    print("details: ${json["details"]}, type: ${json["details"]?.runtimeType}");
    print("photo: ${json["photo"]}, type: ${json["photo"]?.runtimeType}");
    print("budget: ${json["budget"]}, type: ${json["budget"]?.runtimeType}");
    print("createdAt: ${json["created_at"]}, type: ${json["created_at"]?.runtimeType}");
    print("updatedAt: ${json["updated_at"]}, type: ${json["updated_at"]?.runtimeType}");
    print("categoryName: ${json["category_name"]}, type: ${json["category_name"]?.runtimeType}");
    print("imageURL: ${json["image_url"]}, type: ${json["image_url"]?.runtimeType}");
    print("productID: ${json["product_id"]}, type: ${json["product_id"]?.runtimeType}");

    return Runner(
        id: json["id"],
        //Catid: json["Catid"],
        type: json["type"],
        area: json["area"],
        appDate: json["app_date"] == null ? null : DateTime.parse(json["app_date"]),
        preferredTime: json["preferred_time"],
        details: json["details"],
        photo: json["photo"],
        budget: json["budget"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        //categoryName: json["category_name"],
        //imageURL: jsonDecode(json["image_url"]),
        imageURL: json["image_url"],
        productID: json["product_id"],
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
       // "Catid": Catid,
        "type": type,
        "area": area,
        "appDate": appDate?.toIso8601String(),
        "preferredTime": preferredTime,
        "details": details,
        "photo": photo,
        "budget": budget,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
       // "category_name": categoryName,
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
