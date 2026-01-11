import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:image_converter/models/image_format.dart';
import 'package:image_converter/widgets/format_selector.dart';
import 'package:image_converter/widgets/quality_slider.dart';
import 'package:image_converter/widgets/resize_presets.dart';
import 'package:image_converter/widgets/custom_size_input.dart';
import 'package:image_converter/widgets/action_buttons.dart';
import 'package:image_converter/widgets/image_preview.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('Golden Tests - Light Theme', () {
    testGoldens('FormatSelector - JPEG selected', (tester) async {
      await pumpGoldenApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (_) {},
        ),
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'format_selector_jpeg_light');
    });

    testGoldens('FormatSelector - PNG selected', (tester) async {
      await pumpGoldenApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.png,
          onFormatChanged: (_) {},
        ),
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'format_selector_png_light');
    });

    testGoldens('FormatSelector - WebP selected', (tester) async {
      await pumpGoldenApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.webp,
          onFormatChanged: (_) {},
        ),
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'format_selector_webp_light');
    });

    testGoldens('QualitySlider - enabled', (tester) async {
      await pumpGoldenApp(
        tester,
        QualitySlider(
          quality: 95,
          onQualityChanged: (_) {},
          enabled: true,
        ),
        screenSize: const Size(400, 170),
      );

      await screenMatchesGolden(tester, 'quality_slider_enabled_light');
    });

    testGoldens('QualitySlider - disabled', (tester) async {
      await pumpGoldenApp(
        tester,
        QualitySlider(
          quality: 95,
          onQualityChanged: (_) {},
          enabled: false,
        ),
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'quality_slider_disabled_light');
    });

    testGoldens('ResizePresets - no selection', (tester) async {
      await pumpGoldenApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (_) {},
        ),
        screenSize: const Size(400, 300),
      );

      await screenMatchesGolden(tester, 'resize_presets_none_light');
    });

    testGoldens('ResizePresets - Full HD selected', (tester) async {
      await pumpGoldenApp(
        tester,
        ResizePresets(
          selectedPresetId: 'fullHd',
          onPresetSelected: (_) {},
        ),
        screenSize: const Size(400, 300),
      );

      await screenMatchesGolden(tester, 'resize_presets_fullhd_light');
    });

    testGoldens('CustomSizeInput - empty', (tester) async {
      await pumpGoldenApp(
        tester,
        CustomSizeInput(
          width: null,
          height: null,
          scalePercent: null,
          maintainAspectRatio: true,
          originalWidth: 1920,
          originalHeight: 1080,
          onWidthChanged: (_) {},
          onHeightChanged: (_) {},
          onScaleChanged: (_) {},
          onAspectRatioChanged: (_) {},
        ),
        screenSize: const Size(400, 300),
      );

      await screenMatchesGolden(tester, 'custom_size_input_empty_light');
    });

    testGoldens('CustomSizeInput - with values', (tester) async {
      await pumpGoldenApp(
        tester,
        CustomSizeInput(
          width: 1920,
          height: 1080,
          scalePercent: null,
          maintainAspectRatio: true,
          originalWidth: 1920,
          originalHeight: 1080,
          onWidthChanged: (_) {},
          onHeightChanged: (_) {},
          onScaleChanged: (_) {},
          onAspectRatioChanged: (_) {},
        ),
        screenSize: const Size(400, 300),
      );

      await screenMatchesGolden(tester, 'custom_size_input_filled_light');
    });

    testGoldens('ActionButtons - disabled', (tester) async {
      await pumpGoldenApp(
        tester,
        ActionButtons(
          hasOriginalImage: false,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () {},
        ),
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'action_buttons_disabled_light');
    });

    testGoldens('ActionButtons - enabled', (tester) async {
      await pumpGoldenApp(
        tester,
        ActionButtons(
          hasOriginalImage: true,
          hasConvertedImage: true,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () {},
        ),
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'action_buttons_enabled_light');
    });

    // Skipped: ActionButtons processing state has CircularProgressIndicator
    // which causes infinite animation. golden_toolkit internally calls pumpAndSettle
    // in compareWithGolden which times out. The widget behavior is tested in
    // action_buttons_test.dart instead.

    testGoldens('ImagePreview - empty', (tester) async {
      await pumpGoldenApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
        screenSize: const Size(400, 300),
      );

      await screenMatchesGolden(tester, 'image_preview_empty_light');
    });

    testGoldens('ImagePreview - with info', (tester) async {
      await pumpGoldenApp(
        tester,
        ImagePreview(
          imageFile: null,
          imageInfo: createFakeImageInfo(),
          labelKey: 'original',
          isOriginal: true,
        ),
        screenSize: const Size(400, 320),
      );

      await screenMatchesGolden(tester, 'image_preview_info_light');
    });
  });

  group('Golden Tests - Dark Theme', () {
    testGoldens('FormatSelector - dark theme', (tester) async {
      await pumpGoldenApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (_) {},
        ),
        themeMode: ThemeMode.dark,
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'format_selector_dark');
    });

    testGoldens('QualitySlider - dark theme', (tester) async {
      await pumpGoldenApp(
        tester,
        QualitySlider(
          quality: 95,
          onQualityChanged: (_) {},
          enabled: true,
        ),
        themeMode: ThemeMode.dark,
        screenSize: const Size(400, 170),
      );

      await screenMatchesGolden(tester, 'quality_slider_dark');
    });

    testGoldens('ActionButtons - dark theme', (tester) async {
      await pumpGoldenApp(
        tester,
        ActionButtons(
          hasOriginalImage: true,
          hasConvertedImage: true,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () {},
        ),
        themeMode: ThemeMode.dark,
        screenSize: const Size(400, 200),
      );

      await screenMatchesGolden(tester, 'action_buttons_dark');
    });

    testGoldens('ImagePreview - dark theme', (tester) async {
      await pumpGoldenApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
        themeMode: ThemeMode.dark,
        screenSize: const Size(400, 300),
      );

      await screenMatchesGolden(tester, 'image_preview_dark');
    });
  });
}
