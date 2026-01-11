.PHONY: help clean get analyze build-debug build-release install run icons test setup-hooks

# Default target
help:
	@echo "Image Converter - Available commands:"
	@echo ""
	@echo "  make get           - Get dependencies"
	@echo "  make analyze       - Run Flutter analyzer"
	@echo "  make test          - Run all tests"
	@echo "  make build-debug   - Build debug APK"
	@echo "  make build-release - Build release APK"
	@echo "  make build-aab     - Build release AAB (for Play Store)"
	@echo "  make install       - Install debug APK to connected device"
	@echo "  make run           - Run app on connected device"
	@echo "  make icons         - Generate app icons"
	@echo "  make setup-hooks   - Install git pre-commit hook"
	@echo "  make clean         - Clean build artifacts"
	@echo ""

# Get dependencies
get:
	flutter pub get

# Run analyzer
analyze:
	flutter analyze

# Run tests
test:
	flutter test

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

# Install git pre-commit hook
setup-hooks:
	cp scripts/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit
	@echo "✅ Pre-commit hook installed"

# Clean build artifacts
clean:
	flutter clean
	flutter pub get

