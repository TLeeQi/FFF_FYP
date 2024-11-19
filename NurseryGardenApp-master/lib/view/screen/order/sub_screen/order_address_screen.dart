import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nurserygardenapp/data/model/order_model.dart';
import 'package:nurserygardenapp/providers/address_provider.dart';
import 'package:nurserygardenapp/providers/order_provider.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/custom_appbar.dart';
import 'package:nurserygardenapp/view/base/custom_button.dart';
import 'package:nurserygardenapp/view/base/custom_dialog.dart';
import 'package:nurserygardenapp/view/screen/address/widget/empty_address.dart';
import 'package:provider/provider.dart';
import 'package:nurserygardenapp/util/app_constants.dart';

class OrderAddressScreen extends StatefulWidget {
  const OrderAddressScreen({super.key});

  @override
  State<OrderAddressScreen> createState() => _OrderAddressScreenState();
}

class _OrderAddressScreenState extends State<OrderAddressScreen> {
  late AddressProvider address_prov =
      Provider.of<AddressProvider>(context, listen: false);

  final _scrollController = ScrollController();

  String orderID = '0';
  String address = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (address_prov.addressList.length < int.parse(params['limit']!)) return;
      int currentLimit = int.parse(params['limit']!);
      currentLimit += 8;
      params['limit'] = currentLimit.toString();
      _loadData(isLoadMore: true);
    }
  }

  // Param
  var params = {
    'limit': '8',
  };

  Future<void> _loadData({bool isLoadMore = false}) async {
    // Get Route Param arguments
    var map = ModalRoute.of(context) == null
        ? null
        : ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ;
    if (map != null) {
      orderID = map['orderID'];
      address = map['address'];
    }
    await address_prov.getAddressList(context, params,
        isLoadMore: isLoadMore, isLoadingOrderAddress: true);
  }

  Future<void> _loadAddress() async {
    await address_prov.getAddressList(context, params,
        isLoadMore: false, isLoadingOrderAddress: true);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isCenter: false,
        isBackButtonExist: false,
        isBgPrimaryColor: true,
        context: context,
        title: "Select Your address",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: double.infinity,
        child: Consumer2<AddressProvider, OrderProvider>(
            builder: (context, addressProvider, orderProvider, child) {
          return addressProvider.isLoadingOrderAddress &&
                  addressProvider.addressList.isEmpty
              ? ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return EmptyAddress();
                  })
              : addressProvider.addressList.isEmpty &&
                      !addressProvider.isLoadingOrderAddress
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No Address Found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              onTap: () {
                                Navigator.pushNamed(
                                        context, Routes.getAddAddressRoute())
                                    .then((value) {
                                  if (value == true) {
                                    _loadData();
                                  }
                                });
                              },
                              backgroundColor: ColorResources.COLOR_PRIMARY,
                              btnTxt: "Add new address",
                            ),
                          ],
                        ),
                      ),
                    )
                  : Stack(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Flexible(
                                child: Text(
                              'Press the rectangle to select the address',
                              style:
                                  CustomTextStyles(context).titleStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                            )),
                          ),
                          ListView.builder(
                              padding: (addressProvider
                                              .noMoreDataMessage.isNotEmpty &&
                                          !addressProvider
                                              .isLoadingOrderAddress ||
                                      (addressProvider
                                              .noMoreDataMessage.isEmpty &&
                                          addressProvider.addressList.length <
                                              8))
                                  ? EdgeInsets.fromLTRB(10, 0, 10, 10)
                                  : EdgeInsets.only(
                                      bottom: 20, left: 10, right: 10, top: 0),
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemCount: addressProvider.addressList.length +
                                  ((addressProvider.isLoadingOrderAddress &&
                                          addressProvider.addressList.length >=
                                              8)
                                      ? 1
                                      : addressProvider
                                              .noMoreDataMessage.isNotEmpty
                                          ? 1
                                          : 0),
                              itemBuilder: (context, index) {
                                if (index >=
                                        addressProvider.addressList.length &&
                                    addressProvider.noMoreDataMessage.isEmpty) {
                                  return Center(
                                      child: LoadingAnimationWidget.waveDots(
                                          color: ColorResources.COLOR_PRIMARY,
                                          size: 40));
                                } else if (index >=
                                        addressProvider.addressList.length &&
                                    addressProvider
                                        .noMoreDataMessage.isNotEmpty) {
                                  return Container(
                                    height: 50,
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (orderID == "0") {
                                          Navigator.pop(
                                              context,
                                              addressProvider
                                                  .addressList[index].address);
                                        } else {
                                          setState(() {
                                            address = addressProvider
                                                .addressList[index].address!;
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomDialog(
                                                    dialogType: AppConstants
                                                        .DIALOG_CONFIRMATION,
                                                    title: "Warning",
                                                    content:
                                                        "Are you confirm to change address?",
                                                    btnText: "Yes",
                                                    onPressed: () async {
                                                      Order order = Order(
                                                        id: int.parse(orderID),
                                                        address: address,
                                                      );
                                                      EasyLoading.show(
                                                          status: 'loading...');
                                                      await orderProvider
                                                          .changeOrderAddress(
                                                            context,
                                                            order,
                                                          )
                                                          .then((value) => {
                                                                EasyLoading
                                                                    .dismiss(),
                                                                if (value)
                                                                  {
                                                                    Navigator.popUntil(
                                                                        context,
                                                                        ModalRoute.withName(
                                                                            Routes.getOrderRoute()))
                                                                  }
                                                              });
                                                    });
                                              });
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding:
                                                  EdgeInsets.only(right: 15),
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    Routes
                                                        .getAddressDetailRoute(
                                                      addressProvider
                                                          .addressList[index]
                                                          .id!
                                                          .toString(),
                                                    )).then((value) => {
                                                      if (value == true)
                                                        {_loadAddress()}
                                                    });
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 10,
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      offset:
                                                          const Offset(0, 2),
                                                      blurRadius: 10.0),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      addressProvider
                                                          .addressList[index]
                                                          .address!,
                                                      softWrap: true,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                      if (!addressProvider.isLoadingOrderAddress)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: CustomButton(
                              onTap: () {
                                Navigator.pushNamed(
                                        context, Routes.getAddAddressRoute())
                                    .then((value) {
                                  if (value == true) {
                                    _loadAddress();
                                  }
                                });
                              },
                              backgroundColor: ColorResources.COLOR_PRIMARY,
                              btnTxt: "Add new address",
                            ),
                          ),
                        ),
                    ]);
        }),
      ),
    );
  }
}
