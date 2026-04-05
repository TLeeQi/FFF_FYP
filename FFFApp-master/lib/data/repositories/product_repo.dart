import 'package:dio/dio.dart';
import 'package:FFF/data/dio/dio_client.dart';
import 'package:FFF/data/exception/api_error_handler.dart';
import 'package:FFF/data/model/response/api_response.dart';
import 'package:FFF/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  const ProductRepo({
    required this.dioClient,
    required this.sharedPreferences,
  });

  Future<ApiResponse> getProductList(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.PRODUCT_LIST_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProductSearchKeyword() async {
    try {
      Response response =
          await dioClient.get(AppConstants.PRODUCT_SEARCH_KEYWORD);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> searchProduct(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.PRODUCT_SEARCH}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
