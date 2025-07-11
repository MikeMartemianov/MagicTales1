#!/bin/bash

echo "🧚‍♀️ Setting up Fairy Tales App..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first:"
    echo "   https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "✅ Flutter found"

# Get Flutter version
echo "📱 Flutter version:"
flutter --version

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Generate code
echo "🔧 Generating code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Check for issues
echo "🔍 Checking for issues..."
flutter analyze

echo ""
echo "🎉 Setup complete!"
echo ""
echo "To run the app:"
echo "  flutter run"
echo ""
echo "To run code generation in watch mode during development:"
echo "  flutter packages pub run build_runner watch"
echo ""
echo "Happy storytelling! ✨"