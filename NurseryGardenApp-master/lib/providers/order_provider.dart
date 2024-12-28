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

// Wiring? _orderWiringDetail;
// Wiring? get orderWiringDetail => _orderWiringDetail;

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
             //print("Wiring List from API Response: ${apiResponse.response!.data['wiring']}");
             //print("Parsed Wiring List: ${_orderWiringList.map((wiring) => wiring.id).toList()}");

           } catch (e) {
             print("Error parsing OrderDetailModel: $e");
           }
        _orderDetailList = _orderDetailModel.data?.orderItem ?? [];
        _orderPlantList = _orderDetailModel.data?.plant ?? [];
        _orderProductList = _orderDetailModel.data?.product ?? [];
        _orderDeliveryList = _orderDetailModel.data?.delivery ?? [];
       _orderWiringList = _orderDetailModel.data?.wiring ?? [];
       //_orderWiringDetail = _orderDetailModel.data!.wiring;
       //print("Wiring Detail Array Order Provider: ${_orderWiringDetail?.id}");

        _orderPipingList = _orderDetailModel.data?.piping ?? [];
        _orderGardeningList = _orderDetailModel.data?.gardening ?? [];
        _orderRunnerList = _orderDetailModel.data?.runner ?? [];

        // Debugging logs
        print("Order Detail List Wiring ID: ${_orderDetailList.map((item) => item.wiringId).toList()}");
        print("Order Detail ID: ${_orderDetailList.map((item) => item.id).toList()}");
        print("Wiring List ID: ${_orderWiringList.map((wiring) => wiring.id).toList()}");
        print("_orderWiringList: ${_orderWiringList}");
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

// Wiring? getWiringDetailById(int? wiringId) {
//     print("Looking for Wiring ID: $wiringId");
//     if (wiringId == null || _orderWiringDetail == null) {
//         return null;
//     }
    
//     if (_orderWiringDetail!.id == wiringId) {
//         return _orderWiringDetail;
//     } else {
//         print("Wiring detail not found for ID: $wiringId");
//         return null;
//     }
// }

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

  /// ================== MAKE ORDER ==================
  String _orderIdCreated = '';
  String get orderIdCreated => _orderIdCreated;

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
    notifyListeners();

    ApiResponse apiResponse = await orderRepo.storeWiringDetail(wiringData);
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
        showCustomSnackBar("Your order has been cancelled.", context);
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
