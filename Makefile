.PHONY: help clean get analyze build-debug build-release install run icons

# Default target
help:
	@echo "Image Converter - Available commands:"
	@echo ""
	@echo "  make get           - Get dependencies"
	@echo "  make analyze       - Run Flutter analyzer"
	@echo "  make build-debug   - Build debug APK"
	@echo "  make build-release - Build release APK"
	@echo "  make build-aab     - Build release AAB (for Play Store)"
	@echo "  make install       - Install debug APK to connected device"
	@echo "  make run           - Run app on connected device"
	@echo "  make icons         - Generate app icons"
	@echo "  make clean         - Clean build artifacts"
	@echo ""

# Get dependencies
get:
	flutter pub get

# Run analyzer
analyze:
	flutter analyze

# Build debug APK
build-debug:
	flutter build apk --debug

# Build release APK
build-release:
	flutter build apk --release

# Build release AAB for Play Store
build-aab:
	flutter build appbundle --release

# Install debug APK to device
install: build-debug
	adb install build/app/outputs/flutter-apk/app-debug.apk

# Run on connected device
run:
	flutter run

# Generate app icons
icons:
	dart run flutter_launcher_icons

# Clean build artifacts
clean:
	flutter clean
	flutter pub get
