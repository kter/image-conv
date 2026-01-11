import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_converter/models/image_format.dart';
import 'package:image_converter/widgets/format_selector.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('FormatSelector Widget Tests', () {
    testWidgets('renders all format options (JPEG, PNG, WebP)', (tester) async {
      ImageOutputFormat? selectedFormat;
      
      await pumpApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (format) => selectedFormat = format,
        ),
      );

      // All three format options should be visible
      expect(find.text('JPEG'), findsOneWidget);
      expect(find.text('PNG'), findsOneWidget);
      expect(find.text('WebP'), findsOneWidget);
    });

    testWidgets('shows "Output Format" title label', (tester) async {
      await pumpApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (_) {},
        ),
      );

      expect(find.text('Output Format'), findsOneWidget);
    });

    testWidgets('emits JPEG format when JPEG is tapped', (tester) async {
      ImageOutputFormat? selectedFormat;
      
      await pumpApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.png,
          onFormatChanged: (format) => selectedFormat = format,
        ),
      );

      await tester.tap(find.text('JPEG'));
      await tester.pumpAndSettle();

      expect(selectedFormat, equals(ImageOutputFormat.jpeg));
    });

    testWidgets('emits PNG format when PNG is tapped', (tester) async {
      ImageOutputFormat? selectedFormat;
      
      await pumpApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (format) => selectedFormat = format,
        ),
      );

      await tester.tap(find.text('PNG'));
      await tester.pumpAndSettle();

      expect(selectedFormat, equals(ImageOutputFormat.png));
    });

    testWidgets('emits WebP format when WebP is tapped', (tester) async {
      ImageOutputFormat? selectedFormat;
      
      await pumpApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (format) => selectedFormat = format,
        ),
      );

      await tester.tap(find.text('WebP'));
      await tester.pumpAndSettle();

      expect(selectedFormat, equals(ImageOutputFormat.webp));
    });

    testWidgets('is wrapped in a Card widget', (tester) async {
      await pumpApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (_) {},
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('uses SegmentedButton for format selection', (tester) async {
      await pumpApp(
        tester,
        FormatSelector(
          selectedFormat: ImageOutputFormat.jpeg,
          onFormatChanged: (_) {},
        ),
      );

      expect(find.byType(SegmentedButton<ImageOutputFormat>), findsOneWidget);
    });
  });
}
