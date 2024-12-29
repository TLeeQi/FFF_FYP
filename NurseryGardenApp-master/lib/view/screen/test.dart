import 'dart:convert';

// Import your model classes
import 'package:nurserygardenapp/data/model/order_detail_model.dart';
import 'package:nurserygardenapp/data/model/piping_model.dart';

void main() {
  // Example JSON strings
  String validJson = '''
  {
    "success": true,
    "data": {
      "wiring": [
        {
          "id": 26,
          "type": "Maintenance",
          "fixitem": ["Other (Explain in Additional Details)", "Ceiling Fan"],
          "problem": "Other (Explain in Additional Details)",
          "types_property": "Light Commercial (e.g. office, shop, cafe)",
          "app_date": "2024-12-27T16:00:00.000000Z",
          "preferred_time": "Early Afternoon (1 PM - 3 PM)",
          "details": null,
          "photo": null,
          "budget": "RM10000 - RM19999",
          "created_at": "2024-12-28T07:44:14.000000Z",
          "updated_at": "2024-12-28T07:44:14.000000Z",
          "photo_urls": []
        }
      ],
      "order_item": [],
      "delivery_list": []
    },
    "error": null
  }
  ''';

  String nullFieldJson = '''
  {
    "success": true,
    "data": {
      "wiring": [
        {
          "id": null,
          "type": null,
          "fixitem": null,
          "prob": null,
          "types_property": null,
          "app_date": null,
          "preferred_time": null,
          "details": null,
          "photo": null,
          "budget": null,
          "created_at": null,
          "updated_at": null,
          "photo_urls": null
        }
      ],
      "order_item": null,
      "delivery_list": null
    },
    "error": null
  }
  ''';

  // Example JSON string for Piping
  String pipingJson = '''
  {
    "id": 26,
    "type": "Maintenance",
    "fixitem": ["Other (Explain in Additional Details)", "Ceiling Fan"],
    "ishavepart": false,
    "types_property": "Light Commercial (e.g. office, shop, cafe)",
    "app_date": "2024-12-27T16:00:00.000000Z",
    "preferred_time": "Early Afternoon (1 PM - 3 PM)",
    "details": null,
    "photo": null,
    "budget": "RM10000 - RM19999",
    "created_at": "2024-12-28T07:44:14.000000Z",
    "updated_at": "2024-12-28T07:44:14.000000Z",
    "photo_urls": []
  }
  ''';

  // Test parsing with valid JSON
  try {
    print("Testing with valid JSON:");
    OrderDetailModel orderDetail = OrderDetailModel.fromJson(json.decode(validJson));
    print("Parsed OrderDetailModel: ${orderDetail.toJson()}");
  } catch (e) {
    print("Error parsing valid JSON: $e");
  }

  // Test parsing with JSON containing null fields
  try {
    print("\nTesting with JSON containing null fields:");
    OrderDetailModel orderDetail = OrderDetailModel.fromJson(json.decode(nullFieldJson));
    print("Parsed OrderDetailModel: ${orderDetail.toJson()}");
  } catch (e) {
    print("Error parsing JSON with null fields: $e");
  }

  // Test parsing with Piping JSON
  try {
    print("Testing with Piping JSON:");
    Piping piping = Piping.fromJson(json.decode(pipingJson));
    print("Parsed Piping: ${piping.toJson()}");
  } catch (e) {
    print("Error parsing Piping JSON: $e");
  }
}