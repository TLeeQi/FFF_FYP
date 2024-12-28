// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurserygardenapp/providers/vendor_provider.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/empty_grid_item.dart';
import 'package:nurserygardenapp/view/screen/vendor/widget/vendor_grid_item.dart';
import 'package:provider/provider.dart';

class VendorSearchResultScreen extends StatefulWidget {
  final String searchKeyword;
  const VendorSearchResultScreen({super.key, required this.searchKeyword});

  @override
  State<VendorSearchResultScreen> createState() =>
      _VendorSearchResultScreenState();
}

class _VendorSearchResultScreenState extends State<VendorSearchResultScreen> {
  late VendorProvider vendor_prov =
      Provider.of<VendorProvider>(context, listen: false);

  final _scrollController = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Param
  var params = {
    'limit': '8',
    'keyword': "",
  };

  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      params['keyword'] = widget.searchKeyword;
      _loadData();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (vendor_prov.vendorListSearch.length < int.parse(params['limit']!)) {
        return;
      } else {
        int currentLimit = int.parse(params['limit']!);
        currentLimit += 8;
        params['limit'] = currentLimit.toString();
        _loadData(isLoadMore: true);
      }
    }
  }

  Future<void> _loadData({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() {
        _isFirstTime = false;
      });
    }
    await vendor_prov.searchVendor(context, params, isLoadMore: isLoadMore);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          backgroundColor: ColorResources.COLOR_PRIMARY,
          title: InkWell(
            onTap: () {
              Navigator.pop(context, widget.searchKeyword);
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                      child: Text(
                    widget.searchKeyword,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      // color: Colors.white,
                      fontSize: 14,
                    ),
                  )),
                  Icon(Icons.search),
                ]),
              ),
            ),
          ),
          actions: []),
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<VendorProvider>(
                      builder: (context, vendorProvider, child) {
                    return vendorProvider.isLoadingSearch &&
                            vendorProvider.endSearchResult.isEmpty &&
                            _isFirstTime
                        ? Expanded(
                            child: GridView.builder(
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
                                itemBuilder: (BuildContext context, int index) {
                                  return EmptyGridItem();
                                }),
                          )
                        : vendorProvider.vendorListSearch.isEmpty &&
                                !vendorProvider.isLoadingSearch
                            ? Center(
                                child: Text(
                                  "No Vendor Found",
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(0.7),
                                      fontSize: 18),
                                ),
                              )
                            : Expanded(
                                child: GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      vendorProvider.vendorListSearch.length +
                                          ((vendorProvider.isLoadingSearch &&
                                                  vendorProvider
                                                          .vendorListSearch
                                                          .length >=
                                                      8)
                                              ? 8
                                              : vendorProvider.endSearchResult
                                                      .isNotEmpty
                                                  ? 1
                                                  : 0),
                                  padding: (vendorProvider
                                              .endSearchResult.isNotEmpty &&
                                          !vendorProvider.isLoadingSearch)
                                      ? EdgeInsets.all(10)
                                      : EdgeInsets.only(
                                          bottom: 235,
                                          left: 10,
                                          right: 10,
                                          top: 10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3 / 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index >=
                                            vendorProvider
                                                .vendorListSearch.length &&
                                        vendorProvider
                                            .endSearchResult.isEmpty) {
                                      return EmptyGridItem();
                                    } else if (index ==
                                            vendorProvider
                                                .vendorListSearch.length &&
                                        vendorProvider
                                            .endSearchResult.isNotEmpty) {
                                      return Container(
                                        height: 150,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                          child: Text(
                                              vendorProvider.endSearchResult,
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                        ),
                                      );
                                    } else {
                                      return VendorGridItem(
                                        key: ValueKey(vendorProvider
                                            .vendorListSearch
                                            .elementAt(index)
                                            .id),
                                        vendor: vendorProvider
                                            .vendorListSearch
                                            .elementAt(index),
                                        onTap: () async {
                                          await Navigator.pushNamed(
                                              context,
                                              Routes.getVendorDetailRoute(
                                                  vendorProvider
                                                      .vendorListSearch
                                                      .elementAt(index)
                                                      .id!
                                                      .toString(),
                                                  "true",
                                                  'false'));
                                        },
                                      );
                                    }
                                  },
                                ),
                              );
                  }),
                ],
              ),
            ),
          )),
    );
  }
}
