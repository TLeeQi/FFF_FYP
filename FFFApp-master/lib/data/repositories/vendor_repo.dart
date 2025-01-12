import 'package:dio/dio.dart';
import 'package:FFF/data/dio/dio_client.dart';
import 'package:FFF/data/exception/api_error_handler.dart';
import 'package:FFF/data/model/response/api_response.dart';
import 'package:FFF/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  const VendorRepo({
    required this.dioClient,
    required this.sharedPreferences,
  });

  Future<ApiResponse> getVendorList(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.VENDOR_LIST_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getVendorSearchKeyword() async {
    try {
      Response response =
          await dioClient.get(AppConstants.VENDOR_SEARCH_KEYWORD);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> searchVendor(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.VENDOR_SEARCH}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}