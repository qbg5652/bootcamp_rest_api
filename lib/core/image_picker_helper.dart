import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ImagePickerHelper {
  static Future<PickImageResult?> pickImage() async {
    final imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      final bytes = await xFile.readAsBytes();
      final finaName = xFile.name;
      final mimeType = lookupMimeType(xFile.path, headerBytes: bytes);
      if (mimeType == null) {
        return null;
      }
      return PickImageResult(
        finaname: finaName,
        mimetype: mimeType,
        bytes: bytes,
      );
    }
    return null;
  }
}

class PickImageResult {
  final String finaname;
  final String mimetype;
  final Uint8List bytes;
  PickImageResult({
    required this.finaname,
    required this.mimetype,
    required this.bytes,
  });
}
