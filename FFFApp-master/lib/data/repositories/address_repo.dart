import 'package:dio/dio.dart';
import 'package:FFF/data/dio/dio_client.dart';
import 'package:FFF/data/exception/api_error_handler.dart';
import 'package:FFF/data/model/address_model.dart';
import 'package:FFF/data/model/response/api_response.dart';
import 'package:FFF/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AddressRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getAddress(param) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.ADDRESS_URI}$param');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addAddress(Address address) async {
    try {
      Response response = await dioClient
          .post('${AppConstants.ADD_ADDRESS_URI}', data: address.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateAddress(Address address) async {
    try {
      Response response = await dioClient
          .post('${AppConstants.UPDATE_ADDRESS_URI}', data: address.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> daleteAddress(Address address) async {
    try {
      Response response = await dioClient
          .post('${AppConstants.DELETE_ADDRESS_URI}', data: address.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
