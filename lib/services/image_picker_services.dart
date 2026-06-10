import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'hive_service.dart';

class ImagePickerServices {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  Future<void> imagePick({bool isCamera = false}) async {
    image = await picker.pickImage(source: (isCamera) ? ImageSource.camera : ImageSource.gallery);
  }

  Future<void> saveImage() async {
    if (image != null) {
      final sourceFile = File(image!.path);

      final oldPath = HiveService.getSettings().profileImagePath;
      if (oldPath.isNotEmpty) {
        final oldFile = File(oldPath);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }
      final fileName = image!.name;

      final dir = await getApplicationDocumentsDirectory();
      final targetPath = '${dir.path}/$fileName';

      await sourceFile.copy(targetPath);

      HiveService.saveSettings(HiveService.getSettings().copyWith(profileImagePath: targetPath));
    }
  }
}
