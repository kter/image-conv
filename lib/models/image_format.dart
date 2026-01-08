enum ImageOutputFormat {
  jpeg,
  png,
  webp;

  String get extension {
    switch (this) {
      case ImageOutputFormat.jpeg:
        return 'jpg';
      case ImageOutputFormat.png:
        return 'png';
      case ImageOutputFormat.webp:
        return 'webp';
    }
  }

  String get mimeType {
    switch (this) {
      case ImageOutputFormat.jpeg:
        return 'image/jpeg';
      case ImageOutputFormat.png:
        return 'image/png';
      case ImageOutputFormat.webp:
        return 'image/webp';
    }
  }

  String get displayName {
    switch (this) {
      case ImageOutputFormat.jpeg:
        return 'JPEG';
      case ImageOutputFormat.png:
        return 'PNG';
      case ImageOutputFormat.webp:
        return 'WebP';
    }
  }

  bool get supportsQuality {
    switch (this) {
      case ImageOutputFormat.jpeg:
      case ImageOutputFormat.webp:
        return true;
      case ImageOutputFormat.png:
        return false;
    }
  }
}
