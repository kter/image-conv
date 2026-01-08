class ResizePreset {
  final String id;
  final String labelKey;
  final int width;
  final int height;

  const ResizePreset({
    required this.id,
    required this.labelKey,
    required this.width,
    required this.height,
  });

  String get displaySize => '$width×$height';

  static const List<ResizePreset> presets = [
    ResizePreset(id: 'hd', labelKey: 'hd', width: 1280, height: 720),
    ResizePreset(id: 'fullHd', labelKey: 'fullHd', width: 1920, height: 1080),
    ResizePreset(id: '4k', labelKey: 'uhd4k', width: 3840, height: 2160),
    ResizePreset(id: 'instagram', labelKey: 'instagram', width: 1080, height: 1080),
    ResizePreset(id: 'facebook', labelKey: 'facebook', width: 1200, height: 630),
    ResizePreset(id: 'twitter', labelKey: 'twitter', width: 1024, height: 512),
    ResizePreset(id: 'youtube', labelKey: 'youtube', width: 1280, height: 720),
    ResizePreset(id: 'webSmall', labelKey: 'webSmall', width: 800, height: 600),
  ];
}
