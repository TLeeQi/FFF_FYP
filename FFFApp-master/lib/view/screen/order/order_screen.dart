import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:FFF/providers/order_provider.dart';
import 'package:FFF/util/color_resources.dart';
import 'package:FFF/util/custom_text_style.dart';
import 'package:FFF/util/font_styles.dart';
import 'package:FFF/util/routes.dart';
import 'package:FFF/view/base/custom_button.dart';
import 'package:FFF/view/screen/order/widget/empty_order.dart';
import 'package:FFF/view/screen/payment/payment_helper/payment_type.dart';
import 'package:provider/provider.dart';
import 'package:FFF/view/screen/emergency_screen.dart';
import 'package:FFF/view/screen/sos_button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderProvider order_prov =
      Provider.of<OrderProvider>(context, listen: false);
  final _scrollController = ScrollController();
  String _selectedStatus = 'Confirmed';
  //late Future<Map<String, dynamic>> _appointmentDetailsFuture;

  List<String> _statusList = [
    "To Pay",
    "Preparing",
    // "Partial",
    "Confirmed",
    "Completed",
    "Cancelled"
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    //_appointmentDetailsFuture = order_prov.getUpcomingAppointmentDetails(context);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (order_prov.orderList.length < int.parse(params['limit']!)) return;
      int currentLimit = int.parse(params['limit']!);
      currentLimit += 8;
      params['limit'] = currentLimit.toString();
      _loadData(isLoadMore: true);
    }
  }

  // Param
  var params = {'limit': '8', 'status': 'confirm'};

  Future<void> _loadData({bool isLoadMore = false}) async {
    await order_prov.getOrderList(context, params, isLoadMore: isLoadMore);
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

  void _handleStatusChanged(String status) {
    setState(() {
      _selectedStatus = status;
    });
    if (status == _statusList[0]) {
      params['status'] = 'pay';
    } else if (status == _statusList[1]) {
      params['status'] = 'prepare';
    } 
    // else if (status == _statusList[2]) {
    //   params['status'] = 'partial';
    // } 
    else if (status == _statusList[2]) {
      params['status'] = 'confirm';
    } else if (status == _statusList[3]) {
      params['status'] = 'completed';
    } else if (status == _statusList[4]) {
      params['status'] = 'cancel';
    }
    params['limit'] = '8';
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          // leading: BackButton(
          //   onPressed: () {
          //     Navigator.pushNamedAndRemoveUntil(context,
          //         Routes.getDashboardRoute("Requests"), (route) => false);
          //   },
          //   color: Colors.white, // <-- SEE HERE
          // ),
          backgroundColor: ColorResources.COLOR_PRIMARY,
          title: Text(
            "Booking",
            style: CustomTextStyles(context).titleStyle.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
          actions: [
            SOSButton(
              onPressed: () {
                // Handle SOS button press
                print("SOS button pressed!");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyScreen()),
                );
              },
            ),
          ],
        ),
        body: Container(
            // padding: EdgeInsets.only(top: 5),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      height: 45,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        itemCount: _statusList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (order_prov.isLoading) return;
                              _handleStatusChanged(_statusList[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: _selectedStatus == _statusList[index]
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1)
                                    : ColorResources.COLOR_GREY
                                        .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  _statusList[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _selectedStatus == _statusList[index]
                                        ? Theme.of(context).primaryColor
                                        : ColorResources.COLOR_BLACK
                                            .withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                ),
                // Appointment Reminder Section
                // FutureBuilder<Map<String, dynamic>>(
                //   future: _appointmentDetailsFuture,
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return CircularProgressIndicator();
                //     } else if (snapshot.hasError) {
                //       return Text("Error loading appointment details");
                //     } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                //       final appointmentDetails = snapshot.data!;
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           "You have an appointment that is coming tomorrow!\n"
                //           "Order ID: ${appointmentDetails['orderId']}\n"
                //           "Vendor Name: ${appointmentDetails['vendorName'] ?? 'N/A'}\n"
                //           "Vendor Contact: ${appointmentDetails['vendorContact'] ?? 'N/A'}",
                //           style: CustomTextStyles(context).titleStyle.copyWith(
                //                 color: Colors.red,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //           textAlign: TextAlign.center,
                //         ),
                //       );
                //     } else {
                //       return Text("No upcoming appointment");
                //     }
                //   },
                // ),
                Expanded(
                  flex: 9,
                  child: Container(
                    width: size.width,
                    child: Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return orderProvider.orderList.isEmpty &&
                                orderProvider.isLoading
                            ? ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return EmptyOrder();
                                })
                            : orderProvider.orderList.isEmpty &&
                                    !orderProvider.isLoading
                                ? Center(
                                    child: Text(
                                    "No Requests",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.7),
                                        fontSize: 18),
                                  ))
                                : ListView.builder(
                                    padding: (orderProvider.noMoreDataMessage
                                                    .isNotEmpty &&
                                                !orderProvider.isLoading ||
                                            (orderProvider.noMoreDataMessage
                                                    .isEmpty &&
                                                orderProvider.orderList.length <
                                                    8))
                                        ? EdgeInsets.fromLTRB(10, 0, 10, 10)
                                        : EdgeInsets.only(
                                            bottom: 235,
                                            left: 10,
                                            right: 10,
                                            top: 0),
                                    controller: _scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: orderProvider.orderList.length +
                                        (orderProvider.isLoading &&
                                                orderProvider
                                                        .orderList.length >=
                                                    8
                                            ? 1
                                            : 0),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index >=
                                              orderProvider.orderList.length &&
                                          orderProvider
                                              .noMoreDataMessage.isEmpty) {
                                        return EmptyOrder();
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .getOrderDetailRoute(
                                                              orderProvider
                                                                  .orderList[
                                                                      index]
                                                                  .id
                                                                  .toString()))
                                                  .then(
                                                (value) {
                                                  _loadData();
                                                },
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      offset:
                                                          const Offset(0, 2),
                                                      blurRadius: 10.0),
                                                ],
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Order ID: ",
                                                            style:
                                                                CustomTextStyles(
                                                                        context)
                                                                    .titleStyle,
                                                          ),
                                                          Text(
                                                            orderProvider
                                                                .orderList[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            style: CustomTextStyles(
                                                                    context)
                                                                .subTitleStyle,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            orderProvider
                                                                            .orderList[
                                                                                index]
                                                                            .status! ==
                                                                        "pay" ||
                                                                    orderProvider
                                                                            .orderList[
                                                                                index]
                                                                            .status! ==
                                                                        "prepare" ||
                                                                    orderProvider
                                                                            .orderList[
                                                                                index]
                                                                            .status! ==
                                                                        "confirm"
                                                                ? 
                                                                    orderProvider
                                                                        .orderList[
                                                                            index]
                                                                        .status!
                                                                        .capitalize()
                                                                : orderProvider
                                                                    .orderList[
                                                                        index]
                                                                    .status!
                                                                    .capitalize(),
                                                            style: CustomTextStyles(context).subTitleStyle.copyWith(
                                                                color: orderProvider
                                                                            .orderList[
                                                                                index]
                                                                            .status! ==
                                                                        "cancel"
                                                                    ? Colors.red
                                                                        .withOpacity(
                                                                            0.8)
                                                                    : ColorResources
                                                                        .COLOR_PRIMARY,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ]),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Requested at: ',
                                                          style:
                                                              CustomTextStyles(
                                                                      context)
                                                                  .titleStyle
                                                                  .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(
                                                                  orderProvider
                                                                      .orderList[
                                                                          index]
                                                                      .date!),
                                                          style:
                                                              CustomTextStyles(
                                                                      context)
                                                                  .subTitleStyle
                                                                  .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Deposit: ",
                                                          style:
                                                              CustomTextStyles(
                                                                      context)
                                                                  .titleStyle
                                                                  .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                        ),
                                                        Text(
                                                          "RM" +
                                                              orderProvider
                                                                  .orderList[
                                                                      index]
                                                                  .totalAmount!
                                                                  .toStringAsFixed(
                                                                      2),
                                                          style: CustomTextStyles(
                                                                  context)
                                                              .subTitleStyle
                                                              .copyWith(
                                                                  fontSize: 15,
                                                                  color: ColorResources
                                                                      .COLOR_PRIMARY,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ],
                                                    ),
                                                    // Spacer(),
                                                    // if (orderProvider
                                                    //             .orderList[
                                                    //                 index]
                                                    //             .status! ==
                                                    //         "prepare" ||
                                                    //     orderProvider
                                                    //             .orderList[
                                                    //                 index]
                                                    //             .status! ==
                                                    //         "confirm" ||
                                                    //     orderProvider
                                                    //             .orderList[
                                                    //                 index]
                                                    //             .status! ==
                                                    //         "completed")
                                                    //   Container(
                                                    //     height: 35,
                                                    //     width: double.infinity,
                                                    //     child: Text(
                                                    //       "Delivery Status",
                                                    //       style: TextStyle(
                                                    //           fontSize: 15,
                                                    //           color: ColorResources
                                                    //               .COLOR_PRIMARY,
                                                    //           fontWeight:
                                                    //               FontWeight
                                                    //                   .w400),
                                                    //     ),
                                                    //   ),
                                                    const SizedBox(height: 10),
                                                    if (orderProvider
                                                            .orderList[index]
                                                            .status! ==
                                                        "pay")
                                                      CustomButton(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                                  context,
                                                                  Routes.getPaymentRoute(
                                                                      PaymentType
                                                                          .card
                                                                          .toString(),
                                                                      orderProvider
                                                                          .orderList[
                                                                              index]
                                                                          .id
                                                                          .toString()))
                                                              .then((value) {
                                                            if (value == true) {
                                                              setState(() {
                                                                orderProvider
                                                                    .orderList[
                                                                        index]
                                                                    .status = "confirm";
                                                              });
                                                              _loadData();
                                                            } else {
                                                              _loadData();
                                                            }
                                                          });
                                                        },
                                                        btnTxt: "Pay Now",
                                                      )
                                                  ]),
                                            ),
                                          ),
                                        );
                                      }
                                    });
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
