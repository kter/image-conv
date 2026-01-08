import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 4096,
        maxHeight: 4096,
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 4096,
        maxHeight: 4096,
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> pickFromFiles() async {
    try {
      // Using gallery as file picker since image_picker handles this
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 4096,
        maxHeight: 4096,
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
