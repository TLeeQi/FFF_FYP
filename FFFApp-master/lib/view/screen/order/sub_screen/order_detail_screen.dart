import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nurserygardenapp/data/model/order_model.dart';
import 'package:nurserygardenapp/providers/order_provider.dart';
import 'package:nurserygardenapp/data/model/wiring_model.dart';
import 'package:nurserygardenapp/data/model/piping_model.dart';
import 'package:nurserygardenapp/data/model/gardening_model.dart';
import 'package:nurserygardenapp/data/model/runner_model.dart';
import 'package:nurserygardenapp/util/app_constants.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/custom_button.dart';
import 'package:nurserygardenapp/view/base/custom_dialog.dart';
import 'package:nurserygardenapp/view/screen/order/widget/empty_order_detail.dart';
import 'package:nurserygardenapp/view/screen/order/widget/shipping_status.dart';
import 'package:nurserygardenapp/view/screen/payment/payment_helper/payment_type.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderID;

  const OrderDetailScreen({required this.orderID, super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderProvider order_prov =
      Provider.of<OrderProvider>(context, listen: false);

  Order order = Order();
  String address = "";
  double? _submittedRating;

  // Param
  var params = {};


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      params['id'] = widget.orderID;
      _loadData();
      _loadSubmittedRating();
    });
  }

  Future<void> _loadData() async {
    setState(() {
      order = order_prov.orderList
              .where((element) => element.id.toString() == widget.orderID)
              .firstOrNull ??
          Order();
      address = order.address ?? "";
    });

    // Check if the order is a wiring order
      await order_prov.getOrderDetail(context, params);
  }

 Future<void> _loadSubmittedRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _submittedRating = prefs.getDouble('rating_${widget.orderID}');
    });
  }

  Future<void> _submitRating(double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('rating_${widget.orderID}', rating);
    setState(() {
      _submittedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              order_prov.clearOrderDetail();
              Navigator.pop(context);
            }, // <-- SEE HERE
          ),
          backgroundColor: ColorResources.COLOR_PRIMARY,
          title: Text(
            "Booking Detail",
            style: CustomTextStyles(context).titleStyle.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
          actions: [
            if (order.status == "completed")
              IconButton(
                tooltip: "Booking Receipt",
                onPressed: () {
                  Navigator.pushNamed(
                      context, Routes.getOrderReceiptRoute(widget.orderID));
                },
                icon: Icon(Icons.receipt_long_outlined),
                color: Colors.white,
              )
          ],
        ),
        body: Container(
            width: size.width,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                    return orderProvider.isLoadingDetail
                        ? EmptyOrderDetail()
                        : Container(
                            width: double.infinity,
                            height: size.height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShippingStatus(
                                    orderID: widget.orderID,
                                    status: order.status ?? ""),
                                Container(
                                  color: Colors.white,
                                  child: Divider(
                                    color: ColorResources.COLOR_GREY
                                        .withOpacity(0.1),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (order.status == "prepare") {
                                      Navigator.pushNamed(context,
                                          Routes.getOrderAddressRoute(),
                                          arguments: {
                                            "orderID": widget.orderID,
                                            "address": address,
                                          }).then((value) {});
                                    } else {
                                      return;
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Address",
                                          style: CustomTextStyles(context)
                                              .titleStyle
                                              .copyWith(fontSize: 16),
                                        ),
                                        Text(
                                          address,
                                          style: CustomTextStyles(context)
                                              .subTitleStyle,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        if (order.status == "prepare")
                                          Text(
                                            "Tap to change address",
                                            style: CustomTextStyles(context)
                                                .subTitleStyle
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: ColorResources
                                                        .COLOR_PRIMARY),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: orderProvider.orderDetailList.length <
                                          2
                                      ? MediaQuery.of(context).size.height / 5
                                      : orderProvider.orderDetailList.length ==
                                              3
                                          ? MediaQuery.of(context).size.height /
                                              2.5
                                          : MediaQuery.of(context).size.height /
                                              2.5,
                                  child: ListView.builder(
                                      padding: (orderProvider.isLoadingDetail ||
                                              (orderProvider
                                                      .orderDetailList.length <
                                                  8)) 
                                          ? EdgeInsets.fromLTRB(10, 0, 10, 10)
                                          : EdgeInsets.only(
                                              bottom: 235,
                                              left: 10,
                                              right: 10,
                                              top: 0),
                                      shrinkWrap: true,
                                      itemCount:
                                          orderProvider.orderDetailList.length +
                                              (orderProvider.isLoading &&
                                                      orderProvider
                                                              .orderDetailList
                                                              .length >=
                                                          8
                                                  ? 1
                                                  : 0),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                            blurRadius: 10.0),
                                                      ],
                                                    ),
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        height: 120,
                                                        width: double.infinity,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            if (orderProvider
                                                                    .orderDetailList[
                                                                        index]
                                                                    .remark !=
                                                                null)
                                                              Icon(
                                                                Icons.done,
                                                                color: ColorResources
                                                                    .COLOR_PRIMARY,
                                                              ),
                                                            if (orderProvider
                                                                        .orderDetailList[
                                                                            index]
                                                                        .remark ==
                                                                    null &&
                                                                (order
                                                                            .status ==
                                                                        "partial" ||
                                                                    order.status ==
                                                                        "confirm" ||
                                                                    order.status ==
                                                                        "completed"))
                                                              Icon(
                                                                Icons
                                                                    .more_horiz_outlined,
                                                                color: ColorResources
                                                                    .COLOR_GREY,
                                                              ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),                                                            
                                                            if (orderProvider
                                                                    .orderDetailList[
                                                                        index]
                                                                    .wiringId !=
                                                                null)
                                                              Container(
                                                                height: 80,
                                                                width: 80,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,                                                
                                                                  imageUrl:
                                                                      // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                      // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                      // == orderProvider.orderDetailList[index].wiringId).productID).imageURL!}",
                                                                      //ngrok
                                                                      "https://eefd-2001-e68-5433-ca45-bce1-f9cd-4cb8-eb9.ngrok-free.app/product_image/1735189218.jpg",
                                                                  memCacheHeight:
                                                                      200,
                                                                  memCacheWidth:
                                                                      200,
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            1.0),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      color: ColorResources
                                                                          .COLOR_GRAY,
                                                                    )),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                              ),
                                                              if (orderProvider
                                                                    .orderDetailList[
                                                                        index]
                                                                    .pipingId !=
                                                                null)
                                                              Container(
                                                                height: 80,
                                                                width: 80,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,                                                
                                                                  imageUrl:
                                                                      // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                      // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                      // == orderProvider.orderDetailList[index].wiringId).productID).imageURL!}",
                                                                      //ngrok
                                                                      "https://eefd-2001-e68-5433-ca45-bce1-f9cd-4cb8-eb9.ngrok-free.app/product_image/1735189281.jpg",
                                                                  memCacheHeight:
                                                                      200,
                                                                  memCacheWidth:
                                                                      200,
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            1.0),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      color: ColorResources
                                                                          .COLOR_GRAY,
                                                                    )),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                              ),
                                                              if (orderProvider
                                                                    .orderDetailList[
                                                                        index]
                                                                    .gardeningId !=
                                                                null)
                                                              Container(
                                                                height: 80,
                                                                width: 80,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,                                                
                                                                  imageUrl:
                                                                      // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                      // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                      // == orderProvider.orderDetailList[index].wiringId).productID).imageURL!}",
                                                                      //ngrok
                                                                      "https://eefd-2001-e68-5433-ca45-bce1-f9cd-4cb8-eb9.ngrok-free.app/product_image/1735189334.jpg",
                                                                  memCacheHeight:
                                                                      200,
                                                                  memCacheWidth:
                                                                      200,
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            1.0),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      color: ColorResources
                                                                          .COLOR_GRAY,
                                                                    )),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                              ),
                                                              if (orderProvider
                                                                    .orderDetailList[
                                                                        index]
                                                                    .runnerId !=
                                                                null)
                                                              Container(
                                                                height: 80,
                                                                width: 80,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,                                                
                                                                  imageUrl:
                                                                      // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                      // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                      // == orderProvider.orderDetailList[index].wiringId).productID).imageURL!}",
                                                                      //ngrok
                                                                      "https://eefd-2001-e68-5433-ca45-bce1-f9cd-4cb8-eb9.ngrok-free.app/product_image/1735189523.jpg",
                                                                  memCacheHeight:
                                                                      200,
                                                                  memCacheWidth:
                                                                      200,
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            1.0),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      color: ColorResources
                                                                          .COLOR_GRAY,
                                                                    )),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                              ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [                                                                      
                                                                      if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .wiringId !=
                                                                          null)
                                                                        Flexible(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Text(
                                                                              // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                              // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                              // == orderProvider.orderDetailList[index].wiringId).productID).name!}",
                                                                              "Wiring",
                                                                              style: CustomTextStyles(context).titleStyle.copyWith(fontSize: 16),
                                                                            ),
                                                                          ),                                                                          
                                                                        ),
                                                                        if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .pipingId !=
                                                                          null)
                                                                        Flexible(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Text(
                                                                              // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                              // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                              // == orderProvider.orderDetailList[index].wiringId).productID).name!}",
                                                                              "Piping",
                                                                              style: CustomTextStyles(context).titleStyle.copyWith(fontSize: 16),
                                                                            ),
                                                                          ),                                                                          
                                                                        ),
                                                                        if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .gardeningId !=
                                                                          null)
                                                                        Flexible(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Text(
                                                                              // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                              // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                              // == orderProvider.orderDetailList[index].wiringId).productID).name!}",
                                                                              "Gardening",
                                                                              style: CustomTextStyles(context).titleStyle.copyWith(fontSize: 16),
                                                                            ),
                                                                          ),                                                                          
                                                                        ),
                                                                        if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .runnerId !=
                                                                          null)
                                                                        Flexible(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                Text(
                                                                              // "${orderProvider.getOrderProductList.firstWhere((product) => product.id 
                                                                              // == orderProvider.getOrderWiringList.firstWhere((wiring) => wiring.id 
                                                                              // == orderProvider.orderDetailList[index].wiringId).productID).name!}",
                                                                              "Runner",
                                                                              style: CustomTextStyles(context).titleStyle.copyWith(fontSize: 16),
                                                                            ),
                                                                          ),                                                                          
                                                                        ),
                                                                        if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .productId !=
                                                                          null && 
                                                                              orderProvider
                                                                              .orderDetailList[index]
                                                                              .wiringId != 
                                                                              null)                                                            
                                                                        Flexible(
                                                                          child:
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Wiring Details"),
                                                                                        content: _buildWiringDetails(
                                                                                          wiringData: orderProvider.getWiringDetailById(
                                                                                            orderProvider.orderDetailList[index].wiringId!,
                                                                                          ),
                                                                                        ),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                            child: Text("Close"),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Text(
                                                                                  "View Wiring Details",
                                                                                  style: TextStyle(
                                                                                    color: ColorResources.COLOR_PRIMARY,
                                                                                    decoration: TextDecoration.underline,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        ),
                                                                        if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .productId !=
                                                                          null && 
                                                                              orderProvider
                                                                              .orderDetailList[index]
                                                                              .pipingId != 
                                                                              null)                                                            
                                                                        Flexible(
                                                                          child:
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Piping Details"),
                                                                                        content: _buildPipingDetails(
                                                                                          pipingData: orderProvider.getPipingDetailById(
                                                                                            orderProvider.orderDetailList[index].pipingId!,
                                                                                          ),
                                                                                        ),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                            child: Text("Close"),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Text(
                                                                                  "View Piping Details",
                                                                                  style: TextStyle(
                                                                                    color: ColorResources.COLOR_PRIMARY,
                                                                                    decoration: TextDecoration.underline,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        ),
                                                                        if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .productId !=
                                                                          null && 
                                                                              orderProvider
                                                                              .orderDetailList[index]
                                                                              .gardeningId != 
                                                                              null)                                                            
                                                                        Flexible(
                                                                          child:
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Gardening Details"),
                                                                                        content: _buildGardeningDetails(
                                                                                          gardeningData: orderProvider.getGardeningDetailById(
                                                                                            orderProvider.orderDetailList[index].gardeningId!,
                                                                                          ),
                                                                                        ),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                            child: Text("Close"),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Text(
                                                                                  "View Gardening Details",
                                                                                  style: TextStyle(
                                                                                    color: ColorResources.COLOR_PRIMARY,
                                                                                    decoration: TextDecoration.underline,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        ),
                                                                        if (orderProvider
                                                                              .orderDetailList[index]
                                                                              .productId !=
                                                                          null && 
                                                                              orderProvider
                                                                              .orderDetailList[index]
                                                                              .runnerId != 
                                                                              null)                                                            
                                                                        Flexible(
                                                                          child:
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Runner Details"),
                                                                                        content: _buildRunnerDetails(
                                                                                          runnerData: orderProvider.getRunnerDetailById(
                                                                                            orderProvider.orderDetailList[index].runnerId!,
                                                                                          ),
                                                                                        ),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                            child: Text("Close"),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Text(
                                                                                  "View Runner Details",
                                                                                  style: TextStyle(
                                                                                    color: ColorResources.COLOR_PRIMARY,
                                                                                    decoration: TextDecoration.underline,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        ),
                                                                      SizedBox(
                                                                        height:
                                                                            4,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,  
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ]);
                                      }),
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Deposit",
                                            style: CustomTextStyles(context)
                                                .titleStyle
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            "RM" +
                                                "${order.totalAmount == null ? "" : order.totalAmount!.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: ColorResources
                                                    .COLOR_PRIMARY),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Order ID",
                                            style: CustomTextStyles(context)
                                                .titleStyle
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          Text(
                                            "${order.id}",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Request Time",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: ColorResources.COLOR_GREY
                                                    .withOpacity(0.9),
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            "${DateFormat('dd-MM-yyyy HH:mm').format(order.createdAt ?? DateTime.now())}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: ColorResources.COLOR_GREY
                                                    .withOpacity(0.9)),
                                          )
                                        ],
                                      ),
                                      if (order.note != null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Remark",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: ColorResources
                                                      .COLOR_GREY
                                                      .withOpacity(0.9),
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              order.note ?? "",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: ColorResources
                                                      .COLOR_GREY
                                                      .withOpacity(1.0)),
                                            )
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (order.status == "completed")
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "Thank you for your order!",
                                  style: CustomTextStyles(context)
                                      .titleStyle
                                      .copyWith(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                if (_submittedRating == null) ...[
                                Text(
                                  "Please rate your experience:",
                                  style: CustomTextStyles(context)
                                      .subTitleStyle
                                      .copyWith(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                // Add your rating widget here
                                RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                    // Handle rating submission
                                    _submitRating(rating);
                                  },
                                ),
                                ] else ...[
                                  Text("Your submitted rating: $_submittedRating",
                                    style: CustomTextStyles(context).subTitleStyle.copyWith(fontSize: 16),),
                                ],
                              ],
                            ),
                          ),
                                // if (order.status == "pay")
                                //   Container(
                                //     padding: const EdgeInsets.all(8),
                                //     child: Row(
                                //       children: [
                                //         Flexible(
                                //             child: Text(
                                //           "*Please note that since you pay the order, we will not be able to refund your money.",
                                //           style: CustomTextStyles(context)
                                //               .subTitleStyle
                                //               .copyWith(
                                //                   fontSize: Dimensions
                                //                       .FONT_SIZE_SMALL,
                                //                   color: ColorResources
                                //                       .COLOR_GRAY),
                                //         )),
                                //       ],
                                //     ),
                                //   ),
                                if (order.status == "pay")
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: CustomButton(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            Routes.getPaymentRoute(
                                                PaymentType.card.toString(),
                                                order.id.toString()));
                                      },
                                      btnTxt: "Pay Now",
                                    ),
                                  ),
                                if (order.status == "pay")
                                  Consumer<OrderProvider>(builder:
                                      (context, order_provider, child) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: CustomButton(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomDialog(
                                                      dialogType: AppConstants
                                                          .DIALOG_CONFIRMATION,
                                                      btnText: "Yes",
                                                      btnTextCancel: "No",
                                                      title: "Cancel",
                                                      content:
                                                          "Are you sure you want to cancel this order?",
                                                      onPressed: () async {
                                                        if (order_provider
                                                            .isLoading) {
                                                          return;
                                                        } else {
                                                          await order_provider
                                                              .cancelOrder(
                                                                  context,
                                                                  order)
                                                              .then((value) {
                                                            if (value == true) {
                                                              Navigator.popUntil(
                                                                  context,
                                                                  ModalRoute
                                                                      .withName(
                                                                          Routes
                                                                              .getOrderRoute()));
                                                            }
                                                          });
                                                        }
                                                      });
                                                });
                                          },
                                          btnTxt: "Cancel Order",
                                          backgroundColor: Colors.red,
                                        ));
                                  })
                              ],
                            ),
                          );
                  },
                ))));
  }
}

