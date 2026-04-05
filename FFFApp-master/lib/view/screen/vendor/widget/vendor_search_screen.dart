import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:FFF/providers/vendor_provider.dart';
import 'package:FFF/util/color_resources.dart';
import 'package:FFF/util/routes.dart';
import 'package:provider/provider.dart';

class VendorSearchScreen extends StatefulWidget {
  @override
  _VendorSearchScreenState createState() => _VendorSearchScreenState();
}

class _VendorSearchScreenState extends State<VendorSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
        backgroundColor: ColorResources.COLOR_PRIMARY,
        title: Container(
          height: 40,
          child: Consumer<VendorProvider>(
              builder: (context, vendorProvider, child) {
            return TextField(
              onChanged: (value) {
                vendorProvider.getSearchTips(value);
              },
              onSubmitted: (value) {
                if (_searchController.text.isEmpty) {
                  EasyLoading.showError('Please enter the vendor name',
                      dismissOnTap: true,
                      duration: Duration(milliseconds: 500));
                  return;
                }
                FocusScope.of(context).unfocus();
                Navigator.pushNamed(context,
                    Routes.getVendorSearchResultRoute(_searchController.text));
              },
              autofocus: true,
              cursorColor: Theme.of(context).primaryColor,
              controller: _searchController,
              focusNode: _focusNode,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 10),
                  focusColor: Theme.of(context).primaryColor,
                  hintText: 'Search Vendor',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                      if (_searchController.text.isEmpty) {
                        EasyLoading.showError('Please enter the vendor name',
                            dismissOnTap: true,
                            duration: Duration(milliseconds: 500));
                        return;
                      }
                      FocusScope.of(context).unfocus();
                      Navigator.pushNamed(
                          context,
                          Routes.getVendorSearchResultRoute(
                              _searchController.text));
                    },
                  )),
            );
          }),
        ),
      ),
      body:
          Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
        return vendorProvider.vendorSearchHint.length == 0
            ? Container(
                height: 50,
                child: Center(
                  child: Text(
                    'No Vendor Found',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: vendorProvider.vendorSearchHint.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          Routes.getVendorSearchResultRoute(
                              vendorProvider.vendorSearchHint[index]));
                    },
                    child: ListTile(
                      title: Text(vendorProvider.vendorSearchHint[index]),
                    ),
                  );
                },
              );
      }),
    );
  }
}
