import 'package:flutter/material.dart';
import 'package:nurserygardenapp/providers/vendor_provider.dart';
import 'package:nurserygardenapp/view/screen/vendor/widget/vendor_grid_item.dart';
// import 'package:nurserygardenapp/view/screen/vendor/vendor_detail_screen.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:nurserygardenapp/view/base/empty_grid_item.dart';

class VendorScreen extends StatefulWidget {
  // Define a GlobalKey for a specific widget
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  late VendorProvider vendor_prov =
      Provider.of<VendorProvider>(context, listen: false);

  final _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> vendorScaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Params
  var params = {
    'limit': '8',
  };

  Future<void> _loadData({bool isLoadMore = false}) async {
    try {
      await vendor_prov.getVendorList(context, params).then((value) {});
    } catch (e) {
      print('Error in _loadData: $e');
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (vendor_prov.vendorList.length < int.parse(params['limit']!)) return;
      int currentLimit = int.parse(params['limit']!);
      currentLimit += 8;
      params['limit'] = currentLimit.toString();
      _loadData(isLoadMore: true);
    }
  }

  @override
  void initState() {
    super.initState();
    print('vendorscreen initState');
    _scrollController.addListener(_onScroll);
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('vendorscreen build');
    
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: vendorScaffoldKey,
      
      appBar: AppBar(
          backgroundColor: ColorResources.COLOR_PRIMARY,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Verified Vendors",
                style: CustomTextStyles(context)
                    .titleStyle
                    .copyWith(color: ColorResources.COLOR_WHITE, fontSize: 16)),
          ),
        ),
        body: SizedBox(
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                key: _refreshIndicatorKey,
                onRefresh: () => _loadData(isLoadMore: false),
                child: VsScrollbar(
                  controller: _scrollController,
                  showTrackOnHover: true, // default false
                  isAlwaysShown: true, // default false
                  scrollbarFadeDuration: Duration(
                      milliseconds:
                          500), // default : Duration(milliseconds: 300)
                  scrollbarTimeToFade: Duration(
                      milliseconds:
                          800), // default : Duration(milliseconds: 600)
                  style: VsScrollbarStyle(
                    hoverThickness: 4.0, // default 12.0
                    radius: Radius.circular(10), // default Radius.circular(8.0)
                    thickness: 4.0, // [ default 8.0 ]
                    color: ColorResources
                        .COLOR_PRIMARY, // default ColorScheme Theme
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<VendorProvider>(
                            builder: (context, vendorProvider, child) {
                          return vendorProvider.vendorList.isEmpty &&
                                  vendorProvider.isLoading
                              ? GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: 8,
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3 / 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return EmptyGridItem();
                                  })
                              : vendorProvider.vendorList.isEmpty &&
                                      !vendorProvider.isLoading
                                  ? Container(
                                      height: size.height,
                                      width: size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: Text(
                                            "No Vendor Avialable Yet",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              fontSize: 18),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 15),
                                      child: GridView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount:
                                            vendorProvider.vendorList.length +
                                                ((vendorProvider.isLoading &&
                                                        vendorProvider
                                                                .vendorList
                                                                .length >=
                                                            8)
                                                    ? 8
                                                    : vendorProvider
                                                              .vendorNoMoreData
                                                            .isNotEmpty
                                                        ? 1
                                                        : 0),
                                        padding: (vendorProvider
                                                    .vendorNoMoreData
                                                    .isNotEmpty &&
                                                !vendorProvider.isLoading)
                                            ? EdgeInsets.fromLTRB(10, 0, 10, 10)
                                            : EdgeInsets.only(
                                                bottom: 235,
                                                left: 10,
                                                right: 10,
                                                top: 0),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2 / 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (index >=
                                                  vendorProvider
                                                      .vendorList.length &&
                                              vendorProvider
                                                  .vendorNoMoreData.isEmpty) {
                                            return EmptyGridItem();
                                          } else if (index ==
                                                  vendorProvider
                                                      .vendorList.length &&
                                              vendorProvider.vendorNoMoreData
                                                  .isNotEmpty) {
                                            return Container(
                                              height: 150,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Center(
                                                child: Text(
                                                    vendorProvider
                                                        .vendorNoMoreData,
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .withOpacity(0.5))),
                                              ),
                                            );
                                          } else {
                                            return SizedBox(
                                              height: 200,
                                              child: VendorGridItem(
                                                  vendor: vendorProvider
                                                      .vendorList[index],
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routes.getVendorDetailRoute(
                                                              vendorProvider
                                                                .vendorList[
                                                                    index]
                                                                .id
                                                                .toString()));
                                                  }),
                                            );
                                          }
                                        },
                                      ),
                                    );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}