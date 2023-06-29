import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  StorageServices._();

  static final instance = StorageServices._();

  Future<String?> set({required File file, required String filePath}) async {
    TaskSnapshot snapshot =
        await FirebaseStorage.instance.ref().child(filePath).putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    }
    return null;
  }

  Future<void> delete({required String url}) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
  }
}
