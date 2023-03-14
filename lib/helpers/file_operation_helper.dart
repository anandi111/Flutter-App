import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileOperationHelper {
  FileOperationHelper._();
  static final FileOperationHelper fileOperationHelper = FileOperationHelper._();

  Future<String> getFilePath({required String fileName}) async {
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    String appDocumentsPath = appDocumentsDirectory!.path;
    String filePath = '$appDocumentsPath/$fileName.txt';
    print(filePath);

    return filePath;
  }

  Future<List<String>?> getAllFilePath() async {
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    List<FileSystemEntity>? filesList = appDocumentsDirectory!.listSync();
    List<String> allFilePathList = [];

    for (int i = 0; i < filesList.length; i++) {
      allFilePathList.add(filesList[i].path);
    }

    print(allFilePathList);

    return allFilePathList;
  }

  Future<List<File>> getAllFile() async {
    List<String>? allFilePathList = await getAllFilePath();
    List<File> allFileList = [];

    for (int i = 0; i < allFilePathList!.length; i++) {
      allFileList.add(File(allFilePathList[i]));
    }

    return allFileList;
  }

  Future<void> saveFile({required String fileName, required String msg}) async {
    File file = File(await getFilePath(fileName: fileName));
    file.writeAsString(msg);
  }

  Future<String> readFile({required String fileName}) async {
    File file = File(await getFilePath(fileName: fileName));
    String fileContent = await file.readAsString();

    print('File Content: $fileContent');

    return fileContent;
  }

  Future<void> renameFile({required File oldFile, required String newFileName}) async {
    File file = oldFile;
    String filePath = await getFilePath(fileName: newFileName);
    print(filePath);

    await file.rename(filePath);
  }

  Future<void> deleteFile({required String filePath}) async {
    await File(filePath).delete();
  }
}
