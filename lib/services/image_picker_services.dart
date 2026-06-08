import 'dart:io';

import 'package:expense_tracker/services/hive_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerServices {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  Future<void> imagePick({bool isCamera = false}) async {
    image = await picker.pickImage(source: (isCamera) ? ImageSource.camera : ImageSource.gallery);
  }

  Future<void> saveImage() async {
    if (image != null) {
      final sourceFile = File(image!.path);
      Directory dir = await getApplicationDocumentsDirectory();

      final String targetPath = "${dir.path}/profile.jpg";
      final targetFile = File(targetPath);

      if (await targetFile.exists()) {
        await targetFile.delete();
      }
      await sourceFile.copy(targetPath);
      HiveService.saveSettings(HiveService.getSettings().copyWith(profileImagePath: targetPath));
    }
  }
}
