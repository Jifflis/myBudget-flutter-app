import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/maintenance_dialog_controller.dart';
import '../environment.dart';
import '../model/maintenance.dart';
import '../model/version.dart';
import '../routes.dart';
import '../view/dialog/budget_dialog.dart';

class MaintenanceUtil {
  MaintenanceUtil();

  static DateTime lastTimeCheck;

  static Future<Maintenance> getMaintenance() async {
    try {
      lastTimeCheck = DateTime.now();

      //get file from server
      final File file = await _getFileFromServer(
          Platform.isAndroid ? Env.maintenanceUrlAndroid : Env.maintenanceUrlIOS,
          'maintenance',
          await _getTemporaryPath());

      //extract file
      final List<Maintenance> dialogs = await extractFile(file);

      if (dialogs == null)
        return null;

      for (final Maintenance dialog in dialogs) {
        //check target version
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        final Version appVersion = Version.factory(packageInfo.version);
        final Version targetVersion =
            Version.factory(dialog.targetMaximumVersion);

        if (appVersion <= targetVersion) {
          final DateTime dateFrom = dialog.startDate;
          final DateTime dateTo = dialog.endDate;
          final DateTime dateNow = DateTime.now();

          if (dateNow.isAtSameMomentAs(dateFrom) ||
              dateNow.isAtSameMomentAs(dateTo) ||
              (dateNow.isAfter(dateFrom) && dateNow.isBefore(dateTo))) {
            return dialog;
          }
        }
      }

      return null;
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  static Future<List<Maintenance>> extractFile(File file) async {
    if (file == null) {
      return null;
    }

    try {
      final String content = await file.readAsString();
      final Map<String, dynamic> json = jsonDecode(content);
      final List<Maintenance> dialogs = <Maintenance>[];
      if (json != null && json['Maintenance'] != null) {
        json['Maintenance'].forEach((dynamic v) {
          dialogs.add(Maintenance(json: v));
        });
      }
      return dialogs;
    } catch (e) {
      print('Parsing error:${e.toString()}');
      return null;
    }
  }

  static Future<File> _getFileFromServer(
      String url, String fileName, String dir) async {
    File file;
    String filePath = '';

    try {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        return file;
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
      print(filePath);
    }
    return file;
  }

  static Future<String> _getTemporaryPath() async {
    final Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  static bool isAbleToRequest(DateTime time) {
    if (lastTimeCheck == null) {
      return true;
    }
    if (getTimeDifferenceInSeconds(lastTimeCheck, time) <= 3) {
      return false;
    }
    return true;
  }

  static int getTimeDifferenceInSeconds(
      DateTime lastTimeCheck, DateTime currentTime) {
    final Duration duration = currentTime.difference(lastTimeCheck);
    return duration.inSeconds;
  }

  static Future<void> showMaintenanceDialog(BuildContext context) async {
    final MaintenanceDialogController controller =
        Get.put(MaintenanceDialogController());

    final Maintenance maintenance = await getMaintenance();

    if (maintenance == null) {
      if (controller.dialogVisible) {
        Routes.pop();
        controller.toggleDialog();
      }
      return;
    }

    if (controller.dialogVisible) {
      return;
    } else {
      controller.toggleDialog();
    }

    showBudgetDialog(
      barrierDismissible: false,
        context: context,
        title: maintenance.dialogTitle,
        description: maintenance.dialogMessage,
        button1Title: maintenance.defaultButtonMessage,
        button2Title: maintenance.urlButtonMessage,
        showButton1: maintenance.defaultButtonMessage != null &&
            maintenance.defaultButtonMessage.isNotEmpty,
        showButton2: maintenance.urlButtonMessage != null &&
            maintenance.urlButtonMessage.isNotEmpty,
        onButton1Press: () {
          controller.toggleDialog();
          Routes.pop();
        },
        onButton2Press: () {
          if (maintenance.url != null && maintenance.url.isNotEmpty) {
            _launchUrl(maintenance.url);
          } else {
            controller.toggleDialog();
            Routes.pop();
          }
        });
  }

  static Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      showToast('Could not launch $url');
    }
  }
}
