// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Image Converter';

  @override
  String get selectImage => 'Select Image';

  @override
  String get gallery => 'Gallery';

  @override
  String get camera => 'Camera';

  @override
  String get fileManager => 'Files';

  @override
  String get outputFormat => 'Output Format';

  @override
  String get quality => 'Quality';

  @override
  String qualityPercent(int value) {
    return '$value%';
  }

  @override
  String get resize => 'Resize';

  @override
  String get resizePresets => 'Presets';

  @override
  String get percentageScale => 'Percentage Scale';

  @override
  String get customSize => 'Custom Size';

  @override
  String get width => 'Width';

  @override
  String get height => 'Height';

  @override
  String get maintainAspectRatio => 'Maintain aspect ratio';

  @override
  String get apply => 'Apply';

  @override
  String get convert => 'Convert';

  @override
  String get save => 'Save to Gallery';

  @override
  String get share => 'Share';

  @override
  String get originalImage => 'Original';

  @override
  String get convertedImage => 'Converted';

  @override
  String dimensions(int width, int height) {
    return '$width × $height';
  }

  @override
  String fileSize(String size) {
    return '$size';
  }

  @override
  String get processing => 'Processing...';

  @override
  String get converting => 'Converting image...';

  @override
  String get saving => 'Saving to gallery...';

  @override
  String get successConverted => 'Image converted successfully!';

  @override
  String get successSaved => 'Image saved to gallery!';

  @override
  String get successShared => 'Ready to share';

  @override
  String get errorNoImage => 'Please select an image first';

  @override
  String get errorConversion => 'Failed to convert image';

  @override
  String get errorSave => 'Failed to save image';

  @override
  String get errorPickImage => 'Failed to pick image';

  @override
  String get errorCameraPermission => 'Camera permission is required';

  @override
  String get errorStoragePermission => 'Storage permission is required';

  @override
  String get hd => 'HD';

  @override
  String get fullHd => 'Full HD';

  @override
  String get uhd4k => '4K UHD';

  @override
  String get instagram => 'Instagram';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get youtube => 'YouTube';

  @override
  String get webSmall => 'Web Small';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get tapToSelectImage => 'Tap a button above to select an image';
}
