import 'dart:io';

import 'package:you_tube_downloader/utils/permission_utils.dart';

class FileUtils {
  static final FileUtils instance = FileUtils._();

  FileUtils._();

  Future<String?> getFilePath() async {
    String? filePath;
   bool isGranted = await PermissionUtils.getPermissions();

   print(isGranted);

   if(isGranted) {
     var directory = Directory("/storage/emulated/0/YTMusic");
     if(!await directory.exists())await directory.create();
     filePath = directory.path;
   }

   return filePath;
  }

}