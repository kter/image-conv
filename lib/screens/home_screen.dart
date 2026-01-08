import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_converter/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';
import '../models/image_format.dart';
import '../services/image_picker_service.dart';
import '../services/image_processor_service.dart';
import '../widgets/image_preview.dart';
import '../widgets/format_selector.dart';
import '../widgets/quality_slider.dart';
import '../widgets/resize_presets.dart';
import '../widgets/custom_size_input.dart';
import '../widgets/action_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePickerService _pickerService = ImagePickerService();
  final ImageProcessorService _processorService = ImageProcessorService();

  File? _originalImage;
  File? _convertedImage;
  ConvertedImageInfo? _originalImageInfo;
  ConvertedImageInfo? _convertedImageInfo;

  ImageOutputFormat _selectedFormat = ImageOutputFormat.jpeg;
  int _quality = 80;
  String? _selectedPresetId;
  int? _targetWidth;
  int? _targetHeight;
  double? _scalePercent;
  bool _maintainAspectRatio = true;

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image source buttons
            _buildImageSourceButtons(context, l10n, colorScheme),
            
            const SizedBox(height: 16),
            
            // Original image preview
            ImagePreview(
              imageFile: _originalImage,
              imageInfo: _originalImageInfo,
              labelKey: 'original',
              isOriginal: true,
            ),
            
            const SizedBox(height: 16),
            
            // Format selector
            FormatSelector(
              selectedFormat: _selectedFormat,
              onFormatChanged: (format) {
                setState(() {
                  _selectedFormat = format;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Quality slider
            QualitySlider(
              quality: _quality,
              onQualityChanged: (quality) {
                setState(() {
                  _quality = quality;
                });
              },
              enabled: _selectedFormat.supportsQuality,
            ),
            
            const SizedBox(height: 16),
            
            // Resize presets
            ResizePresets(
              selectedPresetId: _selectedPresetId,
              onPresetSelected: (preset) {
                setState(() {
                  _selectedPresetId = preset.id;
                  _targetWidth = preset.width;
                  _targetHeight = preset.height;
                  _scalePercent = null;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Custom size input
            CustomSizeInput(
              width: _targetWidth,
              height: _targetHeight,
              scalePercent: _scalePercent,
              maintainAspectRatio: _maintainAspectRatio,
              originalWidth: _originalImageInfo?.width,
              originalHeight: _originalImageInfo?.height,
              onWidthChanged: (width) {
                setState(() {
                  _targetWidth = width;
                  _selectedPresetId = null;
                  _scalePercent = null;
                });
              },
              onHeightChanged: (height) {
                setState(() {
                  _targetHeight = height;
                  _selectedPresetId = null;
                  _scalePercent = null;
                });
              },
              onScaleChanged: (scale) {
                setState(() {
                  _scalePercent = scale;
                  _selectedPresetId = null;
                  // scalePercentを使用する場合はtargetWidth/targetHeightをnullにする
                  // image_processor_serviceでscalePercentの処理が正しく使われるようにする
                  _targetWidth = null;
                  _targetHeight = null;
                });
              },
              onAspectRatioChanged: (value) {
                setState(() {
                  _maintainAspectRatio = value;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            ActionButtons(
              hasOriginalImage: _originalImage != null,
              hasConvertedImage: _convertedImage != null,
              isProcessing: _isProcessing,
              onConvert: _handleConvert,
              onSave: _handleSave,
              onShare: _handleShare,
            ),
            
            const SizedBox(height: 16),
            
            // Converted image preview
            if (_convertedImage != null)
              ImagePreview(
                imageFile: _convertedImage,
                imageInfo: _convertedImageInfo,
                labelKey: 'converted',
                isOriginal: false,
              ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceButtons(BuildContext context, AppLocalizations l10n, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.selectImage,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSourceButton(
                    onPressed: () => _pickImage(ImageSourceType.gallery),
                    icon: Icons.photo_library,
                    label: l10n.gallery,
                    colorScheme: colorScheme,
                    type: _ButtonType.filled,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSourceButton(
                    onPressed: () => _pickImage(ImageSourceType.camera),
                    icon: Icons.camera_alt,
                    label: l10n.camera,
                    colorScheme: colorScheme,
                    type: _ButtonType.tonal,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSourceButton(
                    onPressed: () => _pickImage(ImageSourceType.files),
                    icon: Icons.folder_open,
                    label: l10n.fileManager,
                    colorScheme: colorScheme,
                    type: _ButtonType.outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required ColorScheme colorScheme,
    required _ButtonType type,
  }) {
    Color backgroundColor;
    Color foregroundColor;
    Border? border;

    switch (type) {
      case _ButtonType.filled:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        break;
      case _ButtonType.tonal:
        backgroundColor = colorScheme.secondaryContainer;
        foregroundColor = colorScheme.onSecondaryContainer;
        break;
      case _ButtonType.outlined:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        border = Border.all(color: colorScheme.outline);
        break;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: border,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: foregroundColor, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSourceType type) async {
    final l10n = AppLocalizations.of(context)!;
    
    try {
      File? image;
      switch (type) {
        case ImageSourceType.gallery:
          image = await _pickerService.pickFromGallery();
          break;
        case ImageSourceType.camera:
          image = await _pickerService.pickFromCamera();
          break;
        case ImageSourceType.files:
          image = await _pickerService.pickFromFiles();
          break;
      }

      if (image != null) {
        final info = await _processorService.getImageInfo(image);
        setState(() {
          _originalImage = image;
          _originalImageInfo = info;
          _convertedImage = null;
          _convertedImageInfo = null;
          _selectedPresetId = null;
          _targetWidth = null;
          _targetHeight = null;
          _scalePercent = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorPickImage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _handleConvert() async {
    if (_originalImage == null) return;

    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isProcessing = true;
    });

    try {
      final convertedFile = await _processorService.processImage(
        inputFile: _originalImage!,
        format: _selectedFormat,
        quality: _quality,
        targetWidth: _targetWidth,
        targetHeight: _targetHeight,
        scalePercent: _scalePercent,
        maintainAspectRatio: _maintainAspectRatio,
      );

      if (convertedFile != null) {
        final info = await _processorService.getImageInfo(convertedFile);
        setState(() {
          _convertedImage = convertedFile;
          _convertedImageInfo = info;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.successConverted),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Conversion failed');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorConversion),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _handleSave() async {
    if (_convertedImage == null) return;

    final l10n = AppLocalizations.of(context)!;

    try {
      await Gal.putImage(_convertedImage!.path);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.successSaved),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorSave),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _handleShare() async {
    if (_convertedImage == null) return;

    try {
      await Share.shareXFiles(
        [XFile(_convertedImage!.path)],
      );
    } catch (e) {
      // Share cancelled or failed silently
    }
  }
}

enum ImageSourceType { gallery, camera, files }

enum _ButtonType { filled, tonal, outlined }
