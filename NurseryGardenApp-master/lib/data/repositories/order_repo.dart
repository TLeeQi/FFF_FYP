import 'package:dio/dio.dart';
import 'package:nurserygardenapp/data/dio/dio_client.dart';
import 'package:nurserygardenapp/data/exception/api_error_handler.dart';
import 'package:nurserygardenapp/data/model/cart_model.dart';
import 'package:nurserygardenapp/data/model/order_model.dart';
import 'package:nurserygardenapp/data/model/response/api_response.dart';
import 'package:nurserygardenapp/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart'; // Add this import


class OrderRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  OrderRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getOrder(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.ORDER_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetail(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.ORDER_DETAIL_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addOrder(List<Cart> cartList, String address) async {
    try {
      final List<Map<String, dynamic>> cartListJson =
          cartList.map((cart) => cart.toJson()).toList();

      Response response = await dioClient.post(
        AppConstants.ORDER_CREATE_URL,
        data: {"cart_list": cartListJson, "address": address},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeWiringDetail(Map<String, dynamic> wiringData) async {
    try {
      Response response = await dioClient.post(
        AppConstants.ORDER_WIRING_DETAIL_URI, 
        data: wiringData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> uploadWiringImages(List<File> photos, String key) async {
    try {
        // Convert photos into a list of MultipartFiles
      // List<MultipartFile> photoFiles = photos.map((photo) {
      //   return MultipartFile.fromFileSync(photo.path, filename: photo.path.split('/').last);
      // }).toList();
      // List<MultipartFile> photoFiles = [];
      // for (File photo in photos) {
      //   photoFiles.add(await MultipartFile.fromFile
      //   (photo.path, filename: photo.path.split('/').last));
      // }

       FormData formData = FormData();
        for (int i = 0; i < photos.length; i++) {
            formData.files.add(MapEntry(
              'photos[]', // Ensure the key matches the backend
              await MultipartFile.fromFile(photos[i].path, filename: basename(photos[i].path)),
            ));
          }

      Response response = await dioClient.post(
        AppConstants.ORDER_WIRING_IMAGES_URI,
        data: formData,
      );
        return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storePipingDetail(Map<String, dynamic> pipingData) async {
    try {
      Response response = await dioClient.post(
        AppConstants.ORDER_PIPING_DETAIL_URI, 
        data: pipingData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeGardeningDetail(Map<String, dynamic> gardeningData) async {
    try {
      Response response = await dioClient.post(
        AppConstants.ORDER_GARDENING_DETAIL_URI, 
        data: gardeningData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeRunnerDetail(Map<String, dynamic> runnerData) async {
    try {
      Response response = await dioClient.post(
        AppConstants.ORDER_RUNNER_DETAIL_URI, 
        data: runnerData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getReceipt(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.ORDER_RECEIPT_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelOrder(Order order) async {
    try {
      Response response = await dioClient
          .post('${AppConstants.ORDER_CANCEL_URI}', data: order.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> changeOrderAddress(int orderID, String address) async {
    try {
      Response response =
          await dioClient.post(AppConstants.ORDER_CHANGE_ADDRESS_URI, data: {
        "id": orderID,
        "address": address,
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
