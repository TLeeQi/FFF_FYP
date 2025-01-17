import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:FFF/providers/delivery_provider.dart';
import 'package:FFF/util/color_resources.dart';
import 'package:FFF/util/custom_text_style.dart';
import 'package:FFF/util/font_styles.dart';
import 'package:FFF/util/routes.dart';
import 'package:FFF/view/base/custom_appbar.dart';
import 'package:FFF/view/base/page_loading.dart';
import 'package:provider/provider.dart';

class OrderDeliveryListScreen extends StatefulWidget {
  final String orderID;
  const OrderDeliveryListScreen({super.key, required this.orderID});

  @override
  State<OrderDeliveryListScreen> createState() =>
      _OrderDeliveryListScreenState();
}

class _OrderDeliveryListScreenState extends State<OrderDeliveryListScreen> {
  late DeliveryProvider deliver_prov =
      Provider.of<DeliveryProvider>(context, listen: false);
  final _scrollController = ScrollController();

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
      if (deliver_prov.deliveryList.length < int.parse(params['limit']!))
        return;
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
    params['order_id'] = widget.orderID;
    await deliver_prov.getDeliveryList(context, params, isLoadMore: isLoadMore);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Booking Status List",
        context: context,
        isBackButtonExist: false,
        isBgPrimaryColor: true,
        isCenter: false,
      ),
      body: Container(
          height: size.height,
          width: size.width,
          child: Consumer<DeliveryProvider>(
              builder: (context, deliveryProvider, child) {
            return deliveryProvider.deliveryList.isEmpty &&
                    deliveryProvider.isLoading
                ? LoadingThreeCircle()
                : deliveryProvider.deliveryList.isEmpty &&
                        !deliveryProvider.isLoading
                    ? Center(child: Text('No Data Found'))
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: deliveryProvider.deliveryList.length +
                            ((deliveryProvider.isLoading &&
                                    deliveryProvider.deliveryList.length >= 8)
                                ? 1
                                : deliveryProvider.noMoreDataMessage.isNotEmpty
                                    ? 1
                                    : 0),
                        padding: (deliveryProvider
                                        .noMoreDataMessage.isNotEmpty &&
                                    !deliveryProvider.isLoading ||
                                (deliveryProvider.noMoreDataMessage.isEmpty &&
                                    deliveryProvider.deliveryList.length < 8))
                            ? EdgeInsets.fromLTRB(10, 0, 10, 10)
                            : EdgeInsets.only(
                                bottom: 45, left: 10, right: 10, top: 0),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index >= deliveryProvider.deliveryList.length &&
                              deliveryProvider.noMoreDataMessage.isEmpty) {
                            return Center(
                                child: LoadingAnimationWidget.waveDots(
                                    color: ColorResources.COLOR_PRIMARY,
                                    size: 40));
                          } else if (index >=
                                  deliveryProvider.deliveryList.length &&
                              deliveryProvider.noMoreDataMessage.isNotEmpty) {
                            return Container(
                              height: 10,
                            );
                          } else if (index >=
                                  deliveryProvider.deliveryList.length &&
                              deliveryProvider.noMoreDataMessage.isNotEmpty) {
                            return Container(
                              height: 20,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(deliveryProvider.noMoreDataMessage,
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5))),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      Routes.getDeliveryDetailRoute(
                                          deliveryProvider
                                              .deliveryList[index].id
                                              .toString()),
                                      arguments: {
                                        "orderID": deliveryProvider
                                            .deliveryList[index].orderId
                                            .toString(),
                                      });
                                },
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
                                          color: Colors.grey.withOpacity(0.3),
                                          offset: const Offset(0, 2),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Order ID:",
                                            style: CustomTextStyles(context)
                                                .titleStyle,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                              deliveryProvider
                                                  .deliveryList[index].orderId
                                                  .toString(),
                                              style: CustomTextStyles(context)
                                                  .subTitleStyle),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "Contact Number:",
                                            style: CustomTextStyles(context)
                                                .titleStyle,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            deliveryProvider.deliveryList[index]
                                                .trackingNumber
                                                .toString(),
                                            style: CustomTextStyles(context)
                                                .subTitleStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "Service Provider Company: ",
                                            style: CustomTextStyles(context)
                                                .titleStyle,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            deliveryProvider
                                                .deliveryList[index].method
                                                .toString()
                                                .capitalize(),
                                            style: CustomTextStyles(context)
                                                .subTitleStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            "Booking Status: ",
                                            style: CustomTextStyles(context)
                                                .titleStyle,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            deliveryProvider
                                                .deliveryList[index].status
                                                .toString()
                                                .capitalize(),
                                            style: CustomTextStyles(context)
                                                .subTitleStyle
                                                .copyWith(
                                                    color: deliveryProvider
                                                                .deliveryList[
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            'Completed'
                                                        ? ColorResources
                                                            .COLOR_PRIMARY
                                                        : ColorResources
                                                            .APPBAR_HEADER_COLOR),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        });
          })),
    );
  }
}