Widget _buildWiringDetails({required Wiring? wiringData}) {
  print("wiring details initiated");
  print("Wiring Data: ${wiringData}");
  print("Wiring Data ID: ${wiringData?.id}");

  if (wiringData == null) {
    return Text("No wiring details available.");
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Wiring Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildDetailRow("Service Type", wiringData.type),
        _buildDetailRow(
            "Fix Items", (wiringData.fixitem as List?)?.join(', ') ?? "N/A"),
        _buildDetailRow("Has Parts", wiringData.ishavepart.toString()),
        _buildDetailRow("Property Type", wiringData.typesProperty),
        _buildDetailRow("Appointment Date", wiringData.appDate.toString()),
        _buildDetailRow("Preferred Time", wiringData.preferredTime),
        _buildDetailRow("Additional Details", wiringData.details),
        _buildDetailRow("Budget", wiringData.budget),
        SizedBox(height: 10),

        Text(
          "Uploaded Photos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildPhotoGallery(wiringData.photo),
      ],
    ),
  );
}

Widget _buildPipingDetails({required Piping? pipingData}) {
  print("piping details initiated");
  print("Piping Data: ${pipingData}");
  print("Piping Data ID: ${pipingData?.id}");

  if (pipingData == null) {
    return Text("No piping details available.");
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Piping Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildDetailRow("Service Type", pipingData.type),
        _buildDetailRow(
            "Fix Items", (pipingData.fixitem as List?)?.join(', ') ?? "N/A"),
        _buildDetailRow(
            "Problems", (pipingData.problem as List?)?.join(', ') ?? "N/A"),
        _buildDetailRow("Property Type", pipingData.typesProperty),
        _buildDetailRow("Appointment Date", pipingData.appDate.toString()),
        _buildDetailRow("Preferred Time", pipingData.preferredTime),
        _buildDetailRow("Additional Details", pipingData.details),
        _buildDetailRow("Budget", pipingData.budget),
        SizedBox(height: 10),

        Text(
          "Uploaded Photos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildPhotoGallery(pipingData.photo),
      ],
    ),
  );
}

