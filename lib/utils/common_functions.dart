import 'dart:io';

import 'package:beta/theme/app_color.dart';
import 'package:beta/theme/app_size.dart';
import 'package:beta/theme/radius_size.dart';
import 'package:beta/theme/strings.dart';
import 'package:beta/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class CommonFunctions {
  static Future<T?> navigateToRoute<T>({required Widget page, String? name, Object? arguments, bool replace = false, Function(T)? onThen}) async {
    if (replace) {
      return NavigationService.pushReplacement(page) as Future<T?>;
    } else {
      return NavigationService.push<T>(page: page, name: name, arguments: arguments)?.then((value) {
        if (value != null && onThen != null) {
          onThen(value);
        }
        return value;
      });
    }
  }

  static navigateToRouteAndRemoveUntil({required Widget page, Function? onThen}) {
    NavigationService.pushAndRemoveUntil(page: page, predicate: (route) => false)?.then((value) {
      if (value != null) {
        onThen?.call(value);
      }
    });
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void showSuccessToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM, Color bgColor = const Color(0xFF66bb6a), Color textColor = Colors.white}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 2,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: AppSize.fontSize14);
  }

  static void showWarningToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM, Color bgColor = const Color(0xFFffa726), Color textColor = Colors.white}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 2,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: AppSize.fontSize14);
  }

  static void showErrorToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM, Color bgColor = const Color(0xfff65c4f), Color textColor = Colors.white}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 2,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: AppSize.fontSize14);
  }

  static showLoader(BuildContext context) {
    context.loaderOverlay.show();
  }

  static dismissLoader(BuildContext context) {
    context.loaderOverlay.hide();
  }

  static void setToClipboard({String? clipboardData}) {
    try {
      Clipboard.setData(ClipboardData(text: clipboardData ?? "")).then((_) {
        CommonFunctions.showSuccessToast("Copied to Clipboard!");
      });
    } catch (e) {
      CommonFunctions.showErrorToast("Failed to copy to clipboard.");
    }
  }

  static Future<void> dialPhoneNumber(String phoneNumber) async {
    final Uri callUri = Uri.parse('tel:+91 $phoneNumber');

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $callUri';
    }
  }

  static Future<void> getDirectionOnGoogleMap({required String origin, required String destination, List<String>? waypoints, String travelMode = 'driving'}) async {
    final waypointsString = waypoints?.join('|') ?? '';
    final Uri uri =
        Uri.parse('https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&waypoints=$waypointsString&travelmode=$travelMode&dir_action=navigate');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static BoxDecoration cardDecoration({Color? color, List<BoxShadow>? boxShadow, BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: color ?? AppColors.whiteColor,
      boxShadow: boxShadow ??
          const [
            BoxShadow(offset: Offset(1, 1), blurRadius: 6, color: Color.fromRGBO(0, 0, 0, 0.16)),
          ],
      borderRadius: borderRadius ?? BorderRadius.circular(RadiusSize.radiusSize8),
    );
  }

  static BoxDecoration cardOutlineDecoration({Color? color, Color? borderColor, BorderRadius? borderRadius, double? borderWidth}) {
    return BoxDecoration(
        color: color ?? AppColors.whiteColor,
        border: Border.all(color: borderColor ?? AppColors.editTextBorderColor, width: borderWidth ?? 1),
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(RadiusSize.radiusSize8)));
  }

  static BoxDecoration bottomBarDecoration({Color? color, List<BoxShadow>? boxShadow, BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: color ?? AppColors.whiteColor,
      boxShadow: boxShadow ??
          const [
            BoxShadow(offset: Offset(2, 2), blurRadius: 12, color: Color.fromRGBO(0, 0, 0, 0.16)),
          ],
      borderRadius: borderRadius ?? BorderRadius.circular(RadiusSize.radiusSize0),
    );
  }



  static String getStatusType(int status) {
    switch (status) {
      case 1:
        return Strings.requestForApproval;
      case 2:
        return Strings.inTransit;
      case 3:
        return Strings.payment;
      case 4:
        return Strings.completed;
      case 5:
        return Strings.cancelled;
      default:
        return 'Unknown Status';
    }
  }

  static Color getStatusTypeColor(int status) {
    switch (status) {
      case 1:
        return AppColors.debitGreenColor;
      case 2:
        return AppColors.creditGreenColor;
      case 3:
        return AppColors.creditGreenColor;
      case 4:
        return AppColors.creditGreenColor;
      case 5:
        return AppColors.debitGreenColor;
      default:
        return AppColors.debitGreenColor;
    }
  }

  static showCustomBottomSheet({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    bool isDismissible = false,
    bool enableDrag = false,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor ?? AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.only(topLeft: Radius.circular(borderRadius ?? RadiusSize.radiusSize20), topRight: Radius.circular(borderRadius ?? RadiusSize.radiusSize20)),
      ),
      showDragHandle: true,
      builder: builder,
    );
  }


/*static showPermissionDialog(String permissionType, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return PermissionDialog(permissionType: permissionType,);
      },
    );
  }*/

/* static openImageSelectingBottomSheet(BuildContext context,
      {required String title,
        VoidCallback? onCameraClick,
        VoidCallback? onGalleryClick}) {
    return showModalBottomSheet(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return ImageSelectionBottomSheet(title: title, onCameraClick: onCameraClick, onGalleryClick: onGalleryClick);
        });
  }*/
}

enum TimelineStatus {
  done,
  cancel,
  inProgress,
  todo,
}
