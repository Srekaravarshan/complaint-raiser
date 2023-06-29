import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageServices {
  ImageServices._();

  static Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      final imageTemp = File(image.path);
      return imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }

  // clearImage() {
  //   if (_coverUrl != '') {
  //     String filePath =
  //         // 'https://firebasestorage.googleapis.com/v0/b/nova-green-999c8.appspot.com/o/product_8efdc633-f740-49c9-be1b-d37fe110c3e2.jpg?alt=media&token=a1fef450-2f50-4d78-bdbf-c6f08635484d'
  //         _coverUrl
  //             .replaceAll(
  //                 new RegExp(
  //                     r'https://firebasestorage.googleapis.com/v0/b/nova-green-999c8.appspot.com/o/'),
  //                 '')
  //             .split('?')[0];

  //     FirebaseStorage.instance
  //         .ref()
  //         .child(filePath)
  //         .delete()
  //         .then((_) => print('Successfully deleted $filePath storage item'));
  //   }
  //   setState(() {
  //     file = null;
  //     _coverUrl = '';
  //   });
  // }

}
