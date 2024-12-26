import 'package:flutter/material.dart';
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

  String _vendorNoMoreData = '';
  String get vendorNoMoreData => _vendorNoMoreData;

  // Vendor List
  // Future<bool> getVendorList(BuildContext context, params,
  //     {bool isLoadMore = false, bool isLoad = true}) async {
  //   if (!isLoadMore) {
  //     _vendorList = [];
  //     _vendorNoMoreData = '';
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
  //         //     _vendorNoMoreData = AppConstants.NO_MORE_DATA;
  //         //   }
          
  //       //   final vendorData = data['vendors']?['data']; // Navigate to the correct path
  //       //   if (vendorData != null) {
  //       //     _vendorList = (vendorData as List)
  //       //         .map((vendor) => Vendor.fromJson(vendor))
  //       //         .toList();
  //       //     print('Parsed Vendor List: $_vendorList'); // Log parsed data
  //       //     if (_vendorList.length < limit && limit > 8) {
  //       //       _vendorNoMoreData = AppConstants.NO_MORE_DATA;
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
  //           _vendorNoMoreData = AppConstants.NO_MORE_DATA;
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

  Future<bool> getVendorList(BuildContext context, params,
      {bool isLoadMore = false, bool isLoad = true}) async {
    if (!isLoadMore) {
      _vendorList = [];
      _vendorNoMoreData = '';
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
          final vendorsData = apiResponse.response?.data['data']?['vendors']?['data'];
          if (vendorsData != null && vendorsData is List) {
            _vendorList = vendorsData
                .map((vendor) => Vendor.fromJson(vendor))
                .toList();
            print('Parsed Vendor List: $_vendorList');

            // Handle "no more data" scenario
            if (_vendorList.length < limit && limit > 8) {
              _vendorNoMoreData = AppConstants.NO_MORE_DATA;
            }
          } else {
            print('No vendor data found in the response.');
          }
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
  Vendor _vendor = Vendor();
  Vendor get vendor => _vendor;
  int _userBid = 0;
  int get userBid => _userBid;
  bool _isLoadingDetail = false;
  bool get isLoadingDetail => _isLoadingDetail;

  // Vendor Detail
  Future<bool> getVendorDetail(BuildContext context, int vendorId) async {
    bool result = false;
    _isLoading = true;
    notifyListeners();

    var params = {'id': vendorId};
    String query = ResponseHelper.buildQuery(params);

    try {
      ApiResponse apiResponse = await vendorRepo.getVendorDetail(query);
      if (context.mounted) {
        result = ResponseHelper.responseHelper(context, apiResponse);
        if (result) {
          // _vendorDetailModel =
          //     vendorDetail.VendorDetailModel.fromJson(apiResponse.response!.data);
          // _vendor = _vendorDetailModel.data!.vendor ?? Vendor();
        }
      }
    } catch (e, stacktrace) {
      print('Error parsing vendor detail: $e');
      print('Stacktrace: $stacktrace');
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }
}
