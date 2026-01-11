import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_converter/l10n/app_localizations.dart';
import 'package:image_converter/widgets/action_buttons.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ActionButtons Widget Tests', () {
    testWidgets('displays Convert button', (tester) async {
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: false,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () {},
        ),
      );

      expect(find.text('Convert'), findsOneWidget);
    });

    testWidgets('displays Save to Gallery button', (tester) async {
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: false,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () {},
        ),
      );

      expect(find.text('Save to Gallery'), findsOneWidget);
    });

    testWidgets('displays Share button', (tester) async {
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: false,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () {},
        ),
      );

      expect(find.text('Share'), findsOneWidget);
    });

    testWidgets('Convert button is disabled when no original image', (tester) async {
      bool convertCalled = false;
      
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: false,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () => convertCalled = true,
          onSave: () {},
          onShare: () {},
        ),
      );

      await tester.tap(find.text('Convert'));
      await tester.pumpAndSettle();

      expect(convertCalled, isFalse);
    });

    testWidgets('Convert button is enabled when image is selected', (tester) async {
      bool convertCalled = false;
      
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: true,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () => convertCalled = true,
          onSave: () {},
          onShare: () {},
        ),
      );

      await tester.tap(find.text('Convert'));
      await tester.pumpAndSettle();

      expect(convertCalled, isTrue);
    });

    testWidgets('Save button is disabled when no converted image', (tester) async {
      bool saveCalled = false;
      
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: true,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () {},
          onSave: () => saveCalled = true,
          onShare: () {},
        ),
      );

      await tester.tap(find.text('Save to Gallery'));
      await tester.pumpAndSettle();

      expect(saveCalled, isFalse);
    });

    testWidgets('Save button is enabled when converted image exists', (tester) async {
      bool saveCalled = false;
      
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: true,
          hasConvertedImage: true,
          isProcessing: false,
          onConvert: () {},
          onSave: () => saveCalled = true,
          onShare: () {},
        ),
      );

      await tester.tap(find.text('Save to Gallery'));
      await tester.pumpAndSettle();

      expect(saveCalled, isTrue);
    });

    testWidgets('Share button is disabled when no converted image', (tester) async {
      bool shareCalled = false;
      
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: true,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () => shareCalled = true,
        ),
      );

      await tester.tap(find.text('Share'));
      await tester.pumpAndSettle();

      expect(shareCalled, isFalse);
    });

    testWidgets('Share button is enabled when converted image exists', (tester) async {
      bool shareCalled = false;
      
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: true,
          hasConvertedImage: true,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () => shareCalled = true,
        ),
      );

      await tester.tap(find.text('Share'));
      await tester.pumpAndSettle();

      expect(shareCalled, isTrue);
    });

    testWidgets('shows CircularProgressIndicator when processing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          home: Scaffold(
            body: ActionButtons(
              hasOriginalImage: true,
              hasConvertedImage: false,
              isProcessing: true,
              onConvert: () {},
              onSave: () {},
              onShare: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows "Converting image..." text when processing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          home: Scaffold(
            body: ActionButtons(
              hasOriginalImage: true,
              hasConvertedImage: false,
              isProcessing: true,
              onConvert: () {},
              onSave: () {},
              onShare: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Converting image...'), findsOneWidget);
    });

    testWidgets('Convert is disabled during processing', (tester) async {
      bool convertCalled = false;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          home: Scaffold(
            body: ActionButtons(
              hasOriginalImage: true,
              hasConvertedImage: false,
              isProcessing: true,
              onConvert: () => convertCalled = true,
              onSave: () {},
              onShare: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Converting image...'));
      await tester.pump();

      expect(convertCalled, isFalse);
    });

    testWidgets('is wrapped in a Card widget', (tester) async {
      await pumpApp(
        tester,
        ActionButtons(
          hasOriginalImage: false,
          hasConvertedImage: false,
          isProcessing: false,
          onConvert: () {},
          onSave: () {},
          onShare: () {},
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });
  });
}
