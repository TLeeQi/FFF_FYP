import 'package:flutter/material.dart';
import 'package:nurserygardenapp/data/model/bidding_detail_model.dart';
import 'package:nurserygardenapp/data/model/bidding_model.dart';
import 'package:nurserygardenapp/data/model/bidding_refund_model.dart';
import 'package:nurserygardenapp/data/model/response/api_response.dart';
import 'package:nurserygardenapp/data/repositories/bidding_repo.dart';
import 'package:nurserygardenapp/helper/response_helper.dart';
import 'package:nurserygardenapp/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiddingProvider extends ChangeNotifier {
  final BiddingRepo biddingRepo;
  final SharedPreferences sharedPreferences;

  BiddingProvider({required this.biddingRepo, required this.sharedPreferences});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BiddingModel _biddingModel = BiddingModel();
  BiddingModel get biddingModel => _biddingModel;

  List<Bidding> _biddingList = [];
  List<Bidding> get biddingList => _biddingList;

  String _biddingNoMoreData = '';
  String get biddingNoMoreData => _biddingNoMoreData;
  // Bidding List
  Future<bool> getBiddingList(BuildContext context, params,
      {bool isLoadMore = false, bool isLoad = true}) async {
    if (!isLoadMore) {
      _biddingList = [];
      _biddingNoMoreData = '';
    }

    bool result = false;
    String query = ResponseHelper.buildQuery(params);
    int limit = params['limit'] != null ? int.parse(params['limit']) : 8;

    _isLoading = isLoad;
    notifyListeners();

    ApiResponse apiResponse = await biddingRepo.getBidddingList(query);

    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _biddingModel = BiddingModel.fromJson(apiResponse.response!.data);
        _biddingList = _biddingModel.data!.biddingList!.bidding ?? [];
        if (_biddingList.length < limit && limit > 8) {
          _biddingNoMoreData = AppConstants.NO_MORE_DATA;
        }
      }
    }

    _isLoading = false;
    notifyListeners();

    return result;
  }

  // Bidding Detail
  BiddingDetailModel _biddingDetailModel = BiddingDetailModel();
  BiddingDetailModel get biddingDetailModel => _biddingDetailModel;
  Bid _bid = Bid();
  Bid get bid => _bid;
  int _userBid = 0;
  int get userBid => _userBid;
  bool _isLoadingDetail = false;
  bool get isLoadingDetail => _isLoadingDetail;

  Future<bool> getBidDetail(BuildContext context, String id) async {
    bool result = false;
    _isLoadingDetail = true;
    notifyListeners();

    var params = {'id': id};
    String query = ResponseHelper.buildQuery(params);

    ApiResponse apiResponse = await biddingRepo.getBidddingDetail(query);
    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _biddingDetailModel =
            BiddingDetailModel.fromJson(apiResponse.response!.data);
        _bid = _biddingDetailModel.data!.bid ?? Bid();
        _userBid = _biddingDetailModel.data!.userBid ?? 0;
      }
    }

    _isLoadingDetail = false;
    notifyListeners();
    return result;
  }

  // Bidding Refund
  BiddingRefundModel _biddingRefundModel = BiddingRefundModel();
  BiddingRefundModel get biddingRefundModel => _biddingRefundModel;
  List<Refund> _biddingRefundList = [];
  List<Refund> get biddingRefundList => _biddingRefundList;
  String _biddingRefundNoMoreData = '';
  String get biddingRefundNoMoreData => _biddingRefundNoMoreData;
  bool _isLoadingRefund = false;
  bool get isLoadingRefund => _isLoadingRefund;

  Future<bool> getBiddingRefundList(BuildContext context, params,
      {bool isLoadMore = false, bool isLoad = true}) async {
    if (!isLoadMore) {
      _biddingRefundList = [];
      _biddingRefundNoMoreData = '';
    }

    bool result = false;
    String query = ResponseHelper.buildQuery(params);
    int limit = params['limit'] != null ? int.parse(params['limit']) : 8;

    _isLoadingRefund = isLoad;
    notifyListeners();

    ApiResponse apiResponse = await biddingRepo.getBidddingRefundList(query);

    if (context.mounted) {
      result = ResponseHelper.responseHelper(context, apiResponse);
      if (result) {
        _biddingRefundModel =
            BiddingRefundModel.fromJson(apiResponse.response!.data);
        _biddingRefundList = _biddingRefundModel.data!.refundList!.refund ?? [];
        if (_biddingRefundList.length < limit && limit > 8) {
          _biddingRefundNoMoreData = AppConstants.NO_MORE_DATA;
        }
      }
    }

    _isLoadingRefund = false;
    notifyListeners();

    return result;
  }
}
