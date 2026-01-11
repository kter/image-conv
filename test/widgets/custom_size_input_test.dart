import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_converter/widgets/custom_size_input.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CustomSizeInput Widget Tests', () {
    testWidgets('displays "Custom Size" title label', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('Custom Size'), findsOneWidget);
    });

    testWidgets('displays width input field with "Width" label', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('Width'), findsOneWidget);
    });

    testWidgets('displays height input field with "Height" label', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('Height'), findsOneWidget);
    });

    testWidgets('displays percentage scale input field', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('Percentage Scale'), findsOneWidget);
    });

    testWidgets('displays Apply button for scale', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('Apply'), findsOneWidget);
    });

    testWidgets('displays "Maintain aspect ratio" checkbox', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('Maintain aspect ratio'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('checkbox is checked when maintainAspectRatio is true', (tester) async {
      await pumpApp(
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
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);
    });

    testWidgets('checkbox is unchecked when maintainAspectRatio is false', (tester) async {
      await pumpApp(
        tester,
        CustomSizeInput(
          width: null,
          height: null,
          scalePercent: null,
          maintainAspectRatio: false,
          originalWidth: 1920,
          originalHeight: 1080,
          onWidthChanged: (_) {},
          onHeightChanged: (_) {},
          onScaleChanged: (_) {},
          onAspectRatioChanged: (_) {},
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('emits width change when width field is edited', (tester) async {
      int? newWidth;
      
      await pumpApp(
        tester,
        CustomSizeInput(
          width: 1920,
          height: 1080,
          scalePercent: null,
          maintainAspectRatio: false,
          originalWidth: 1920,
          originalHeight: 1080,
          onWidthChanged: (w) => newWidth = w,
          onHeightChanged: (_) {},
          onScaleChanged: (_) {},
          onAspectRatioChanged: (_) {},
        ),
      );

      // Find width TextField and enter text
      final widthField = find.widgetWithText(TextField, 'Width');
      await tester.enterText(widthField, '1280');
      await tester.pumpAndSettle();

      expect(newWidth, equals(1280));
    });

    testWidgets('emits aspect ratio change when checkbox is tapped', (tester) async {
      bool? aspectRatioValue;
      
      await pumpApp(
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
          onAspectRatioChanged: (v) => aspectRatioValue = v,
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(aspectRatioValue, isFalse);
    });

    testWidgets('is wrapped in a Card widget', (tester) async {
      await pumpApp(
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
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('displays initial width value in text field', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('1920'), findsOneWidget);
    });

    testWidgets('displays initial height value in text field', (tester) async {
      await pumpApp(
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
      );

      expect(find.text('1080'), findsOneWidget);
    });
  });
}
