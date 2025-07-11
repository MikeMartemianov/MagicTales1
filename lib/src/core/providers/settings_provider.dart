import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_profile.dart';
import '../services/storage_service.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  UserSettings build() {
    _loadSettings();
    return const UserSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final profile = await StorageService.getCurrentUserProfile();
      if (profile != null) {
        state = profile.settings;
      } else {
        // Load default settings or saved settings for guest user
        final language = await StorageService.getSetting<String>('language') ?? 'en';
        final themeMode = await _getThemeMode() ?? ThemeMode.system;
        final fontFamily = await StorageService.getSetting<String>('fontFamily') ?? 'FairyTale';
        final textScale = await StorageService.getSetting<double>('textScale') ?? 1.0;
        final musicVolume = await StorageService.getSetting<double>('musicVolume') ?? 0.7;
        final effectsVolume = await StorageService.getSetting<double>('effectsVolume') ?? 0.8;
        final narrationVolume = await StorageService.getSetting<double>('narrationVolume') ?? 0.9;
        final enableAnimations = await StorageService.getSetting<bool>('enableAnimations') ?? true;
        final enableVibration = await StorageService.getSetting<bool>('enableVibration') ?? true;
        final enableNarration = await StorageService.getSetting<bool>('enableNarration') ?? true;
        final showTextDuringNarration = await StorageService.getSetting<bool>('showTextDuringNarration') ?? true;
        final preferredVoiceId = await StorageService.getSetting<String>('preferredVoiceId') ?? '';
        final voiceSpeed = await StorageService.getSetting<double>('voiceSpeed') ?? 1.0;
        final enableAI = await StorageService.getSetting<bool>('enableAI') ?? true;
        final enableOnlineFeatures = await StorageService.getSetting<bool>('enableOnlineFeatures') ?? true;
        final interfaceMode = await _getInterfaceMode() ?? InterfaceMode.child;
        final primaryColor = await _getPrimaryColor() ?? Colors.purple;
        final accentColor = await _getAccentColor() ?? Colors.pink;
        final buttonStyle = await _getButtonStyle() ?? ButtonStyle.rounded;

        state = UserSettings(
          language: language,
          themeMode: themeMode,
          fontFamily: fontFamily,
          textScale: textScale,
          musicVolume: musicVolume,
          effectsVolume: effectsVolume,
          narrationVolume: narrationVolume,
          enableAnimations: enableAnimations,
          enableVibration: enableVibration,
          enableNarration: enableNarration,
          showTextDuringNarration: showTextDuringNarration,
          preferredVoiceId: preferredVoiceId,
          voiceSpeed: voiceSpeed,
          enableAI: enableAI,
          enableOnlineFeatures: enableOnlineFeatures,
          interfaceMode: interfaceMode,
          primaryColor: primaryColor,
          accentColor: accentColor,
          buttonStyle: buttonStyle,
        );
      }
    } catch (e) {
      // If loading fails, use default settings
      state = const UserSettings();
    }
  }

  Future<ThemeMode?> _getThemeMode() async {
    final themeModeIndex = await StorageService.getSetting<int>('themeMode');
    if (themeModeIndex != null) {
      return ThemeMode.values[themeModeIndex];
    }
    return null;
  }

  Future<InterfaceMode?> _getInterfaceMode() async {
    final interfaceModeIndex = await StorageService.getSetting<int>('interfaceMode');
    if (interfaceModeIndex != null) {
      return InterfaceMode.values[interfaceModeIndex];
    }
    return null;
  }

  Future<ButtonStyle?> _getButtonStyle() async {
    final buttonStyleIndex = await StorageService.getSetting<int>('buttonStyle');
    if (buttonStyleIndex != null) {
      return ButtonStyle.values[buttonStyleIndex];
    }
    return null;
  }

  Future<Color?> _getPrimaryColor() async {
    final colorValue = await StorageService.getSetting<int>('primaryColor');
    if (colorValue != null) {
      return Color(colorValue);
    }
    return null;
  }

  Future<Color?> _getAccentColor() async {
    final colorValue = await StorageService.getSetting<int>('accentColor');
    if (colorValue != null) {
      return Color(colorValue);
    }
    return null;
  }

  Future<void> updateLanguage(String language) async {
    state = state.copyWith(language: language);
    await _saveSettings();
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await _saveSettings();
  }

  Future<void> updateFontFamily(String fontFamily) async {
    state = state.copyWith(fontFamily: fontFamily);
    await _saveSettings();
  }

  Future<void> updateTextScale(double textScale) async {
    state = state.copyWith(textScale: textScale);
    await _saveSettings();
  }

  Future<void> updateMusicVolume(double volume) async {
    state = state.copyWith(musicVolume: volume);
    await _saveSettings();
  }

  Future<void> updateEffectsVolume(double volume) async {
    state = state.copyWith(effectsVolume: volume);
    await _saveSettings();
  }

  Future<void> updateNarrationVolume(double volume) async {
    state = state.copyWith(narrationVolume: volume);
    await _saveSettings();
  }

  Future<void> updateEnableAnimations(bool enable) async {
    state = state.copyWith(enableAnimations: enable);
    await _saveSettings();
  }

  Future<void> updateEnableVibration(bool enable) async {
    state = state.copyWith(enableVibration: enable);
    await _saveSettings();
  }

  Future<void> updateEnableNarration(bool enable) async {
    state = state.copyWith(enableNarration: enable);
    await _saveSettings();
  }

  Future<void> updateShowTextDuringNarration(bool show) async {
    state = state.copyWith(showTextDuringNarration: show);
    await _saveSettings();
  }

  Future<void> updatePreferredVoiceId(String voiceId) async {
    state = state.copyWith(preferredVoiceId: voiceId);
    await _saveSettings();
  }

  Future<void> updateVoiceSpeed(double speed) async {
    state = state.copyWith(voiceSpeed: speed);
    await _saveSettings();
  }

  Future<void> updateEnableAI(bool enable) async {
    state = state.copyWith(enableAI: enable);
    await _saveSettings();
  }

  Future<void> updateEnableOnlineFeatures(bool enable) async {
    state = state.copyWith(enableOnlineFeatures: enable);
    await _saveSettings();
  }

  Future<void> updateInterfaceMode(InterfaceMode mode) async {
    state = state.copyWith(interfaceMode: mode);
    await _saveSettings();
  }

  Future<void> updatePrimaryColor(Color color) async {
    state = state.copyWith(primaryColor: color);
    await _saveSettings();
  }

  Future<void> updateAccentColor(Color color) async {
    state = state.copyWith(accentColor: color);
    await _saveSettings();
  }

  Future<void> updateButtonStyle(ButtonStyle style) async {
    state = state.copyWith(buttonStyle: style);
    await _saveSettings();
  }

  Future<void> updateSettings(UserSettings settings) async {
    state = settings;
    await _saveSettings();
  }

  Future<void> resetToDefaults() async {
    state = const UserSettings();
    await _saveSettings();
  }

  Future<void> _saveSettings() async {
    // Save individual settings
    await StorageService.saveSetting('language', state.language);
    await StorageService.saveSetting('themeMode', state.themeMode.index);
    await StorageService.saveSetting('fontFamily', state.fontFamily);
    await StorageService.saveSetting('textScale', state.textScale);
    await StorageService.saveSetting('musicVolume', state.musicVolume);
    await StorageService.saveSetting('effectsVolume', state.effectsVolume);
    await StorageService.saveSetting('narrationVolume', state.narrationVolume);
    await StorageService.saveSetting('enableAnimations', state.enableAnimations);
    await StorageService.saveSetting('enableVibration', state.enableVibration);
    await StorageService.saveSetting('enableNarration', state.enableNarration);
    await StorageService.saveSetting('showTextDuringNarration', state.showTextDuringNarration);
    await StorageService.saveSetting('preferredVoiceId', state.preferredVoiceId);
    await StorageService.saveSetting('voiceSpeed', state.voiceSpeed);
    await StorageService.saveSetting('enableAI', state.enableAI);
    await StorageService.saveSetting('enableOnlineFeatures', state.enableOnlineFeatures);
    await StorageService.saveSetting('interfaceMode', state.interfaceMode.index);
    await StorageService.saveSetting('primaryColor', state.primaryColor.value);
    await StorageService.saveSetting('accentColor', state.accentColor.value);
    await StorageService.saveSetting('buttonStyle', state.buttonStyle.index);

    // Also update the current user profile if logged in
    final currentProfile = await StorageService.getCurrentUserProfile();
    if (currentProfile != null) {
      final updatedProfile = currentProfile.copyWith(settings: state);
      await StorageService.saveUserProfile(updatedProfile);
    }
  }
}

