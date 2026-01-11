import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:image_converter/l10n/app_localizations.dart';
import 'package:image_converter/theme/app_theme.dart';
import 'package:image_converter/services/image_picker_service.dart';
import 'package:image_converter/services/image_processor_service.dart';

// Mock classes
class MockImagePickerService extends Mock implements ImagePickerService {}
class MockImageProcessorService extends Mock implements ImageProcessorService {}
class MockFile extends Mock implements File {}

/// Creates a fake [ConvertedImageInfo] for testing purposes.
ConvertedImageInfo createFakeImageInfo({
  int width = 1920,
  int height = 1080,
  int fileSize = 1536000, // 1.5 MB
}) {
  return ConvertedImageInfo(
    width: width,
    height: height,
    fileSize: fileSize,
  );
}

/// Pumps a widget with MaterialApp and localization support.
/// 
/// This helper ensures widgets are tested with proper localization
/// and theming context, matching the production environment.
Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  ThemeMode themeMode = ThemeMode.light,
  Locale locale = const Locale('en'),
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
  await tester.pumpAndSettle();
}

/// Pumps a full-screen widget for golden tests.
/// 
/// Set [skipPumpAndSettle] to true for widgets with infinite animations
/// (e.g., CircularProgressIndicator) to avoid timeout.
Future<void> pumpGoldenApp(
  WidgetTester tester,
  Widget child, {
  ThemeMode themeMode = ThemeMode.light,
  Locale locale = const Locale('en'),
  Size screenSize = const Size(400, 800),
  bool skipPumpAndSettle = false,
}) async {
  tester.view.physicalSize = screenSize;
  tester.view.devicePixelRatio = 1.0;
  
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      home: Scaffold(body: child),
    ),
  );
  
  if (skipPumpAndSettle) {
    await tester.pump(const Duration(milliseconds: 100));
  } else {
    await tester.pumpAndSettle();
  }
  
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
