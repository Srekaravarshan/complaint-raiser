import 'dart:io';

import 'package:complaint_raiser/services/firestore_path.dart';
import 'package:complaint_raiser/services/storage_services.dart';

class StorageDatabase {
  StorageDatabase();

  final _firestoreService = StorageServices.instance;

  Future<String?> uploadCategoryImage(File file, String fileName) async{
    return await _firestoreService.set(file: file, filePath: StoragePath.category(fileName));
  }

  Future<String?> uploadProductImage(File file, String fileName) async{
    return await _firestoreService.set(file: file, filePath: StoragePath.product(fileName));
  }

  Future<void> deleteImageFromUrl (String url) async {
    await _firestoreService.delete(url: url);
  }

}