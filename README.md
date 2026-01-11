# Image Converter

Android app for converting and resizing images with format selection and quality control.

## Features

- **Format conversion**: JPEG, PNG, WebP
- **Quality control**: Adjust compression quality (10-100%)
- **Resize presets**: HD, Full HD, 4K, Instagram, Facebook, Twitter, YouTube, Web Small
- **Custom sizing**: Manual dimensions or percentage scale
- **Aspect ratio**: Maintain or override
- **Share/Save**: Export to gallery or share directly

## Tech Stack

- Flutter 3.32+
- Dart 3.9+
- Material 3 design

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Build release APK
flutter build apk --release

# Build release AAB (Play Store)
flutter build appbundle --release
```

## Testing

The project includes comprehensive Widget Tests and Golden Tests:

```bash
# Run all tests
flutter test

# Run widget tests only
flutter test test/widgets/

# Run golden tests only
flutter test test/golden/

# Update golden files after UI changes
flutter test --update-goldens
```

### Test Structure

| Directory | Description |
|-----------|-------------|
| `test/widgets/` | Widget behavior tests (60 tests) |
| `test/golden/` | UI screenshot tests (17 goldens) |
| `test/helpers/` | Test utilities and mocks |

### CI/CD

**Pre-commit hook** runs tests automatically before each commit:

```bash
# Install the hook (one-time setup)
make setup-hooks
```

GitHub Actions also runs tests on push/PR. See `.github/workflows/flutter_test.yml`.

## Localization

Supports English and Japanese. Language files are in `lib/l10n/`.

## License

MIT
