// import 'package:flutter/material.dart';
// import 'package:nurserygardenapp/data/model/vendor_model.dart';
// import 'package:nurserygardenapp/data/model/response/api_response.dart';
// import 'package:nurserygardenapp/data/repositories/vendor_repo.dart';
// import 'package:nurserygardenapp/helper/response_helper.dart';
// import 'package:nurserygardenapp/util/app_constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';


import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:nurserygardenapp/data/model/vendor_model.dart';
import 'package:nurserygardenapp/data/model/response/api_response.dart';
import 'package:nurserygardenapp/data/repositories/vendor_repo.dart';
import 'package:nurserygardenapp/helper/response_helper.dart';
import 'package:nurserygardenapp/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorProvider extends ChangeNotifier {
  final VendorRepo vendorRepo;
  final SharedPreferences sharedPreferences;

  VendorProvider({required this.vendorRepo, required this.sharedPreferences});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  VendorModel _vendorModel = VendorModel();
  VendorModel get vendorModel => _vendorModel;

  List<Vendor> _vendorList = [];
  List<Vendor> get vendorList => _vendorList;

  String _noMoreDataMessage = '';
  String get noMoreDataMessage => _noMoreDataMessage;

  String searchTxt = '';

  // Vendor List
  // Future<bool> getVendorList(BuildContext context, params,
  //     {bool isLoadMore = false, bool isLoad = true}) async {
  //   if (!isLoadMore) {
  //     _vendorList = [];
  //     _noMoreDataMessage = '';
  //   }

  //   bool result = false;
  //   String query = ResponseHelper.buildQuery(params);
  //   int limit = params['limit'] != null ? int.parse(params['limit']) : 8;

  //   _isLoading = isLoad;
  //   notifyListeners();

  //   try {
  //     ApiResponse apiResponse = await vendorRepo.getVendorList(query);
  //     print('API Response: ${apiResponse.response}'); // Log the entire response object
  //     print('API Response Data: ${apiResponse.response?.data}'); // Log the data field

  //     if (apiResponse.response?.data == null) {
  //       print('API response is null. Check the endpoint and parameters.');
  //       // Handle null response, e.g., show an error message to the user
  //       return false;
  //     }

  //     if (context.mounted) {
  //       result = ResponseHelper.responseHelper(context, apiResponse);
  //       if (result) {
  //         // Check if apiResponse.response!.data is not null before using it
  //         // final data = apiResponse.response?.data;
  //         // if (data != null) {
  //         //  _vendorModel = VendorModel.fromJson(apiResponse.response!.data);
  //         //   _vendorList = _vendorModel.data!.vendorList!.vendor ?? [];
  //         //   print('Parsed Vendor List: $_vendorList'); // Log parsed data
  //         //   if (_vendorList.length < limit && limit > 8) {
  //         //     _noMoreDataMessage = AppConstants.NO_MORE_DATA;
  //         //   }
          
  //       //   final vendorData = data['vendors']?['data']; // Navigate to the correct path
  //       //   if (vendorData != null) {
  //       //     _vendorList = (vendorData as List)
  //       //         .map((vendor) => Vendor.fromJson(vendor))
  //       //         .toList();
  //       //     print('Parsed Vendor List: $_vendorList'); // Log parsed data
  //       //     if (_vendorList.length < limit && limit > 8) {
  //       //       _noMoreDataMessage = AppConstants.NO_MORE_DATA;
  //       //     }
  //       //   } else {
  //       //     print('No vendor data found in the response.');
  //       //   }
  //       //   } else {
  //       //     print('API response data is null');
  //       //   }
  //       // }
  //       // Parse vendor data from the nested structure
  //       final vendorsData = apiResponse.response?.data['data']['vendors']['data'];
  //       if (vendorsData != null && vendorsData is List) {
  //         _vendorList = vendorsData
  //             .map((vendor) => vendorModel.Vendor.fromJson(vendor))
  //             .toList();
  //         print('Parsed Vendor List: $_vendorList');
  //         if (_vendorList.length < limit && limit > 8) {
  //           _noMoreDataMessage = AppConstants.NO_MORE_DATA;
  //         }
  //       } else {
  //         print('No vendor data found in the response.');
  //       }
  //     }
  //     }
  //   } catch (e, stacktrace) {
  //     print('Error parsing vendor list: $e');
  //     print('Stacktrace: $stacktrace');
  //   }

  //   _isLoading = false;
  //   notifyListeners();

  //   return result;
  // }

  Future<bool> listOfVendor(BuildContext context, params,
      {bool isLoadMore = false, bool isLoad = true}) async {
    if (!isLoadMore) {
      _vendorList = [];
      _noMoreDataMessage = '';
    }

    bool result = false;
    String query = ResponseHelper.buildQuery(params);
    int limit = params['limit'] != null ? int.parse(params['limit']) : 8;

    _isLoading = isLoad;
    notifyListeners();

    try {
      // Fetch data from the repository
      ApiResponse apiResponse = await vendorRepo.getVendorList(query);
      print('API Response: ${apiResponse.response}'); // Log the full response object
      print('API Response Data: ${apiResponse.response?.data}'); // Log the data field

      if (apiResponse.response?.data == null) {
        print('API response data is null. Check the endpoint and parameters.');
        return false;
      }

      // Process the response if mounted
      if (context.mounted) {
        result = ResponseHelper.responseHelper(context, apiResponse);
        if (result) {
          // Safely parse vendor data
          // final vendorsData = apiResponse.response?.data['data']?['vendors']?['data'];
          // if (vendorsData != null && vendorsData is List) {
          //   _vendorList = vendorsData
          //       .map((vendor) => Vendor.fromJson(vendor))
          //       .toList();

          _vendorModel = VendorModel.fromJson(apiResponse.response!.data);
          _vendorList = _vendorModel.data!.vendorsList!.vendor ?? [];

            print('Parsed Vendor List: $_vendorList');

            // Handle "no more data" scenario
            if (_vendorList.length < limit && limit > 8) {
              _noMoreDataMessage = AppConstants.NO_MORE_DATA;
            }
          } else {
            print('No vendor data found in the response.');
          }
        }
      
    } catch (e, stacktrace) {
      // Log errors for debugging
      print('Error parsing vendor list: $e');
      print('Stacktrace: $stacktrace');
    }

    _isLoading = false;
    notifyListeners();

    return result;
  }


   // Vendor Detail
  //VendorDetailModel _vendorDetailModel = VendorDetailModel();
  //VendorDetailModel get vendorDetailModel => _vendorDetailModel;
    /// ================== VENDOR SEARCH ==================
  List<String> _vendorSearchHint = [];
  List<String> get vendorSearchHint => _vendorSearchHint;

  List<String> _vendorNameList = [];
  List<String> get vendorNameList => _vendorNameList;

  List<Vendor> _vendorListSearch = [];
  List<Vendor> get vendorListSearch => _vendorListSearch;

  bool _isLoadingSearch = false;
  bool get isLoadingSearch => _isLoadingSearch;

  String _endSearchResult = "";
  String get endSearchResult => _endSearchResult;

  VendorModel _searchVendorModel = VendorModel();
  VendorModel get searchVendorModel => _searchVendorModel;

  Future<bool> searchVendor(BuildContext context, params,
      {bool isLoadMore = false, bool isLoad = true}) async {
    if (!isLoadMore) {
      _vendorListSearch = [];
      _endSearchResult = "";
    }

    bool result = false;
    String query = ResponseHelper.buildQuery(params);
    int limit = params['limit'] != null ? int.parse(params['limit']) : 8;

    _isLoadingSearch = isLoad;
    notifyListeners();

    ApiResponse apiResponse = await vendorRepo.searchVendor(query);

    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _searchVendorModel = VendorModel.fromJson(apiResponse.response!.data);
        _vendorListSearch =
            _searchVendorModel.data!.vendorsList!.vendor ?? [];
        if (_vendorListSearch.length < limit && limit > 8 ||
            _searchVendorModel.data!.vendorsList!.total! < 8) {
          _endSearchResult = AppConstants.NO_MORE_DATA;
        }
      }
    }
    _isLoadingSearch = false;
    notifyListeners();

    return result;
  }

  void getSearchTips(String value) {
    _vendorNameList = _vendorList.map((e) => e.name!).toList();
    if (_vendorList.isNotEmpty) {
      _vendorSearchHint = _vendorNameList
          .where(
              (vendor) => vendor.toLowerCase().contains(value.toLowerCase()))
          .take(10)
          .toList();
    }
    notifyListeners();
  }

  /// ================== VENDOR SAVE IN LOCAL ==================
  Future<void> setVendorListInfo(vendorInfo) async {
    try {
      await sharedPreferences.setString(
          AppConstants.VENDOR_TOKEN, json.encode(vendorInfo));
    } catch (e) {
      rethrow;
    }
  }

  void getVendorListInfo() {
    String vendorInfo =
        sharedPreferences.getString(AppConstants.VENDOR_TOKEN) ?? '';
    if (vendorInfo.isNotEmpty) {
      List<dynamic> decodedData = json.decode(vendorInfo);
      List<Vendor> vendorListInfo =
          decodedData.map((item) => Vendor.fromJson(item)).toList();
      _vendorList = vendorListInfo;
      notifyListeners();
    } else {
      _vendorList = [];
      notifyListeners();
    }
  }

  Future<void> clearVendorListData() async {
    await sharedPreferences.remove(AppConstants.VENDOR_TOKEN);
  }
}