Widget _buildGardeningDetails({required Gardening? gardeningData}) {
  print("gardening details initiated");
  print("Gardening Data: ${gardeningData}");
  print("Gardening Data ID: ${gardeningData?.id}");

  if (gardeningData == null) {
    return Text("No gardening details available.");
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gardening Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildDetailRow("Service Type", gardeningData.type),
        _buildDetailRow("Area", gardeningData.area),
        _buildDetailRow("Property Type", gardeningData.typesProperty),
        _buildDetailRow("Appointment Date", gardeningData.appDate.toString()),
        _buildDetailRow("Preferred Time", gardeningData.preferredTime),
        _buildDetailRow("Additional Details", gardeningData.details),
        _buildDetailRow("Budget", gardeningData.budget),
        SizedBox(height: 10),

        Text(
          "Uploaded Photos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildPhotoGallery(gardeningData.photo),
      ],
    ),
  );
}

Widget _buildRunnerDetails({required Runner? runnerData}) {
  print("runner details initiated");
  print("Runner Data: ${runnerData}");
  print("Runner Data ID: ${runnerData?.id}");

  if (runnerData == null) {
    return Text("No runner details available.");
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Runner Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildDetailRow("Service Type", runnerData.type),
        _buildDetailRow("Area", runnerData.area),
        _buildDetailRow("Appointment Date", runnerData.appDate.toString()),
        _buildDetailRow("Preferred Time", runnerData.preferredTime),
        _buildDetailRow("Additional Details", runnerData.details),
        _buildDetailRow("Budget", runnerData.budget),
        SizedBox(height: 10),

        Text(
          "Uploaded Photos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildPhotoGallery(runnerData.photo),
      ],
    ),
  );
}


Widget _buildDetailRow(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(value ?? "N/A"),
        ),
      ],
    ),
  );
}

Widget _buildPhotoGallery(dynamic photoPaths) {
  if (photoPaths == null || photoPaths is! String || photoPaths.isEmpty) {
    return Text("No photos uploaded.");
  }

  // Split the comma-separated string into a list of filenames
  List<String> photoList = photoPaths.split(',');

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: photoList.map((filename) {
      // Assuming the images are stored in a specific directory
      //ngrok
      String filePath = 'https://eefd-2001-e68-5433-ca45-bce1-f9cd-4cb8-eb9.ngrok-free.app/service_image/$filename'; // Update this path as needed
      print('filePath: $filePath');
      
      return Image.network(
        filePath,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.broken_image, size: 100);
        },
      );
    }).toList(),
  );
}
