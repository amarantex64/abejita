import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _iconSize = 90.0;
const double _maxContentWidth = 600.0;

enum MessageBoxResult { confirm, cancel }

enum MessageBoxType { error, warning, info, success, question }

Color _getBackgroundColor(MessageBoxType type) {
  switch (type) {
    case MessageBoxType.error:
      return const Color.fromARGB(255, 211, 47, 47);
    case MessageBoxType.warning:
      return const Color.fromARGB(255, 194, 166, 27);
    case MessageBoxType.info:
      return const Color.fromARGB(255, 25, 118, 210);
    case MessageBoxType.success:
      return const Color.fromARGB(255, 56, 142, 60);
    case MessageBoxType.question:
      return const Color.fromARGB(255, 245, 124, 0);
  }
}

class MessageBoxIcon {
  static const IconData error = Icons.error_outline;
  static const IconData warning = Icons.warning_amber_outlined;
  static const IconData info = Icons.info_outline;
  static const IconData success = Icons.check_circle_outline;
  static const IconData question = Icons.help_outline;

  static IconData getIcon(MessageBoxType type) {
    switch (type) {
      case MessageBoxType.error:
        return error;
      case MessageBoxType.warning:
        return warning;
      case MessageBoxType.info:
        return info;
      case MessageBoxType.success:
        return success;
      case MessageBoxType.question:
        return question;
    }
  }
}

class MessageBox {
  static Future<void> showDialog(
    String title,
    String message, {
    MessageBoxType type = MessageBoxType.info,
    bool isDismissible = true,
    bool needColorfulBackground = true,
    IconData? icon,
    Color? backgroundColor,
  }) {
    icon ??= MessageBoxIcon.getIcon(type);
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(title, style: needColorfulBackground ? TextStyle(color: Colors.white) : null),
        backgroundColor: needColorfulBackground ? backgroundColor ?? _getBackgroundColor(type) : null,
        content: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: _maxContentWidth),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: needColorfulBackground ? TextStyle(color: Colors.white) : null,
          ),
        ),
        icon: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
          child: Icon(icon, size: _iconSize, color: needColorfulBackground ? Colors.white : _getBackgroundColor(type)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("OK", style: needColorfulBackground ? TextStyle(color: Colors.white) : null),
          ),
        ],
      ),
      barrierDismissible: isDismissible,
      useSafeArea: false,
      transitionCurve: Curves.decelerate,
    );
  }

  static Future<void> showErrorDialog(String title, String message) =>
      showDialog(title, message, type: MessageBoxType.error, isDismissible: false);

  static Future<void> showSuccessDialog(String title, String message) =>
      showDialog(title, message, type: MessageBoxType.success, isDismissible: false);

  static Future<void> showInfoDialog(String title, String message) =>
      showDialog(title, message, type: MessageBoxType.info, isDismissible: false);

  static Future<MessageBoxResult> showAskDialog(
    String title,
    String message, {
    MessageBoxType type = MessageBoxType.question,
    bool needColorfulBackground = true,
    bool isDismissible = true,
    String confirmText = "Confirmar",
    String cancelText = "Cancelar",
    IconData? icon,
    Color? backgroundColor,
  }) async {
    icon ??= MessageBoxIcon.getIcon(type);
    final result = await Get.dialog<MessageBoxResult>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(title, style: needColorfulBackground ? TextStyle(color: Colors.white) : null),
        backgroundColor: needColorfulBackground ? backgroundColor ?? _getBackgroundColor(type) : null,
        content: message.isEmpty
            ? null
            : ConstrainedBox(
                constraints: BoxConstraints(maxWidth: _maxContentWidth),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: needColorfulBackground ? TextStyle(color: Colors.white) : null,
                ),
              ),
        icon: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
          child: Icon(icon, size: _iconSize, color: needColorfulBackground ? Colors.white : _getBackgroundColor(type)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: MessageBoxResult.confirm),
            child: Text(confirmText, style: needColorfulBackground ? TextStyle(color: Colors.white) : null),
          ),
          TextButton(
            onPressed: () => Get.back(result: MessageBoxResult.cancel),
            child: Text(cancelText, style: needColorfulBackground ? TextStyle(color: Colors.white) : null),
          ),
        ],
      ),
      barrierDismissible: isDismissible,
      useSafeArea: false,
      transitionCurve: Curves.decelerate,
    );

    return result ?? MessageBoxResult.cancel;
  }

  static Future<MessageBoxResult> showYesOrNotDialog(
    String title,
    String message, {
    MessageBoxType type = MessageBoxType.question,
    bool needColorfulBackground = true,
    bool isDismissible = true,
  }) {
    return showAskDialog(
      title,
      message,
      type: type,
      needColorfulBackground: needColorfulBackground,
      isDismissible: isDismissible,
      confirmText: "Sí",
      cancelText: "No",
    );
  }

  static void showSnackBarMessage(
    String title,
    String message, {
    MessageBoxType type = MessageBoxType.info,
    bool isDismissible = true,
    bool needColorfulBackground = true,
    Duration duration = const Duration(seconds: 10),
    IconData? icon,
  }) {
    icon ??= MessageBoxIcon.getIcon(type);
    Get.snackbar(
      title,
      message,
      colorText: needColorfulBackground ? Colors.white : null,
      backgroundColor: needColorfulBackground ? _getBackgroundColor(type) : null,
      isDismissible: true,
      icon: Icon(icon, color: Colors.white, size: 30),
      shouldIconPulse: true,
      maxWidth: _maxContentWidth,
      barBlur: 50,
      borderRadius: 8,
      duration: duration,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: Text("OK", style: needColorfulBackground ? TextStyle(color: Colors.white) : null),
      ),
    );
  }

  static void showSnackBarInfo(
    String title,
    String message, {
    bool isDismissible = true,
    Duration duration = const Duration(seconds: 10),
  }) {
    showSnackBarMessage(
      title,
      message,
      type: MessageBoxType.info,
      isDismissible: isDismissible,
      duration: duration,
      needColorfulBackground: true,
    );
  }

  static void showSnackBarError(
    String title,
    String message, {
    bool isDismissible = true,
    Duration duration = const Duration(seconds: 25),
  }) {
    showSnackBarMessage(
      title,
      message,
      type: MessageBoxType.error,
      isDismissible: isDismissible,
      needColorfulBackground: true,
      duration: duration,
    );
  }

  static void showSnackBarWarning(
    String title,
    String message, {
    bool isDismissible = true,
    Duration duration = const Duration(seconds: 20),
  }) {
    showSnackBarMessage(
      title,
      message,
      type: MessageBoxType.warning,
      isDismissible: isDismissible,
      needColorfulBackground: true,
      duration: duration,
    );
  }

  static void showSnackBarSuccess(
    String title,
    String message, {
    bool isDismissible = true,
    Duration duration = const Duration(seconds: 10),
  }) {
    showSnackBarMessage(
      title,
      message,
      type: MessageBoxType.success,
      isDismissible: isDismissible,
      needColorfulBackground: true,
      duration: duration,
    );
  }
}
