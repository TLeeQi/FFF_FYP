import 'package:dio/dio.dart';
import 'package:FFF/data/dio/dio_client.dart';
import 'package:FFF/data/exception/api_error_handler.dart';
import 'package:FFF/data/model/response/api_response.dart';
import 'package:FFF/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  DeliveryRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getDeliveryList(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.DELIVERY_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryDetail(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.DELIVERY_DETAIL_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryReceipt(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.DELIVERY_RECEIPT_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
