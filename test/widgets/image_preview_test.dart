import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_converter/widgets/image_preview.dart';
import 'package:image_converter/services/image_processor_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ImagePreview Widget Tests', () {
    testWidgets('shows "Original" label for original image', (tester) async {
      await pumpApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      expect(find.text('Original'), findsOneWidget);
    });

    testWidgets('shows "Converted" label for converted image', (tester) async {
      await pumpApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'converted',
          isOriginal: false,
        ),
      );

      expect(find.text('Converted'), findsOneWidget);
    });

    testWidgets('shows "No image selected" when imageFile is null', (tester) async {
      await pumpApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      expect(find.text('No image selected'), findsOneWidget);
    });

    testWidgets('shows dimension text when imageInfo is provided', (tester) async {
      final imageInfo = createFakeImageInfo(width: 1920, height: 1080);
      
      await pumpApp(
        tester,
        ImagePreview(
          imageFile: null,
          imageInfo: imageInfo,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      // Check dimensions are displayed
      expect(find.text('1920 × 1080'), findsOneWidget);
    });

    testWidgets('shows file size when imageInfo is provided', (tester) async {
      final imageInfo = createFakeImageInfo(fileSize: 1536000); // 1.5 MB
      
      await pumpApp(
        tester,
        ImagePreview(
          imageFile: null,
          imageInfo: imageInfo,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      // Check file size is displayed (format: "X.XX MB")
      expect(find.textContaining('MB'), findsOneWidget);
    });

    testWidgets('shows KB for smaller file sizes', (tester) async {
      final imageInfo = createFakeImageInfo(fileSize: 512000); // 500 KB
      
      await pumpApp(
        tester,
        ImagePreview(
          imageFile: null,
          imageInfo: imageInfo,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      expect(find.textContaining('KB'), findsOneWidget);
    });

    testWidgets('displays different icon for original vs converted', (tester) async {
      await pumpApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      // Original uses Icons.image
      expect(find.byIcon(Icons.image), findsWidgets);
    });

    testWidgets('is wrapped in a Card widget', (tester) async {
      await pumpApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('has AspectRatio of 16:9', (tester) async {
      await pumpApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      final aspectRatio = tester.widget<AspectRatio>(find.byType(AspectRatio));
      expect(aspectRatio.aspectRatio, equals(16 / 9));
    });

    testWidgets('displays placeholder icon when no image', (tester) async {
      await pumpApp(
        tester,
        const ImagePreview(
          imageFile: null,
          imageInfo: null,
          labelKey: 'original',
          isOriginal: true,
        ),
      );

      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    });
  });
}
