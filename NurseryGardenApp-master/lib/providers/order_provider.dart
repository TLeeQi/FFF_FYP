import 'package:flutter/material.dart';
import 'package:nurserygardenapp/data/model/cart_model.dart';
import 'package:nurserygardenapp/data/model/delivery_model.dart';
import 'package:nurserygardenapp/data/model/delivery_receipt_model.dart';
import 'package:nurserygardenapp/data/model/order_detail_model.dart';
import 'package:nurserygardenapp/data/model/order_model.dart';
import 'package:nurserygardenapp/data/model/order_recieipt_model.dart';
import 'package:nurserygardenapp/data/model/plant_model.dart';
import 'package:nurserygardenapp/data/model/product_model.dart';
import 'package:nurserygardenapp/data/model/wiring_model.dart'; 
import 'package:nurserygardenapp/data/model/piping_model.dart';
import 'package:nurserygardenapp/data/model/gardening_model.dart';
import 'package:nurserygardenapp/data/model/runner_model.dart';
import 'package:nurserygardenapp/data/model/response/api_response.dart';
import 'package:nurserygardenapp/data/model/user_model.dart';
import 'package:nurserygardenapp/data/repositories/order_repo.dart';
import 'package:nurserygardenapp/helper/response_helper.dart';
import 'package:nurserygardenapp/util/app_constants.dart';
import 'package:nurserygardenapp/view/base/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class OrderProvider extends ChangeNotifier {
  final OrderRepo orderRepo;
  final SharedPreferences sharedPreferences;

  OrderProvider({required this.orderRepo, required this.sharedPreferences});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  OrderModel _orderModel = OrderModel();
  OrderModel get orderModel => _orderModel;

  List<Order> _orderList = [];
  List<Order> get orderList => _orderList;

  String _noMoreDataMessage = '';
  String get noMoreDataMessage => _noMoreDataMessage;

  /// ================== ORDER LIST ==================
  Future<bool> getOrderList(BuildContext context, params,
      {bool isLoadMore = false, bool isLoad = true}) async {
    if (!isLoadMore) {
      _orderList = [];
      _noMoreDataMessage = '';
    }

    bool result = false;
    String query = ResponseHelper.buildQuery(params);
    int limit = params['limit'] != null ? int.parse(params['limit']) : 8;

    _isLoading = isLoad;
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.getOrder(query);

    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _orderModel = OrderModel.fromJson(apiResponse.response!.data);
        _orderList = _orderModel.data!.orderList!.order ?? [];
        if (_orderList.length < limit && limit > 8) {
          _noMoreDataMessage = AppConstants.NO_MORE_DATA;
        }
      }
    }

    _isLoading = false;
    notifyListeners();

    return result;
  }

  /// ================== ORDER DETAIL ==================
  OrderDetailModel _orderDetailModel = OrderDetailModel();
  OrderDetailModel get orderDetailModel => _orderDetailModel;

  List<OrderItem> _orderDetailList = [];
  List<OrderItem> get orderDetailList => _orderDetailList;

  List<Plant> _orderPlantList = [];
  List<Plant> get getOrderPlantList => _orderPlantList;
  List<Product> _orderProductList = [];
  List<Product> get getOrderProductList => _orderProductList;
  List<Wiring> _orderWiringList = [];
  List<Wiring> get getOrderWiringList => _orderWiringList;
  List<Piping> _orderPipingList = [];
  List<Piping> get getOrderPipingList => _orderPipingList;
  List<Gardening> _orderGardeningList = [];
  List<Gardening> get getOrderGardeningList => _orderGardeningList;
  List<Runner> _orderRunnerList = [];
  List<Runner> get getOrderRunnerList => _orderRunnerList;

  List<Delivery> _orderDeliveryList = [];
  List<Delivery> get getOrderDeliveryList => _orderDeliveryList;

  bool _isLoadingDetail = false;
  bool get isLoadingDetail => _isLoadingDetail;

  Future<bool> getOrderDetail(BuildContext context, params) async {
    clearOrderDetail();
    bool result = false;
    String query = ResponseHelper.buildQuery(params);

    _isLoadingDetail = true;
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.getOrderDetail(query);
     print("API call completed");
     print("Raw API Response: ${apiResponse.response!.data}");

    if (context.mounted) {
      print("Context is mounted");
      result = ResponseHelper.responseHelper(context, apiResponse);

      if (result) {

        print("About to parse OrderDetailModel");

        try {
             _orderDetailModel = OrderDetailModel.fromJson(apiResponse.response!.data);
             print("OrderDetailModel parsed successfully");
             print("OrderDetailModel data: ${_orderDetailModel.data}");

             print("Wiring List from API Response: ${_orderDetailModel.data?.wiring}");
             print("Piping List from API Response: ${_orderDetailModel.data?.piping}");
             print("Gardening List from API Response: ${_orderDetailModel.data?.gardening}");
             print("Runner List from API Response: ${_orderDetailModel.data?.runner}");
           } catch (e) {
             print("Error parsing OrderDetailModel: $e");
           }
        _orderDetailList = _orderDetailModel.data?.orderItem ?? [];
        _orderPlantList = _orderDetailModel.data?.plant ?? [];
        _orderProductList = _orderDetailModel.data?.product ?? [];
        _orderDeliveryList = _orderDetailModel.data?.delivery ?? [];
        
       _orderWiringList = _orderDetailModel.data?.wiring ?? [];
        _orderPipingList = _orderDetailModel.data?.piping ?? [];
        _orderGardeningList = _orderDetailModel.data?.gardening ?? [];
        _orderRunnerList = _orderDetailModel.data?.runner ?? [];

        // Debugging logs
        print("Order Detail ID: ${_orderDetailList.map((item) => item.id).toList()}");

        print("Wiring List ID: ${_orderWiringList.map((wiring) => wiring.id).toList()}");
        print("_orderWiringList: ${_orderWiringList}");

        print("Piping List ID: ${_orderPipingList.map((piping) => piping.id).toList()}");
        print("_orderPipingList: ${_orderPipingList}");

        print("Gardening List ID: ${_orderGardeningList.map((gardening) => gardening.id).toList()}");
        print("_orderGardeningList: ${_orderGardeningList}");

        print("Runner List ID: ${_orderRunnerList.map((runner) => runner.id).toList()}");
        print("_orderRunnerList: ${_orderRunnerList}");
      }
      else {
        print("API call failed");
      }
    }
    else {
      print("Context is not mounted");
    }

    _isLoadingDetail = false;
    notifyListeners();
    return result;
  }

  Wiring? getWiringDetailById(int? wiringId) {
    print("Looking for Wiring ID: $wiringId");
    print("Available Wiring IDs: ${_orderWiringList.map((w) => w.id).toList()}");

    if (wiringId == null) {
      print("Wiring ID is null");
      return null;
    }

    if (_orderWiringList.isEmpty) {
      print("Wiring list is empty, cannot find wiring detail.");
      return null;
    }

    try {
      final wiringDetail = _orderWiringList.firstWhere(
        (wiring) => wiring.id == wiringId,
        orElse: () {
          print("Wiring detail not found for ID: $wiringId");

          return Wiring();
        },
      );

      print("Wiring detail found id: ${wiringDetail.id}");
      

      return wiringDetail;
    } catch (e) {
      print("Exception occurred while finding wiring detail: $e");
      return null;
    }
  }

  Piping? getPipingDetailById(int? pipingId) {
    print("Looking for Piping ID: $pipingId");
    print("Available Piping IDs: ${_orderPipingList.map((p) => p.id).toList()}");

    if (pipingId == null) {
      print("Piping ID is null");
      return null;
    }

    if (_orderPipingList.isEmpty) {
      print("Piping list is empty, cannot find piping detail.");
      return null;
    }

    try {
      final pipingDetail = _orderPipingList.firstWhere(
            (piping) => piping.id == pipingId,
        orElse: () {
          print("Piping detail not found for ID: $pipingId");

          return Piping();
        },
      );

      print("Piping detail found id: ${pipingDetail.id}");
      

      return pipingDetail;
    } catch (e) {
      print("Exception occurred while finding piping detail: $e");
      return null;
    }
  }

  Gardening? getGardeningDetailById(int? gardeningId) {
    print("Looking for Gardening ID: $gardeningId");
    print("Available Gardening IDs: ${_orderGardeningList.map((g) => g.id).toList()}");

    if (gardeningId == null) {
      print("Gardening ID is null");
      return null;
    }

    if (_orderGardeningList.isEmpty) {
      print("Gardening list is empty, cannot find gardening detail.");
      return null;
    }

    try {
      final gardeningDetail = _orderGardeningList.firstWhere(
            (gardening) => gardening.id == gardeningId,
        orElse: () {
          print("Gardening detail not found for ID: $gardeningId");

          return Gardening();
        },
      );

      print("Gardening detail found id: ${gardeningDetail.id}");
      

      return gardeningDetail;
    } catch (e) {
      print("Exception occurred while finding gardening detail: $e");
      return null;
    }
  }

  Runner? getRunnerDetailById(int? runnerId) {
    print("Looking for Runner ID: $runnerId");
    print("Available Runner IDs: ${_orderRunnerList.map((r) => r.id).toList()}");

    if (runnerId == null) {
      print("Runner ID is null");
      return null;
    }

    if (_orderRunnerList.isEmpty) {
      print("Runner list is empty, cannot find runner detail.");
      return null;
    }

    try {
      final runnerDetail = _orderRunnerList.firstWhere(
            (runner) => runner.id == runnerId,
        orElse: () {
          print("Runner detail not found for ID: $runnerId");

          return Runner();
        },
      );

      print("Runner detail found id: ${runnerDetail.id}");
      

      return runnerDetail;
    } catch (e) {
      print("Exception occurred while finding runner detail: $e");
      return null;
    }
  }

  clearOrderDetail() {
    _orderDetailModel = OrderDetailModel();
    _orderDetailList = [];
    _orderPlantList = [];
    _orderProductList = [];
    _orderDeliveryList = [];
    _orderWiringList = [];
    _orderPipingList = [];
    _orderGardeningList = [];
    _orderRunnerList = [];
    notifyListeners();
  }

  /// ================== NOTIFICATION ==================

  Future<Map<String, dynamic>> getUpcomingAppointmentDetails(BuildContext context) async {
    print("Getting upcoming appointment details");

    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

    // Reuse getOrderList to fetch orders
    bool success = await getOrderList(context, {'limit': '8'}, isLoadMore: false);
    if (!success) {
      print("Failed to fetch orders");
      return {};
    }

    print("Order List Length: ${_orderList.length}");

    for (Order order in _orderList) {
      print("Checking order ID: ${order.id}");
      DateTime? appointmentDate = await getAppointmentDateFromOrder(context, order);

      if (appointmentDate != null &&
          appointmentDate.year == tomorrow.year &&
          appointmentDate.month == tomorrow.month &&
          appointmentDate.day == tomorrow.day) {

        print("Upcoming appointment found");

        String? vendorName = "order.vendorName"; 
        String? vendorContact = "order.vendorContact";

        print("order.id: ${order.id.toString()}");
        print("order.vendorName: $vendorName");
        print("order.vendorContact: $vendorContact");

        return {
          'orderId': order.id.toString(),
          'vendorName': vendorName,
          'vendorContact': vendorContact,
        };
      } else {
        print("No upcoming appointment found for order ID: ${order.id}");
      }
    }
    return {};
  }

  Future<DateTime?> getAppointmentDateFromOrder(BuildContext context, Order order) async {
    print("Getting appointment date from order");

    clearOrderDetail();
    // Fetch order details
    bool result = false;
    String query = ResponseHelper.buildQuery({'orderId': order.id.toString()});
    _isLoadingDetail = true;
    ApiResponse apiResponse = await orderRepo.getOrderDetail(query);

    print("API call completed");
    print("Raw API Response: ${apiResponse.response!.data}");

    if (context.mounted) {
      print("Context is mounted");
      result = ResponseHelper.responseHelper(context, apiResponse);

      if (result) {
        print("About to parse OrderDetailModel");

        try {
          _orderDetailModel = OrderDetailModel.fromJson(apiResponse.response!.data);
          print("OrderDetailModel parsed successfully");
          print("OrderDetailModel data: ${_orderDetailModel.data}");
        } catch (e) {
          print("Error parsing OrderDetailModel: $e");
        }

        _orderDetailList = _orderDetailModel.data?.orderItem ?? [];
        _orderWiringList = _orderDetailModel.data?.wiring ?? [];
        _orderPipingList = _orderDetailModel.data?.piping ?? [];
        _orderGardeningList = _orderDetailModel.data?.gardening ?? [];
        _orderRunnerList = _orderDetailModel.data?.runner ?? [];

        // Check for appointment dates in each list
        DateTime? appDate;
        if (_orderWiringList.isNotEmpty) {
          appDate = _orderWiringList.first.appDate;
        } else if (_orderPipingList.isNotEmpty) {
          appDate = _orderPipingList.first.appDate;
        } else if (_orderGardeningList.isNotEmpty) {
          appDate = _orderGardeningList.first.appDate;
        } else if (_orderRunnerList.isNotEmpty) {
          appDate = _orderRunnerList.first.appDate;
        }

        if (appDate != null) {
          print("Appointment date found: $appDate");
          _isLoadingDetail = false;
          return appDate;
        }
      } else {
        print("API call failed with error: ${apiResponse.response!.data['error']}");
        showCustomSnackBar("Failed to fetch order details: ${apiResponse.response!.data['error']}", context);
      }
    } else {
      print("Context is not mounted");
    }

    print("No appointment date found");
    _isLoadingDetail = false;
    return null; // Return null if no appointment date is found
  }
  
  // // Function to get the count of upcoming orders
  // Future<int> getUpcomingOrdersCount(BuildContext context, params) async {
  //   // Check if the order list is empty and fetch it if necessary
  //   if (_orderList.isEmpty) {
  //     await getOrderList(context, params);
  //   }

  //   int count = 0;

  //   // Define your criteria for an "upcoming" order
  //   DateTime now = DateTime.now();
  //   DateTime oneWeekFromNow = now.add(Duration(days: 1));

  //   for (Order order in _orderList) {
  //     // Fetch order details if not already loaded
  //     if (_orderDetailModel.data == null || !_orderDetailModel.data!.orderItem!.any((item) => item.orderId == order.id)) {
  //       await getOrderDetail(context, {'orderId': order.id});
  //     }

  //     DateTime? appointmentDate = getAppointmentDateFromOrder(order);
  //     // Check if the appointment date is within the next week
  //     if (appointmentDate != null &&
  //         appointmentDate.isAfter(now) &&
  //         appointmentDate.isBefore(oneWeekFromNow)) {
  //       count++;
  //     }
  //   }

  //   print("Order List: $_orderList");
  //   //print("Appointment Date: ${getAppointmentDateFromOrder(_orderList.first)}");
  //   print("Upcoming orders count: $count");

  //   return count; // Ensure the function always returns an integer
  // }

  /// ================== MAKE ORDER ==================
  String _orderIdCreated = '';
  String get orderIdCreated => _orderIdCreated;
  String _wiringIdCreated = '';
  String get wiringIdCreated => _wiringIdCreated;

  Future<bool> addOrder(
      List<Cart> cartList, String address, BuildContext context) async {
    bool result = false;
    _isLoading = true;
    _orderIdCreated = '';
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.addOrder(cartList, address);
    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _orderIdCreated =
            apiResponse.response!.data['data']['order_id'].toString();
        print(_orderIdCreated);
      }
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> storeWiringDetail(
      Map<String, dynamic> wiringData, BuildContext context) async {
    bool result = false;
    _isLoading = true;
    _orderIdCreated = '';
    _wiringIdCreated = '';
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.storeWiringDetail(wiringData);
    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _orderIdCreated =
            apiResponse.response!.data['data']['order_id'].toString();
        _wiringIdCreated = 
            apiResponse.response!.data['data']['wiring_id'].toString();
        print('Order ID: $_orderIdCreated');
        print('Wiring ID: $_wiringIdCreated');
      }
    }
    
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> uploadWiringImages(List<File> photos, String key, BuildContext context) async {
    bool result = false;
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.uploadWiringImages(photos, key);
    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result && apiResponse.response!.data['data'] != null) {
        var data = apiResponse.response!.data['data']; // Access the 'data' key
        var imageNames = data['image_names'];
        print('API Response: $data');
        print('Image Names from API: $imageNames');
        if (imageNames != null && imageNames is List) {
          _imageNames = List<String>.from(imageNames); // Store the list of image names
          print('Image Names store in list provider: $_imageNames');
        }
      }
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  List<String> _imageNames = [];
  List<String> get imageNames => _imageNames; // Expose the image names

  String _imageUrl = '';
  String get imageUrl => _imageUrl;

  String _imageName = '';
  String get imageName => _imageName;

  resetImageUrl() {
    if (_imageUrl != '') {
      _imageUrl = '';
      _imageName = '';
    }
  }

  Future<bool> storePipingDetail(
      Map<String, dynamic> pipingData, BuildContext context) async {
    bool result = false;
    _isLoading = true;
    _orderIdCreated = '';
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.storePipingDetail(pipingData);
    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _orderIdCreated =
            apiResponse.response!.data['data']['order_id'].toString();
        print(_orderIdCreated);
      }
    }
    
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> storeGardeningDetail(
      Map<String, dynamic> gardeningData, BuildContext context) async {
    bool result = false;
    _isLoading = true;
    _orderIdCreated = '';
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.storeGardeningDetail(gardeningData);
    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _orderIdCreated =
            apiResponse.response!.data['data']['order_id'].toString();
        print(_orderIdCreated);
      }
    }
    
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> storeRunnerDetail(
      Map<String, dynamic> runnerData, BuildContext context) async {
    bool result = false;
    _isLoading = true;
    _orderIdCreated = '';
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.storeRunnerDetail(runnerData);
    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _orderIdCreated =
            apiResponse.response!.data['data']['order_id'].toString();
        print(_orderIdCreated);
      }
    }
    
    _isLoading = false;
    notifyListeners();
    return result;
  }

  /// ================== ORDER RECEIPT ==================
  OrderReceiptModel _orderReceiptModel = OrderReceiptModel();
  OrderReceiptModel get orderReceiptModel => _orderReceiptModel;

  Order _orderReceiptInfo = Order();
  Order get orderReceiptInfo => _orderReceiptInfo;
  List<DeliveryOrderDetail> _orderReceiptItem = [];
  List<DeliveryOrderDetail> get orderReceiptItem => _orderReceiptItem;
  Payment _orderReceiptPaymentInfo = Payment();
  Payment get orderReceiptPaymentInfo => _orderReceiptPaymentInfo;
  Sender _receiptSender = Sender();
  Sender get receiptSender => _receiptSender;
  UserData _receiptUser = UserData();
  UserData get receiptUser => _receiptUser;

  bool _isLoadingReceipt = false;
  bool get isLoadingReceipt => _isLoadingReceipt;

  Future<bool> getOrderReceipt(BuildContext context, params) async {
    bool result = false;
    String query = ResponseHelper.buildQuery(params);

    _isLoadingReceipt = true;
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.getReceipt(query);

    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _orderReceiptModel =
            OrderReceiptModel.fromJson(apiResponse.response!.data);
        _orderReceiptInfo = _orderReceiptModel.data!.order ?? Order();
        _orderReceiptItem = _orderReceiptModel.data!.orderItem ?? [];
        _orderReceiptPaymentInfo =
            _orderReceiptModel.data!.payment ?? Payment();
        _receiptSender = _orderReceiptModel.data!.sender ?? Sender();
        _receiptUser = _orderReceiptModel.data!.user ?? UserData();
      }
    }

    _isLoadingReceipt = false;
    notifyListeners();

    return result;
  }

  Future<bool> cancelOrder(BuildContext context, Order order) async {
    bool result = false;
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.cancelOrder(order);

    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        showCustomSnackBar("Your requested service has been cancelled.", context);
      }
    }
    _isLoading = false;
    notifyListeners();

    print(result);

    return result;
  }

  Future<bool> changeOrderAddress(BuildContext context, Order order) async {
    bool result = false;
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse =
        await orderRepo.changeOrderAddress(order.id!, order.address!);

    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        showCustomSnackBar("Your order address has been changed.", context,
            type: AppConstants.SNACKBAR_SUCCESS);
      }
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
