import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'story.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class UserProfile extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String email;
  
  @HiveField(3)
  final String? avatarUrl;
  
  @HiveField(4)
  final String? avatarPath;
  
  @HiveField(5)
  final DateTime createdAt;
  
  @HiveField(6)
  final DateTime lastLoginAt;
  
  @HiveField(7)
  final List<String> favoriteStoryIds;
  
  @HiveField(8)
  final Map<String, int> storyProgress;
  
  @HiveField(9)
  final List<Achievement> achievements;
  
  @HiveField(10)
  final UserSettings settings;
  
  @HiveField(11)
  final AccountType accountType;
  
  @HiveField(12)
  final AgeGroup ageGroup;
  
  @HiveField(13)
  final String? parentEmail;
  
  @HiveField(14)
  final bool isParentalControlsEnabled;
  
  @HiveField(15)
  final List<String> blockedContent;
  
  @HiveField(16)
  final int totalStoriesCreated;
  
  @HiveField(17)
  final int totalStoriesCompleted;
  
  @HiveField(18)
  final Duration totalPlayTime;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.avatarPath,
    required this.createdAt,
    required this.lastLoginAt,
    this.favoriteStoryIds = const [],
    this.storyProgress = const {},
    this.achievements = const [],
    required this.settings,
    this.accountType = AccountType.child,
    this.ageGroup = AgeGroup.all,
    this.parentEmail,
    this.isParentalControlsEnabled = true,
    this.blockedContent = const [],
    this.totalStoriesCreated = 0,
    this.totalStoriesCompleted = 0,
    this.totalPlayTime = Duration.zero,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? avatarPath,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    List<String>? favoriteStoryIds,
    Map<String, int>? storyProgress,
    List<Achievement>? achievements,
    UserSettings? settings,
    AccountType? accountType,
    AgeGroup? ageGroup,
    String? parentEmail,
    bool? isParentalControlsEnabled,
    List<String>? blockedContent,
    int? totalStoriesCreated,
    int? totalStoriesCompleted,
    Duration? totalPlayTime,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarPath: avatarPath ?? this.avatarPath,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      favoriteStoryIds: favoriteStoryIds ?? this.favoriteStoryIds,
      storyProgress: storyProgress ?? this.storyProgress,
      achievements: achievements ?? this.achievements,
      settings: settings ?? this.settings,
      accountType: accountType ?? this.accountType,
      ageGroup: ageGroup ?? this.ageGroup,
      parentEmail: parentEmail ?? this.parentEmail,
      isParentalControlsEnabled: isParentalControlsEnabled ?? this.isParentalControlsEnabled,
      blockedContent: blockedContent ?? this.blockedContent,
      totalStoriesCreated: totalStoriesCreated ?? this.totalStoriesCreated,
      totalStoriesCompleted: totalStoriesCompleted ?? this.totalStoriesCompleted,
      totalPlayTime: totalPlayTime ?? this.totalPlayTime,
    );
  }

  bool isFavorite(String storyId) => favoriteStoryIds.contains(storyId);

  int getStoryProgress(String storyId) => storyProgress[storyId] ?? 0;

  bool hasAchievement(String achievementId) =>
      achievements.any((achievement) => achievement.id == achievementId);

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatarUrl,
        avatarPath,
        createdAt,
        lastLoginAt,
        favoriteStoryIds,
        storyProgress,
        achievements,
        settings,
        accountType,
        ageGroup,
        parentEmail,
        isParentalControlsEnabled,
        blockedContent,
        totalStoriesCreated,
        totalStoriesCompleted,
        totalPlayTime,
      ];
}

@HiveType(typeId: 9)
@JsonSerializable()
class UserSettings extends Equatable {
  @HiveField(0)
  final String language;
  
  @HiveField(1)
  final ThemeMode themeMode;
  
  @HiveField(2)
  final String fontFamily;
  
  @HiveField(3)
  final double textScale;
  
  @HiveField(4)
  final double musicVolume;
  
  @HiveField(5)
  final double effectsVolume;
  
  @HiveField(6)
  final double narrationVolume;
  
  @HiveField(7)
  final bool enableAnimations;
  
  @HiveField(8)
  final bool enableVibration;
  
  @HiveField(9)
  final bool enableNarration;
  
  @HiveField(10)
  final bool showTextDuringNarration;
  
  @HiveField(11)
  final String preferredVoiceId;
  
  @HiveField(12)
  final double voiceSpeed;
  
  @HiveField(13)
  final bool enableAI;
  
  @HiveField(14)
  final bool enableOnlineFeatures;
  
  @HiveField(15)
  final InterfaceMode interfaceMode;
  
  @HiveField(16)
  final Color primaryColor;
  
  @HiveField(17)
  final Color accentColor;
  
  @HiveField(18)
  final ButtonStyle buttonStyle;

  const UserSettings({
    this.language = 'en',
    this.themeMode = ThemeMode.system,
    this.fontFamily = 'FairyTale',
    this.textScale = 1.0,
    this.musicVolume = 0.7,
    this.effectsVolume = 0.8,
    this.narrationVolume = 0.9,
    this.enableAnimations = true,
    this.enableVibration = true,
    this.enableNarration = true,
    this.showTextDuringNarration = true,
    this.preferredVoiceId = '',
    this.voiceSpeed = 1.0,
    this.enableAI = true,
    this.enableOnlineFeatures = true,
    this.interfaceMode = InterfaceMode.child,
    this.primaryColor = Colors.purple,
    this.accentColor = Colors.pink,
    this.buttonStyle = ButtonStyle.rounded,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);

  Locale get locale => Locale(language.split('_')[0], language.split('_').length > 1 ? language.split('_')[1] : '');

  @override
  List<Object?> get props => [
        language,
        themeMode,
        fontFamily,
        textScale,
        musicVolume,
        effectsVolume,
        narrationVolume,
        enableAnimations,
        enableVibration,
        enableNarration,
        showTextDuringNarration,
        preferredVoiceId,
        voiceSpeed,
        enableAI,
        enableOnlineFeatures,
        interfaceMode,
        primaryColor,
        accentColor,
        buttonStyle,
      ];
}

@HiveType(typeId: 10)
@JsonSerializable()
class Achievement extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final String iconUrl;
  
  @HiveField(4)
  final DateTime unlockedAt;
  
  @HiveField(5)
  final int points;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.unlockedAt,
    this.points = 10,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  @override
  List<Object?> get props => [id, title, description, iconUrl, unlockedAt, points];
}

@HiveType(typeId: 11)
enum AccountType {
  @HiveField(0)
  child,
  
  @HiveField(1)
  parent,
  
  @HiveField(2)
  teacher,
  
  @HiveField(3)
  admin,
}

@HiveType(typeId: 12)
enum InterfaceMode {
  @HiveField(0)
  child, // Simple, large buttons, bright colors
  
  @HiveField(1)
  advanced, // More features, compact layout
  
  @HiveField(2)
  accessibility, // High contrast, large text
}

@HiveType(typeId: 13)
enum ButtonStyle {
  @HiveField(0)
  rounded,
  
  @HiveField(1)
  square,
  
  @HiveField(2)
  circular,
  
  @HiveField(3)
  outlined,
}