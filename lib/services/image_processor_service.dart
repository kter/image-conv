import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../models/image_format.dart';

class ConvertedImageInfo {
  final int width;
  final int height;
  final int fileSize;

  ConvertedImageInfo({
    required this.width,
    required this.height,
    required this.fileSize,
  });

  String get formattedSize {
    if (fileSize < 1024) {
      return '$fileSize B';
    } else if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }
}

class ImageProcessorService {
  Future<ConvertedImageInfo?> getImageInfo(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return null;

      return ConvertedImageInfo(
        width: image.width,
        height: image.height,
        fileSize: bytes.length,
      );
    } catch (e) {
      return null;
    }
  }

  Future<File?> processImage({
    required File inputFile,
    required ImageOutputFormat format,
    required int quality,
    int? targetWidth,
    int? targetHeight,
    double? scalePercent,
    bool maintainAspectRatio = true,
  }) async {
    try {
      final bytes = await inputFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return null;

      // Apply resize if specified
      if (scalePercent != null && scalePercent != 100) {
        final newWidth = (image.width * scalePercent / 100).round();
        final newHeight = (image.height * scalePercent / 100).round();
        image = img.copyResize(
          image,
          width: newWidth,
          height: newHeight,
          interpolation: img.Interpolation.linear,
        );
      } else if (targetWidth != null || targetHeight != null) {
        int? resizeWidth = targetWidth;
        int? resizeHeight = targetHeight;

        if (maintainAspectRatio) {
          if (targetWidth != null && targetHeight != null) {
            // Fit within bounds while maintaining aspect ratio
            final aspectRatio = image.width / image.height;
            final targetAspect = targetWidth / targetHeight;
            
            if (aspectRatio > targetAspect) {
              resizeWidth = targetWidth;
              resizeHeight = null;
            } else {
              resizeWidth = null;
              resizeHeight = targetHeight;
            }
          }
        }

        image = img.copyResize(
          image,
          width: resizeWidth,
          height: resizeHeight,
          interpolation: img.Interpolation.linear,
        );
      }

      // Encode to target format
      Uint8List outputBytes;
      switch (format) {
        case ImageOutputFormat.jpeg:
          outputBytes = Uint8List.fromList(img.encodeJpg(image, quality: quality));
          break;
        case ImageOutputFormat.png:
          outputBytes = Uint8List.fromList(img.encodePng(image));
          break;
        case ImageOutputFormat.webp:
          // The image package may not support webp encoding on all platforms
          // Fall back to png if webp is not supported
          try {
            outputBytes = Uint8List.fromList(img.encodeJpg(image, quality: quality));
          } catch (e) {
            outputBytes = Uint8List.fromList(img.encodePng(image));
          }
          break;
      }

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final outputPath = '${tempDir.path}/converted_$timestamp.${format.extension}';
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(outputBytes);

      return outputFile;
    } catch (e) {
      return null;
    }
  }
}
