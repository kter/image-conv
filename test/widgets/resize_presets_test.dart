import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_converter/models/resize_preset.dart';
import 'package:image_converter/widgets/resize_presets.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ResizePresets Widget Tests', () {
    testWidgets('displays all 8 resize presets', (tester) async {
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (_) {},
        ),
      );

      // Check all localized preset labels
      expect(find.text('HD'), findsOneWidget);
      expect(find.text('Full HD'), findsOneWidget);
      expect(find.text('4K UHD'), findsOneWidget);
      expect(find.text('Instagram'), findsOneWidget);
      expect(find.text('Facebook'), findsOneWidget);
      expect(find.text('Twitter'), findsOneWidget);
      expect(find.text('YouTube'), findsOneWidget);
      expect(find.text('Web Small'), findsOneWidget);
    });

    testWidgets('displays "Presets" title label', (tester) async {
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (_) {},
        ),
      );

      expect(find.text('Presets'), findsOneWidget);
    });

    testWidgets('displays dimension text for each preset', (tester) async {
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (_) {},
        ),
      );

      // Check dimension text for some presets
      expect(find.text('1280×720'), findsWidgets); // HD and YouTube share this
      expect(find.text('1920×1080'), findsOneWidget); // Full HD
      expect(find.text('3840×2160'), findsOneWidget); // 4K
      expect(find.text('1080×1080'), findsOneWidget); // Instagram
    });

    testWidgets('emits preset when tapped', (tester) async {
      ResizePreset? selectedPreset;
      
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (preset) => selectedPreset = preset,
        ),
      );

      await tester.tap(find.text('Full HD'));
      await tester.pumpAndSettle();

      expect(selectedPreset, isNotNull);
      expect(selectedPreset!.id, equals('fullHd'));
      expect(selectedPreset!.width, equals(1920));
      expect(selectedPreset!.height, equals(1080));
    });

    testWidgets('emits Instagram preset with correct dimensions', (tester) async {
      ResizePreset? selectedPreset;
      
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (preset) => selectedPreset = preset,
        ),
      );

      await tester.tap(find.text('Instagram'));
      await tester.pumpAndSettle();

      expect(selectedPreset!.width, equals(1080));
      expect(selectedPreset!.height, equals(1080));
    });

    testWidgets('is wrapped in a Card widget', (tester) async {
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (_) {},
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('uses FilterChip widgets for presets', (tester) async {
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: null,
          onPresetSelected: (_) {},
        ),
      );

      // Should have 8 FilterChip widgets (one per preset)
      expect(find.byType(FilterChip), findsNWidgets(8));
    });

    testWidgets('shows selected state for selected preset', (tester) async {
      await pumpApp(
        tester,
        ResizePresets(
          selectedPresetId: 'fullHd',
          onPresetSelected: (_) {},
        ),
      );

      // Find the selected FilterChip
      final filterChips = tester.widgetList<FilterChip>(find.byType(FilterChip));
      
      // At least one should be selected
      expect(filterChips.any((chip) => chip.selected), isTrue);
    });
  });
}
