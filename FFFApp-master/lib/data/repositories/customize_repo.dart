import 'package:dio/dio.dart';
import 'package:FFF/data/dio/dio_client.dart';
import 'package:FFF/data/exception/api_error_handler.dart';
import 'package:FFF/data/model/cart_model.dart';
import 'package:FFF/data/model/response/api_response.dart';
import 'package:FFF/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizeRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  CustomizeRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getPlantList(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.PLANT_LIST_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProductList(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.PRODUCT_LIST_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getItemURL(List<Cart> cart) async {
    final List<Map<String, dynamic>> cartListJson =
        cart.map((cart) => cart.toJson()).toList();
    try {
      Response response = await dioClient.post(
        AppConstants.CUSTOMIZE_ITEM_URI,
        data: {
          "cart_list": cartListJson,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addOrder(
      List<Cart> cart, String address, String note) async {
    final List<Map<String, dynamic>> cartListJson =
        cart.map((cart) => cart.toJson()).toList();
    try {
      Response response = await dioClient.post(
        AppConstants.CUSTOMIZE_ITEM_ADD_ORDER,
        data: {
          "cart_list": cartListJson,
          "address": address,
          "note": note,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCustomStyle() async {
    try {
      Response response = await dioClient.get(AppConstants.CUSTOMIZE_STYLE_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
