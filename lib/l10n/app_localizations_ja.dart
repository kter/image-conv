// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '画像コンバーター';

  @override
  String get selectImage => '画像を選択';

  @override
  String get gallery => 'ギャラリー';

  @override
  String get camera => 'カメラ';

  @override
  String get fileManager => 'ファイル';

  @override
  String get outputFormat => '出力形式';

  @override
  String get quality => '品質';

  @override
  String qualityPercent(int value) {
    return '$value%';
  }

  @override
  String get resize => 'リサイズ';

  @override
  String get resizePresets => 'プリセット';

  @override
  String get percentageScale => 'パーセンテージ';

  @override
  String get customSize => 'カスタムサイズ';

  @override
  String get width => '幅';

  @override
  String get height => '高さ';

  @override
  String get maintainAspectRatio => 'アスペクト比を維持';

  @override
  String get apply => '適用';

  @override
  String get convert => '変換';

  @override
  String get save => 'ギャラリーに保存';

  @override
  String get share => '共有';

  @override
  String get originalImage => 'オリジナル';

  @override
  String get convertedImage => '変換後';

  @override
  String dimensions(int width, int height) {
    return '$width × $height';
  }

  @override
  String fileSize(String size) {
    return '$size';
  }

  @override
  String get processing => '処理中...';

  @override
  String get converting => '画像を変換中...';

  @override
  String get saving => 'ギャラリーに保存中...';

  @override
  String get successConverted => '画像の変換が完了しました！';

  @override
  String get successSaved => 'ギャラリーに保存しました！';

  @override
  String get successShared => '共有の準備ができました';

  @override
  String get errorNoImage => '画像を選択してください';

  @override
  String get errorConversion => '画像の変換に失敗しました';

  @override
  String get errorSave => '画像の保存に失敗しました';

  @override
  String get errorPickImage => '画像の選択に失敗しました';

  @override
  String get errorCameraPermission => 'カメラの許可が必要です';

  @override
  String get errorStoragePermission => 'ストレージの許可が必要です';

  @override
  String get hd => 'HD';

  @override
  String get fullHd => 'フルHD';

  @override
  String get uhd4k => '4K UHD';

  @override
  String get instagram => 'Instagram';

  @override
  String get facebook => 'Facebook';

  @override
  String get twitter => 'Twitter';

  @override
  String get youtube => 'YouTube';

  @override
  String get webSmall => 'Web小';

  @override
  String get noImageSelected => '画像が選択されていません';

  @override
  String get tapToSelectImage => '上のボタンをタップして画像を選択してください';
}
