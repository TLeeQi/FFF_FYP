import 'package:flutter/material.dart';
import 'package:FFF/util/app_constants.dart';
import 'package:FFF/util/color_resources.dart';
import 'package:FFF/util/dimensions.dart';

class CustomDialog extends StatelessWidget {
  final String dialogType;
  final String? customImage;
  final String title;
  final String content;
  final String btnText;
  final String? btnTextCancel;
  final VoidCallback onPressed;
  final Color? dialogColor;

  const CustomDialog({
    Key? key,
    required this.dialogType,
    this.customImage,
    required this.title,
    required this.content,
    required this.btnText,
    this.btnTextCancel,
    this.dialogColor,
    required this.onPressed,
  }) : super(key: key);


  Widget handleDialogType(BuildContext context) {
    switch (dialogType) {
      case AppConstants.DIALOG_SUCCESS:
        return Icon(
          Icons.check_circle_outline,
          color: dialogColor ?? Theme.of(context).primaryColor,
          size: 60,
        );
      case AppConstants.DIALOG_FAILED:
        return Icon(
          Icons.highlight_off_outlined,
          color: dialogColor ?? Theme.of(context).primaryColor,
          size: 60,
        );
      case AppConstants.DIALOG_ERROR:
        return Icon(
          Icons.error_outline,
          color: dialogColor ?? ColorResources.APPBAR_HEADER_COLOR,
          size: 60,
        );
      case AppConstants.DIALOG_INFORMATION:
        return Icon(
          Icons.help_outline,
          color: dialogColor ?? Theme.of(context).primaryColor,
          size: 60,
        );
      case AppConstants.DIALOG_ALERT:
        return Icon(
          Icons.report_outlined,
          color: dialogColor ?? Theme.of(context).primaryColor,
          size: 60,
        );
      case AppConstants.DIALOG_CONFIRMATION:
        return Icon(
          Icons.error_outline,
          color: dialogColor ?? Theme.of(context).primaryColor,
          size: 60,
        );
      case AppConstants.DIALOG_WARNING:
        return Icon(
          Icons.warning_amber_outlined,
          color: dialogColor ?? Theme.of(context).primaryColor,
          size: 60,
        );
      case AppConstants.DIALOG_CUSTOM:
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(customImage!),
              fit: BoxFit.cover,
            ),
          ),
        );
      default:
        return Icon(
          Icons.check_circle_outline,
          color: dialogColor ?? Theme.of(context).primaryColor,
          size: 60,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: <Widget>[
              SizedBox(height: 9),
              handleDialogType(context),
              SizedBox(height: 9),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 9),
              Text(
                content,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (dialogType == AppConstants.DIALOG_CONFIRMATION)
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ColorResources.COLOR_GREY,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      child: Text(
                        btnTextCancel ?? 'Cancel',
                        style: TextStyle(
                          color: ColorResources.COLOR_BLACK,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                    ),
                  ),
                ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    child: Text(
                      btnText,
                      style: TextStyle(color: ColorResources.COLOR_WHITE),
                    ),
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
