// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:FFF/data/model/delivery_model.dart';
import 'package:FFF/data/model/plant_model.dart';
import 'package:FFF/data/model/product_model.dart';
import 'package:FFF/data/model/wiring_model.dart'; 
import 'package:FFF/data/model/piping_model.dart';
import 'package:FFF/data/model/gardening_model.dart';
import 'package:FFF/data/model/runner_model.dart';


OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  bool? success;
  Data? data;
  String? error;

  OrderDetailModel({
    this.success,
    this.data,
    this.error,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    print("OrderDetailModel JSON: $json");
    print("success: ${json["success"]}, type: ${json["success"]?.runtimeType}");
    print("data: ${json["data"]}, type: ${json["data"]?.runtimeType}");
    print("error: ${json["error"]}, type: ${json["error"]?.runtimeType}");

    return OrderDetailModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  String? order_address;
  List<Plant>? plant;
  List<Product>? product;
  List<OrderItem>? orderItem;
  List<Delivery>? delivery;
  List<Wiring>? wiring;
  //Wiring? wiring;
  List<Piping>? piping;
  List<Gardening>? gardening;
  List<Runner>? runner;

  Data({
    this.order_address,
    this.plant,
    this.product,
    this.orderItem,
    this.delivery,
    this.wiring,
    this.piping,
    this.gardening,
    this.runner,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    print("Parsing Data: $json");
    print("order_address: ${json["order_address"]}, type: ${json["order_address"]?.runtimeType}");
    print("plant: ${json["plant"]}, type: ${json["plant"]?.runtimeType}");
    print("product: ${json["product"]}, type: ${json["product"]?.runtimeType}");
    print("orderItem: ${json["order_item"]}, type: ${json["order_item"]?.runtimeType}");
    print("delivery: ${json["delivery_list"]}, type: ${json["delivery_list"]?.runtimeType}");
    print("wiring: ${json["wiring"]}, type: ${json["wiring"]?.runtimeType}");
    print("piping: ${json["piping"]}, type: ${json["piping"]?.runtimeType}");
    print("gardening: ${json["gardening"]}, type: ${json["gardening"]?.runtimeType}");
    print("runner: ${json["runner"]}, type: ${json["runner"]?.runtimeType}");

    return Data(
        order_address: json["order_address"] ?? '',
        plant: json["plant"] == null
            ? []
            : List<Plant>.from(json["plant"]!.map((x) => Plant.fromJson(x))),
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"]!.map((x) => Product.fromJson(x))),
        orderItem: json["order_item"] == null
            ? []
            : List<OrderItem>.from(
                json["order_item"]!.map((x) => OrderItem.fromJson(x))),
        delivery: json["delivery_list"] == null
            ? []
            : List<Delivery>.from(
                json["delivery_list"]!.map((x) => Delivery.fromJson(x))),
        wiring: json["wiring"] == null
            ? []
            : List<Wiring>.from(
                json["wiring"]!.map((x) => Wiring.fromJson(x))),
       // wiring: json["wiring"] == null ? null : Wiring.fromJson(json["wiring"]),

        piping: json["piping"] == null
            ? []
            : List<Piping>.from(
                json["piping"]!.map((x) => Piping.fromJson(x))),  
        gardening: json["gardening"] == null
            ? []
            : List<Gardening>.from(
                json["gardening"]!.map((x) => Gardening.fromJson(x))),
        runner: json["runner"] == null
            ? []
            : List<Runner>.from(
                json["runner"]!.map((x) => Runner.fromJson(x))),
      );
  }
  Map<String, dynamic> toJson() => {
        "plant": plant == null
            ? []
            : List<dynamic>.from(plant!.map((x) => x.toJson())),
        "product": product == null
            ? []
            : List<dynamic>.from(product!.map((x) => x.toJson())),
        "order_item": orderItem == null
            ? []
            : List<dynamic>.from(orderItem!.map((x) => x.toJson())),
        "delivery_list": delivery == null
            ? []
            : List<dynamic>.from(delivery!.map((x) => x.toJson())),
        "wiring": wiring == null
            ? []
            : List<dynamic>.from(wiring!.map((x) => x.toJson())),
        //"wiring": wiring?.toJson(),
        "piping": piping == null
            ? []
            : List<dynamic>.from(piping!.map((x) => x.toJson())),
        "gardening": gardening == null
            ? []
            : List<dynamic>.from(gardening!.map((x) => x.toJson())),
        "runner": runner == null
            ? []
            : List<dynamic>.from(runner!.map((x) => x.toJson())),
      };

}

class OrderItem {
  int? id;
  int? quantity;
  double? price;
  double? amount;
  int? orderId;
  String? remark;
  dynamic cartId;
  int? productId;
  int? plantId;
  int? wiringId;
  int? pipingId;
  int? gardeningId;
  int? runnerId;
  dynamic biddingId;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderItem({
    this.id,
    this.quantity,
    this.price,
    this.amount,
    this.orderId,
    this.remark,
    this.cartId,
    this.productId,
    this.plantId,
    this.biddingId,
    this.wiringId,
    this.pipingId,
    this.gardeningId,
    this.runnerId,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        amount: json["amount"]?.toDouble(),
        orderId: json["order_id"],
        remark: json["remark"] ?? null,
        cartId: json["cart_id"],
        productId: json["product_id"],
        plantId: json["plant_id"],
        biddingId: json["bidding_id"],
        wiringId: json["wiring_id"],
        pipingId: json["piping_id"],
        gardeningId: json["gardening_id"],
        runnerId: json["runner_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "amount": amount,
        "order_id": orderId,
        "remark": remark,
        "cart_id": cartId,
        "product_id": productId,
        "plant_id": plantId,
        "bidding_id": biddingId,
        "wiring_id": wiringId,
        "piping_id": pipingId,
        "gardening_id": gardeningId,
        "runner_id": runnerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}