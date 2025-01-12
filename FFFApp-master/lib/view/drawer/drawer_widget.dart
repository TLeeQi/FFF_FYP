import 'package:flutter/material.dart';
import 'package:nurserygardenapp/providers/auth_provider.dart';
import 'package:nurserygardenapp/util/app_constants.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/dimensions.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/custom_dialog.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  void _handleRoute(String routeName) {
    // if (ModalRoute.of(context)?.settings.name == routeName) {
    //   Navigator.pop(context);
    // } else {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
      ),
      child: SafeArea(
        child: Container(
          height: widget.size.height,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _handleRoute(Routes.getDashboardRoute("Plant"));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            ColorResources.COLOR_GREY_CHATEAU.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    leading: Icon(
                      Icons.local_florist_outlined,
                      size: 25,
                      color: ColorResources.COLOR_BLACK,
                    ),
                    title: Text(
                      "Plant",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w400,
                            color: ColorResources.COLOR_BLACK,
                          ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_outlined,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _handleRoute(Routes.getDashboardRoute("Product"));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            ColorResources.COLOR_GREY_CHATEAU.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    leading: Icon(
                      Icons.widgets_outlined,
                      size: 25,
                      color: ColorResources.COLOR_BLACK,
                    ),
                    title: Text(
                      "Product",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w400,
                            color: ColorResources.COLOR_BLACK,
                          ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_outlined,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _handleRoute(Routes.getDashboardRoute("Bidding"));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            ColorResources.COLOR_GREY_CHATEAU.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    leading: Icon(
                      Icons.local_atm_outlined,
                      size: 25,
                      color: ColorResources.COLOR_BLACK,
                    ),
                    title: Text(
                      "Bidding",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w400,
                            color: ColorResources.COLOR_BLACK,
                          ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_outlined,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  _handleRoute(Routes.getDashboardRoute("Account"));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            ColorResources.COLOR_GREY_CHATEAU.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    leading: Icon(
                      Icons.manage_accounts_outlined,
                      size: 25,
                      color: ColorResources.COLOR_BLACK,
                    ),
                    title: Text(
                      "Account",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.w400,
                          color: ColorResources.COLOR_BLACK),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_outlined,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                ),
              ),

              // Expanded(
              //   child: Container(),
              // ),

              Consumer<AuthProvider>(builder: (context, authProvider, child) {
                return GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            dialogType: AppConstants.DIALOG_CONFIRMATION,
                            btnText: "Logout",
                            title: "Logout",
                            content: "Are you sure you want to logout?",
                            onPressed: () {
                              if (authProvider.isLoading) return;
                              authProvider.logout(context).then((value) {
                                if (value) {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.getLoginRoute(), (route) => false);
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            },
                          );
                        });
                  },
                  child: Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      leading: Icon(
                        Icons.logout,
                        color: ColorResources.APPBAR_HEADER_COLOR,
                        size: 20,
                      ),
                      title: Text(
                        "Logout",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorResources.APPBAR_HEADER_COLOR,
                                ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
