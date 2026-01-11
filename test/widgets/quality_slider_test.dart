import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_converter/widgets/quality_slider.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('QualitySlider Widget Tests', () {
    testWidgets('displays current quality value as percentage', (tester) async {
      await pumpApp(
        tester,
        QualitySlider(
          quality: 95,
          onQualityChanged: (_) {},
          enabled: true,
        ),
      );

      expect(find.text('95%'), findsOneWidget);
    });

    testWidgets('displays "Quality" title label', (tester) async {
      await pumpApp(
        tester,
        QualitySlider(
          quality: 80,
          onQualityChanged: (_) {},
          enabled: true,
        ),
      );

      expect(find.text('Quality'), findsOneWidget);
    });

    testWidgets('contains a Slider widget', (tester) async {
      await pumpApp(
        tester,
        QualitySlider(
          quality: 50,
          onQualityChanged: (_) {},
          enabled: true,
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('slider emits new value when dragged', (tester) async {
      int? newQuality;
      
      await pumpApp(
        tester,
        QualitySlider(
          quality: 50,
          onQualityChanged: (value) => newQuality = value,
          enabled: true,
        ),
      );

      // Find the slider and drag it
      final slider = find.byType(Slider);
      expect(slider, findsOneWidget);
      
      // Drag towards the end (higher quality)
      await tester.drag(slider, const Offset(100, 0));
      await tester.pumpAndSettle();

      // Quality should have changed
      expect(newQuality, isNotNull);
    });

    testWidgets('slider is disabled when enabled is false', (tester) async {
      int? newQuality;
      
      await pumpApp(
        tester,
        QualitySlider(
          quality: 50,
          onQualityChanged: (value) => newQuality = value,
          enabled: false,
        ),
      );

      final slider = find.byType(Slider);
      
      // Try to drag disabled slider
      await tester.drag(slider, const Offset(100, 0));
      await tester.pumpAndSettle();

      // No callback should have been invoked
      expect(newQuality, isNull);
    });

    testWidgets('shows PNG quality message when disabled', (tester) async {
      await pumpApp(
        tester,
        QualitySlider(
          quality: 95,
          onQualityChanged: (_) {},
          enabled: false,
        ),
      );

      expect(
        find.text('PNG format does not support quality adjustment'),
        findsOneWidget,
      );
    });

    testWidgets('does not show PNG message when enabled', (tester) async {
      await pumpApp(
        tester,
        QualitySlider(
          quality: 95,
          onQualityChanged: (_) {},
          enabled: true,
        ),
      );

      expect(
        find.text('PNG format does not support quality adjustment'),
        findsNothing,
      );
    });

    testWidgets('is wrapped in a Card widget', (tester) async {
      await pumpApp(
        tester,
        QualitySlider(
          quality: 80,
          onQualityChanged: (_) {},
          enabled: true,
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('displays different quality percentages correctly', (tester) async {
      for (final quality in [10, 50, 100]) {
        await pumpApp(
          tester,
          QualitySlider(
            quality: quality,
            onQualityChanged: (_) {},
            enabled: true,
          ),
        );

        expect(find.text('$quality%'), findsOneWidget);
      }
    });
  });
}
