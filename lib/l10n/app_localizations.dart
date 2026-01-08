import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Image Converter'**
  String get appTitle;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @fileManager.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get fileManager;

  /// No description provided for @outputFormat.
  ///
  /// In en, this message translates to:
  /// **'Output Format'**
  String get outputFormat;

  /// No description provided for @quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get quality;

  /// No description provided for @qualityPercent.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String qualityPercent(int value);

  /// No description provided for @resize.
  ///
  /// In en, this message translates to:
  /// **'Resize'**
  String get resize;

  /// No description provided for @resizePresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get resizePresets;

  /// No description provided for @percentageScale.
  ///
  /// In en, this message translates to:
  /// **'Percentage Scale'**
  String get percentageScale;

  /// No description provided for @customSize.
  ///
  /// In en, this message translates to:
  /// **'Custom Size'**
  String get customSize;

  /// No description provided for @width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @maintainAspectRatio.
  ///
  /// In en, this message translates to:
  /// **'Maintain aspect ratio'**
  String get maintainAspectRatio;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save to Gallery'**
  String get save;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @originalImage.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get originalImage;

  /// No description provided for @convertedImage.
  ///
  /// In en, this message translates to:
  /// **'Converted'**
  String get convertedImage;

  /// No description provided for @dimensions.
  ///
  /// In en, this message translates to:
  /// **'{width} × {height}'**
  String dimensions(int width, int height);

  /// No description provided for @fileSize.
  ///
  /// In en, this message translates to:
  /// **'{size}'**
  String fileSize(String size);

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @converting.
  ///
  /// In en, this message translates to:
  /// **'Converting image...'**
  String get converting;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving to gallery...'**
  String get saving;

  /// No description provided for @successConverted.
  ///
  /// In en, this message translates to:
  /// **'Image converted successfully!'**
  String get successConverted;

  /// No description provided for @successSaved.
  ///
  /// In en, this message translates to:
  /// **'Image saved to gallery!'**
  String get successSaved;

  /// No description provided for @successShared.
  ///
  /// In en, this message translates to:
  /// **'Ready to share'**
  String get successShared;

  /// No description provided for @errorNoImage.
  ///
  /// In en, this message translates to:
  /// **'Please select an image first'**
  String get errorNoImage;

  /// No description provided for @errorConversion.
  ///
  /// In en, this message translates to:
  /// **'Failed to convert image'**
  String get errorConversion;

  /// No description provided for @errorSave.
  ///
  /// In en, this message translates to:
  /// **'Failed to save image'**
  String get errorSave;

  /// No description provided for @errorPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get errorPickImage;

  /// No description provided for @errorCameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required'**
  String get errorCameraPermission;

  /// No description provided for @errorStoragePermission.
  ///
  /// In en, this message translates to:
  /// **'Storage permission is required'**
  String get errorStoragePermission;

  /// No description provided for @hd.
  ///
  /// In en, this message translates to:
  /// **'HD'**
  String get hd;

  /// No description provided for @fullHd.
  ///
  /// In en, this message translates to:
  /// **'Full HD'**
  String get fullHd;

  /// No description provided for @uhd4k.
  ///
  /// In en, this message translates to:
  /// **'4K UHD'**
  String get uhd4k;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @twitter.
  ///
  /// In en, this message translates to:
  /// **'Twitter'**
  String get twitter;

  /// No description provided for @youtube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get youtube;

  /// No description provided for @webSmall.
  ///
  /// In en, this message translates to:
  /// **'Web Small'**
  String get webSmall;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @tapToSelectImage.
  ///
  /// In en, this message translates to:
  /// **'Tap a button above to select an image'**
  String get tapToSelectImage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