extension UserSettingsX on UserSettings {
  UserSettings copyWith({
    String? language,
    ThemeMode? themeMode,
    String? fontFamily,
    double? textScale,
    double? musicVolume,
    double? effectsVolume,
    double? narrationVolume,
    bool? enableAnimations,
    bool? enableVibration,
    bool? enableNarration,
    bool? showTextDuringNarration,
    String? preferredVoiceId,
    double? voiceSpeed,
    bool? enableAI,
    bool? enableOnlineFeatures,
    InterfaceMode? interfaceMode,
    Color? primaryColor,
    Color? accentColor,
    ButtonStyle? buttonStyle,
  }) {
    return UserSettings(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      fontFamily: fontFamily ?? this.fontFamily,
      textScale: textScale ?? this.textScale,
      musicVolume: musicVolume ?? this.musicVolume,
      effectsVolume: effectsVolume ?? this.effectsVolume,
      narrationVolume: narrationVolume ?? this.narrationVolume,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      enableVibration: enableVibration ?? this.enableVibration,
      enableNarration: enableNarration ?? this.enableNarration,
      showTextDuringNarration: showTextDuringNarration ?? this.showTextDuringNarration,
      preferredVoiceId: preferredVoiceId ?? this.preferredVoiceId,
      voiceSpeed: voiceSpeed ?? this.voiceSpeed,
      enableAI: enableAI ?? this.enableAI,
      enableOnlineFeatures: enableOnlineFeatures ?? this.enableOnlineFeatures,
      interfaceMode: interfaceMode ?? this.interfaceMode,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }
}

// Helper providers for easy access to specific settings
@riverpod
Locale currentLocale(CurrentLocaleRef ref) {
  final settings = ref.watch(settingsProvider);
  return settings.locale;
}

@riverpod
bool animationsEnabled(AnimationsEnabledRef ref) {
  final settings = ref.watch(settingsProvider);
  return settings.enableAnimations;
}

@riverpod
bool aiEnabled(AiEnabledRef ref) {
  final settings = ref.watch(settingsProvider);
  return settings.enableAI;
}

@riverpod
bool onlineFeaturesEnabled(OnlineFeaturesEnabledRef ref) {
  final settings = ref.watch(settingsProvider);
  return settings.enableOnlineFeatures;
}